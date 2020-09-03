if [ $# -ne 3 ]; then
  echo "test.sh <max_num_utts> <testset_dir> <result_dir>"
  echo "e.g.: sh test.sh 5000 TESTSET_201910 RES_201910"
  echo "  assume wav.scp trans.txt in dataset_dir"
  exit 1;
fi

n=$1
testset=`greadlink -f $2`
dir=$3

stage=0

if [ ! -f ${testset}/wav.scp ] || [ ! -f ${testset}/trans.txt ]; then
    echo "ERROR: missing wav.scp or trans.txt in test set"
    exit 1;
fi

mkdir -p $dir

echo "-- <subset max_num_utts & preparing wav list with abs paths & trans"
awk -v d=$testset '{print $1"\t"d"/"$2}' ${testset}/wav.scp | head -n $n > $dir/wav.scp
head -n $n ${testset}/trans.txt > $dir/trans.txt
echo "-- done>"

if [ $stage -le 9 ]; then
echo "-- <recognizing"
sh recognize.sh $dir/wav.scp $dir >& $dir/log.recognize
echo "-- done>"
fi

echo "-- <Getting cer"
sh ${TEST_ENV}/utils/compute_cer.sh $dir >& $dir/log.compute_cer
echo "-- done>"

echo "-- <Getting pretty alignment"
${TEST_ENV}/utils/prettify_align.py $dir/ALIGN_present $dir/ALIGN_pretty >& $dir/log.prettify_align
echo "-- done>"
