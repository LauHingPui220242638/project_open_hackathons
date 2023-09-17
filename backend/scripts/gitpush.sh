#!/bin/bash
m="$1"
git push
git add -A
git commit -m "$m"
