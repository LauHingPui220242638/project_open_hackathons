#!/bin/bash
m="$1"
git fetch
git add -A
git commit -m "$m"
git push
