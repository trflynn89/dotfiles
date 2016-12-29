;;;;; INIT ;;;;;
#SingleInstance force
#NoEnv						; Better for compatibility w/ future releases
SendMode Input				; Improve speed and reliability
SetWorkingDir %A_ScriptDir%	; Ensure consistent starting dir

;;;;;; MONITOR ;;;;;
Pause::
	Sleep 500				; Wait a bit so this press doesn't wake monitor
	SendMessage 0x112, 0xF170, 2,,Program Manager

;;;;; VOLUME ;;;;;
~LButton & WheelUp:: Send {Volume_Up 1}
~LButton & WheelDown:: Send {Volume_Down 1}

;;;;; PLAYBACK DEVICE ;;;;;
^+a::
	Run, mmsys.cpl

	WinWait, Sound
	ControlSend, SysListView321, {Down}
	ControlGet, isEnabled, Enabled, , &Set Default

	if (!isEnabled)
	{
		ControlSend, SysListView321, {Down 2}
	}

	ControlClick, &Set Default
	ControlClick, OK

	WinWaitClose
	return
