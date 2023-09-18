func="$1"
pwd=$(dirname "$BASH_SOURCE")
dir=$(dirname "$pwd")/gfunc/$func
source=$dir/source/
output=$dir/new/function-source.zip

zip -r $output $source 