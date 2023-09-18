func="$1"
pwd=$(dirname "$BASH_SOURCE")
dir=$(dirname "$pwd")/gfunc/$func/old
output=$dir/function-source.zip

funcinfo=$(gcloud functions describe $func --format=json)
sc=$(jq '.buildConfig.source.storageSource' <<< $funcinfo)
bucket=$(jq -r '.bucket' <<< $sc )
object=$(jq -r '.object' <<< $sc )
url="gs://$bucket/$object"
gcloud storage cp $url $output

unzip $output -d $dir
rm $output