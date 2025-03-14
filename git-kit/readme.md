1. `git reset <mode> <commit>`  

    `mode`
    - `--hard` Discards all changes (working directory, staging area, commit history).
    - `--soft` Resets commit history, keeps changes staged.
    - `--mixed` Resets commit history, keeps changes unstaged. (Default behavior)

2. `git reset <filename>`  
    - Unstage: Removes the file from the staging area.  
    - Keep changes: The changes remain in your working directory.  
    - Keep track: The file is still tracked by Git (it’s still part of the repository).  

3. `git rm --cached <filename>`
    - Unstage: Removes the file from the staging area.  
    - Keep changes: The file remains in your working directory.  
    - Untrack: The file is no longer tracked by Git (it's removed from version control).  