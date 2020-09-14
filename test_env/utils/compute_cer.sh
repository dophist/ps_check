if [ $# -ne 1 ]; then
  echo "compute_cer.sh <result_dir>"
  echo "e.g.: sh resut/20200831_xxxxxx_1000"
  echo "assume raw_rec.txt and trans.txt in result_dir"
  exit 1;
fi

dir=$1

echo "-- <preparing reference"
#replace folloing line with more sophisticated ENGLISH TN
cat $dir/trans.txt | $TEST_ENV/utils/tn.py > $dir/ref.txt
echo "-- done>"

echo "-- <preparing recognition text"
#replace folloing line with more sophisticated ENGLISH TN
cat $dir/raw_rec.txt | $TEST_ENV/utils/tn.py > $dir/rec.txt
grep -v $'\t$' $dir/rec.txt > $dir/rec_present.txt # filter away empty recognition result
echo "-- done>"

echo "-- <computing CER and text alignment"
$COMPUTE_WER --mode=present --text=true ark,t:$dir/ref.txt ark,t:$dir/rec.txt >& $dir/CER
$ALIGN_TEXT ark,t:$dir/ref.txt ark,t:$dir/rec.txt ark,t:$dir/ALIGN >& $dir/log.align

$COMPUTE_WER --mode=present --text=true ark,t:$dir/ref.txt ark,t:$dir/rec_present.txt >& $dir/CER_present
$ALIGN_TEXT ark,t:$dir/ref.txt ark,t:$dir/rec_present.txt ark,t:$dir/ALIGN_present >& $dir/log.align_present
echo "-- done>"

echo "============================"
cat $dir/CER | sed -e "s:\%WER:\%CER:g"
echo "============================"
echo "============================"
cat $dir/CER_present | sed -e "s:\%WER:\%CER:g"
echo "============================"
