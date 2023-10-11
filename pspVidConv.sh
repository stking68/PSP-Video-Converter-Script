echo "Give Output Foldername"
read outName
mkdir "$outName"-PSPReady
mkdir tmp
for i in *.mkv
do
  epNum=`echo $i| egrep -o "[0-9]+" | head -1`
  ffmpeg  -i "$i" tmp/"$outName"_$epNum-PSPReady.ass
  ffmpeg -y -i "$i" -flags +bitexact -vcodec libx264 -profile:v baseline -level 3.0 -s 480x272 -b:v 1m -acodec aac -b:a 128k -ar 48000 -strict -2 -filter:v subtitles=tmp/"$outName"_$epNum-PSPReady.ass:force_style='Fontsize=0' "$outName"-PSPReady/"$outName"_$epNum-PSPReady.MP4
  ffmpeg -i "$i" -f image2 -ss 5 -vframes 1 -s 160x120  "$outName"-PSPReady/"$outName"_$epNum-PSPReady.THM
done

rm -rf tmp
