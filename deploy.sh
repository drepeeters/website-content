# #!/usr/bin/env bash

# Break build on error, prevents websites going offline in case of pelican errors
set -e

echo "Starting Pelican build of $WEBSITE"
cd $WEBSITE

# if [[ $WEBSITE == 'website-pathology' ]] || [[ $WEBSITE == 'website-diag' ]] || [[ $WEBSITE == 'website-neuro' ]]; then
#   # Init repo
#   echo "Cloning ${website} output repository"
#   git clone --depth 1 "https://${GH_PAGES}@github.com/DIAGNijmegen/${website}.git" output
# else
#   echo "Website ($WEBSITE) not in deploy pilot, using clean directory."
# fi

# Build pelican website
pelican content -s publishconf.py

# Copy files for github
cp README.md output/README.md
cp .nojekyll output/.nojekyll

# Remove individual calendar events
# These pages are generated by Pelican but we want them displayed on the website
# as individual files. Only the calendar overview has to be shown.
if [[ -d output/calendar ]]; then
  (cd output/calendar && ls | grep -v index.html | xargs rm -rf)
fi

# Push to github
# if [[ $WEBSITE == 'website-pathology' ]] || [[ $WEBSITE == 'website-diag' ]] || [[ $WEBSITE == 'website-neuro' ]]; then
#   cp CNAME output/CNAME
#
#   cd output
#   git add .
#   git status
#
#   gitdiff='git diff-index --quiet HEAD .'
#   if ! $gitdiff; then
#     echo "Files changed, commiting new images."
#     git commit --message "Pushing new version of ${website}" -- .
#     git push "https://${GH_PAGES}@github.com/DIAGNijmegen/${website}.git" "master"
#   else
#     echo "Nothing new to commit, skipping push."
#   fi
#
#   cd ..
# else
#   echo "Website ($WEBSITE) not in deploy pilot, using clean directory."
# fi

# Go back to root directory
cd ..
