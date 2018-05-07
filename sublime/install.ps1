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

clone_or_update dotfiles
clone_or_update Packages
clone_or_update Seti_UI

cmd /c mklink "$PACKAGES_DIR\User\Preferences.sublime-settings" $SUBLIME_DIR\dotfiles\sublime\Preferences.sublime-settings

cmd /c mklink /D "$PACKAGES_DIR\Flynn" $SUBLIME_DIR\dotfiles\sublime\Flynn
cmd /c mklink /D "$PACKAGES_DIR\MIB" $SUBLIME_DIR\dotfiles\sublime\MIB
cmd /c mklink /D "$PACKAGES_DIR\YANG" $SUBLIME_DIR\dotfiles\sublime\YANG

cmd /c mklink /D "$PACKAGES_DIR\C++" $SUBLIME_DIR\Packages\C++
cmd /c mklink /D "$PACKAGES_DIR\Makefile" $SUBLIME_DIR\Packages\Makefile2

cmd /c mklink /D "$PACKAGES_DIR\Seti_UI" $SUBLIME_DIR\Seti_UI
