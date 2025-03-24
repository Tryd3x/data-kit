`git reset <mode> <commit>`  

    `mode`
    - `--hard` Discards all changes (working directory, staging area, commit history, rewrites it).
    - `--soft` Resets commit history, keeps changes staged.
    - `--mixed` Resets commit history, keeps changes unstaged. (Default behavior)

`git reset <filename>`  
    - Unstage: Removes the file from the staging area.  
    - Keep changes: The changes remain in your working directory.  
    - Keep track: The file is still tracked by Git (it’s still part of the repository).  

`git rm --cached <filename>`  
    - Unstage: Removes the file from the staging area.  
    - Keep changes: The file remains in your working directory.  
    - Untrack: The file is no longer tracked by Git (it's removed from version control).  

`git reset HEAD^`  
    - Unstage the last commit and put changes in the working directory
    - Basically going backwards in the commit history and discarding it.


## Types of merge

- Fast-Forward merge
✅ Pros: Simple, no extra merge commit.  
❌ Cons: Doesn't show a clear feature branch merge.
``` 
git checkout main
git merge feature-branch
```
```
Before:  
A---B---C  (main)  
         \  
          D---E  (feature)  

After Fast-Forward Merge:  
A---B---C---D---E  (main, feature)
```
- Three-Way Merge (Default)
✅ Pros: Retains full history of both branches.  
❌ Cons: Creates an extra merge commit (M).
```
git checkout main
git merge feature-branch

```
```
Before:  
A---B---C  (main)  
 \     
  D---E---F  (feature)  

After Merge:
A---B---C---M  (main)
 \         /
  D---E---F  (feature)
```
- Rebase (History Rewrite for a Clean Linear History) 
✅ Pros: Linear, clean commit history.  
❌ Cons: Rewrites history, potential conflicts.
```
git checkout feature-branch
git rebase main
```
Then merge normally:
```
git checkout main
git merge feature-branch
```
```
Before Rebase:
A---B---C  (main)
 \    
  D---E---F  (feature)

After Rebase:
A---B---C---D'---E'---F'  (feature)
```