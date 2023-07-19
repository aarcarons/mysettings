# These functions are loaded in .zshrc

export SC_SOURCE_CODE_ROOT=~/source/soundcloud/

# Update repos cache if needed
# Trigger an asynchronous update if cache is too old
# Trigger a synchronous update if no cache
update_cache_maybe ()
{
    if [ ! -f ~/.repos.txt ]; then
        echo "Repo cache not found, please wait until repo cache is loaded";
        list_repos
    elif test $(find ~/.repos.txt -mtime +9); then
        echo "Triggering asynchronous update of git repos";
        list_repos &
    fi
}

gsc ()
{
    local repo=$1;
    update_cache_maybe || return
    if [ -z "$repo" ]; then
        if ! repo=$(peco --on-cancel error ~/.repos.txt); then
            echo "Error: Peco failed or cancelled"
            return
        fi
        repo=$(echo "$repo" | cut -d' ' -f1)
    fi
    if ! [[ -d "$SC_SOURCE_CODE_ROOT/$repo" ]]; then
        cd "$SC_SOURCE_CODE_ROOT" || return;
        git clone "git@github.com:soundcloud/$repo.git" || return;
    fi;
    cd "$SC_SOURCE_CODE_ROOT/$repo" || exit
}
