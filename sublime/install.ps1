$SUBLIME_DIR = "$ENV:UserProfile\Sublime"
$PACKAGES_DIR = "$ENV:AppData\Sublime Text 3\Packages"

function clone_or_update($project)
{
    $github = "https://github.com/trflynn89"

    if (Test-Path -Path $SUBLIME_DIR\$project)
    {
        git -C $SUBLIME_DIR\$project pull

        if ($LASTEXITCODE)
        {
            echo "Could not update $project"
            exit 1
        }
    }
    else
    {
        git clone $github/$project.git $SUBLIME_DIR\$project

        if ($LASTEXITCODE)
        {
            echo "Could not clone $project"
            exit 1
        }
    }
}

function make_link($source, $dest, $is_file)
{
    $source = "$SUBLIME_DIR\$source"
    $dest = "$PACKAGES_DIR\$dest"

    if (Test-Path -Path $dest)
    {
        if ($is_file)
        {
            cmd /c del $dest
        }
        else
        {
            cmd /c rmdir $dest
        }
    }

    if ($is_file)
    {
        cmd /c mklink $dest $source
    }
    else
    {
        cmd /c mklink /J $dest $source
    }
}

clone_or_update dotfiles
clone_or_update Packages
clone_or_update Seti_UI

make_link "dotfiles\sublime\Preferences.sublime-settings" "User\Preferences.sublime-settings" 1

make_link "dotfiles\sublime\Flynn" "Flynn" 0
make_link "dotfiles\sublime\MIB" "MIB" 0
make_link "dotfiles\sublime\YANG" "YANG" 0

make_link "Packages\C++" "C++" 0
make_link "Packages\Makefile2" "Makefile" 0

make_link "Seti_UI" "Seti_UI" 0
