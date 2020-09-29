$SUBLIME_DIR = "$ENV:UserProfile\Sublime"
$PACKAGES_DIR = "$ENV:AppData\Sublime Text 3\Packages"

function Remove-Path($path)
{
    if (Test-Path -Path $path -PathType Container)
    {
        if ((Get-Item -Path $path -Force).LinkType -ne 'Junction')
        {
            Get-ChildItem $path -Force -Recurse | Remove-Item -Force -Recurse
        }

        Remove-Item -Force -Recurse $path
    }
    elseif (Test-Path -Path $path -PathType Leaf)
    {
        Remove-Item -Force $path
    }
}

function Clone($project)
{
    $github = "https://github.com/trflynn89"

    $project_directory = "$SUBLIME_DIR\$project"
    $clone_directory = "$project_directory.tmp"

    Remove-Path $clone_directory
    git clone $github/$project.git $clone_directory

    if ($LASTEXITCODE)
    {
        echo "Could not fetch $project"
        exit 1
    }

    Remove-Path $project_directory
    Move-Item -Path $clone_directory -Destination $project_directory
}

function Make-Link($source, $dest)
{
    $source = "$SUBLIME_DIR\$source"

    if ($dest -ne $null)
    {
        $dest = "$PACKAGES_DIR\$dest"
    }
    else
    {
        $dest = Split-Path -Path $source -Leaf
        $dest = "$PACKAGES_DIR\$dest"
    }

    Remove-Path $dest

    if (Test-Path -Path $source -PathType Leaf)
    {
        New-Item -ItemType SymbolicLink -Path $dest -Target $source
    }
    else
    {
        New-Item -ItemType Junction -Path $dest -Target $source
    }
}

Clone dotfiles
Clone Packages
Clone Seti_UI

Make-Link "dotfiles\sublime\Preferences.sublime-settings" "User\Preferences.sublime-settings"
Make-Link "dotfiles\sublime\LSP.sublime-settings" "User\LSP.sublime-settings"
Make-Link "dotfiles\sublime\Preferences (Windows).sublime-settings"

Make-Link "dotfiles\sublime\Flynn"
Make-Link "dotfiles\sublime\MIB"
Make-Link "dotfiles\sublime\YANG"
Make-Link "dotfiles\sublime\GN"

Make-Link "Packages\C++"
Make-Link "Packages\Objective-C"
Make-Link "Packages\Makefile"
Make-Link "Packages\Java"

Make-Link "Seti_UI"
