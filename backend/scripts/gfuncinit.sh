func="$1"
root=/workspaces/project_open_hackathons
pwd=$PWD
sd=$root/$(dirname "${BASH_SOURCE[0]}")

dir=$(dirname "$sd")/gfunc/
cd $dir

SCRIPT=$(realpath "$0")
echo $SCRIPT 
# mkdir $func
# cd $func
# mkdir new old source
# cd $pwd