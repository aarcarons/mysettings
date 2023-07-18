# These functions are loaded in .zshrc

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
        # TODO: return from func if ESC is pressed in peco
        repo=$(peco ~/.repos.txt | cut -d' ' -f1)
    fi
    if ! [[ -d ~/Soundcloud/$repo ]]; then
        cd ~/Soundcloud;
        git clone git@github.com:soundcloud/$repo.git || return;
    fi;
    cd ~/Soundcloud/$repo
}
