The `.git_aliases` file is a snapshot of what is found [in this repo](https://github.com/GitAlias/gitalias). Follow the instructions there to install it

The rest can be sourced in your `.bash_profile` file:
```
source ~/mysettings/dotfiles/.bashrc_aliases
source ~/mysettings/dotfiles/.bashrc_prompt
```


# Git commands for my usual git workflows:

## Create feature branch from master, sync it with remote, close it.

### Workflow 1
1. `g topic-begin <feature-branch>` to start working on a new feature
2. `g topic-sync` pulls and pushes
3. `g topic-move` to rename the branch, also in remote

This workflow depends on the trunk branch being set
`g topic-base-branch master` once, if master is the trunk branch. Defaults to main.

### Workflow 2

1. `g co -b <branch_name>`
2. `g publish` to push to remote
   1. `g unpublish` to undo

## Prune local branches that are not tracked in remote
- `g hew-local` Delete all local branches that have been merged into a commit
- `g hew-local-dry-run` dry run version

## trigger ci:
* `g ca` to commit --amend
* `g push`

other interesting commands
* `g summary`
* `g churn`
* `g init-empty`
* `g grep-all` Find text in any commit ever.
* `g lsio` list files that git has ignored.
* `g ds` show staged changes (about to be committed)