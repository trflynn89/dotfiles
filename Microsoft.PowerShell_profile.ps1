function subl { & 'C:\Program Files\Sublime Text\subl.exe' $args }

function git-current-branch {
    return git rev-parse --abbrev-ref HEAD
}

function git-main-branch {
    $branches = @('main', 'master')

    foreach ($branch in $branches) {
        & git show-ref -q --verify refs/heads/$branch

        if ($LASTEXITCODE -eq 0) {
            return $branch
        }
    }
}

# PowerShell >= 6 already has a built-in `Remove-Alias`.
if ($PSVersionTable.PSVersion.Major -le 5) {
    function Remove-Alias ([string] $AliasName) {
        while (Test-Path Alias:$AliasName) {
            Remove-Item Alias:$AliasName -Force 2> $null
        }
    }
}

Remove-Alias gc -Force -ErrorAction SilentlyContinue
Remove-Alias gcb -Force -ErrorAction SilentlyContinue
Remove-Alias gcm -Force -ErrorAction SilentlyContinue

function gcb { git checkout -b $args }
function gbd { git branch -D $args }
function gba { git branch --all }

function gcm { git checkout $(git-main-branch) $args }
function gco { git checkout $args }
function gch { git checkout HEAD $args }

function glo { git log --oneline --decorate $args }

function gfa { git fetch --all --no-tags --prune --jobs=10 }
function gfp { git fetch origin --no-tags --prune }

function gfm { git fetch origin $(git-main-branch):$(git-main-branch) }
function gfu { git fetch upstream $(git-main-branch):$(git-main-branch) }

function gro { git rebase origin/$(git-main-branch) $args }
function gru { git rebase upstream/$(git-main-branch) $args }

function gd { git diff $args }
function gds { git diff --staged $args }
function gss { git status --short $args }

function ga { git add $args }
function gaa { git add --all $args }

function gc { git commit --verbose $args }
function gca { git commit --verbose --all $args }

function ggp { git push origin $(git-current-branch) }
function ggl { git pull origin $(git-current-branch) }
function glum { git pull upstream $(git-main-branch) }
