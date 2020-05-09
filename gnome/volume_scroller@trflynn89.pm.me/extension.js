const Clutter = imports.gi.Clutter;
const Gio = imports.gi.Gio;
const Main = imports.ui.main;
const Volume = imports.ui.status.volume;

const VolumeScrollerIcons = [
    'audio-volume-muted-symbolic',
    'audio-volume-low-symbolic',
    'audio-volume-medium-symbolic',
    'audio-volume-high-symbolic'
];

class VolumeScroller
{
    constructor()
    {
       this.controller = Volume.getMixerControl();

       this.volume_max = this.controller.get_vol_max_norm();
       this.volume_step = 0.05 * this.volume_max;

       this.panel = Main.panel;
       this.binding = null;
    }

    enable()
    {
        this.panel.reactive = true;

        if (this.binding !== null)
        {
            this.disable();
        }

        this.binding = this.panel.actor.connect(
            'scroll-event',
            (actor, event) => this._handle_scroll(actor, event));
    }

    disable()
    {
        if (this.binding !== null)
        {
            this.panel.actor.disconnect(this.binding);
            this.binding = null;
        }
    }

    _handle_scroll(actor, event) {
        let volume = this.controller.get_default_sink().volume;

        switch (event.get_scroll_direction())
        {
            case Clutter.ScrollDirection.UP:
                volume += this.volume_step;
                break;

            case Clutter.ScrollDirection.DOWN:
                volume -= this.volume_step;
                break;

            default:
                return Clutter.EVENT_PROPAGATE;
        }

        volume = Math.min(volume, this.volume_max);
        volume = Math.max(volume, 0);

        this.controller.get_default_sink().volume = volume;
        this.controller.get_default_sink().push_volume();

        this._show_volume_osd(volume / this.volume_max);
        return Clutter.EVENT_STOP;
    }

    _show_volume_osd(percent) {
        let n;

        if (percent === 0) {
            n = 0;
        } else {
            n = parseInt(3 * percent + 1);
            n = Math.max(1, n);
            n = Math.min(3, n);
        }

        const icon = Gio.Icon.new_for_string(VolumeScrollerIcons[n]);
        Main.osdWindowManager.show(-1, icon, null, percent);
    }
};

let volume_scroller = null;

function init() {
    volume_scroller = new VolumeScroller();
}

function enable() {
    volume_scroller.enable();
}

function disable() {
    volume_scroller.disable();
}
