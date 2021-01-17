#! /bin/bash 

# targetPath=/run/user/1000/gvfs/mtp:host=Xiaomi_Mi_A1_2815045e0604
# backupPath=/home/vijay/Downloads/mobile_bac/sdcard/
targetPath=$HOME/Desktop/ScreenShot
backupPath=$HOME/Documents/ScreenShot

targetlistPath=/home/vijay/Desktop/targetFiles.txt
backuplistPath=/home/vijay/Desktop/backupFiles.txt

targetlistSortPath=/home/vijay/Desktop/targetFiles_sorted.txt
backuplistSortPath=/home/vijay/Desktop/backupFiles_sorted.txt

fileToBeCopiedListPath=$HOME/Desktop/files.txt

find $targetPath -type f -name "*" > $targetlistPath
find $backupPath -type f -name "*" > $backuplistPath

sort -o $targetlistSortPath $targetlistPath
sort -o $backuplistSortPath $backuplistPath



sed -i "s|$backupPath||" $backuplistSortPath
# sed -i "s|$targetPath/Internal shared storage/||" $targetlistSortPath
sed -i "s|$targetPath||" $targetlistSortPath


comm  -3 -1 $backuplistSortPath $targetlistSortPath > $fileToBeCopiedListPath
sed -i 's/ /\\ /g' $fileToBeCopiedListPath
sed -i "s|^|$targetPath|" $fileToBeCopiedListPath


while IFS= read -r line; do
    #   cp -ri "$line"  $backupPath
         printf '%s\n' "$line" | xargs cp -i -t $backupPath
done < "$fileToBeCopiedListPath"