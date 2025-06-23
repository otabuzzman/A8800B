for zip in part-*.zip ; do unzip -p $zip rawText.txt | cat - >$(basename $zip .zip).txt ; done
