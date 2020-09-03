service_list="google"
testset_list="20200903"
max_num_utts=10000

#----------------------------
export TEST_ENV=`greadlink -f ~/work/git/ps_check/test_env`
export COMPUTE_WER=`greadlink -f ~/work/kaldi/src/bin/compute-wer`
export ALIGN_TEXT=`greadlink -f ~/work/kaldi/src/bin/align-text`

date=`date +%Y%m%d`
RESULT=${TEST_ENV}/result
DATASET=${TEST_ENV}/dataset

mkdir -p $RESULT

for y in $testset_list; do
    for x in $service_list; do
        echo "==>Testing Service:$x TEST_SET:$y DATE:$date NUM_UTTS:$max_num_utts"
        cd service/$x
        job=${date}__${x}__${y}__${max_num_utts}
        mkdir -p $RESULT/$job
        nohup sh ${TEST_ENV}/utils/test.sh $max_num_utts $DATASET/$y $RESULT/$job >& $RESULT/$job/log.test &
        sleep 3.0
        cd -
    done
    wait
done
echo "Done"

