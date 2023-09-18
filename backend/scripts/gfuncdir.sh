func="$1"
root=/workspaces/project_open_hackathons
pwd=$PWD
sd=$root/$(dirname "$BASH_SOURCE")

dir=$(dirname "$sd")/gfunc/
cd $dir
mkdir $func
cd $func
mkdir new old source
cd $pwd