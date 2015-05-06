# split a subdirectory of a larger repository into a new repository.

# We assume a repository foo that contains a folder foobar that shall be a new repository called bar.
git clone --no-hardlinks foo bar
cd bar
git filter-branch --subdirectory-filter foobar HEAD --all
git reflog expire --expire=now --all
git reset --hard
git gc --aggressive
git prune

# delete the old remote origin and set a new one.

git remote rm origin
git pull git@hithub.com:user/bar.git
git remote add origin git@hithub.com:user/bar.git
git push origin master

# cp ../foo/foobar/* . # copy other not tracked files over.

# clean up the original repository.
cd foo
git filter-branch --tree-filter “rm -rf foobar” --prune-empty HEAD
rm -rf foobar
git push -f
