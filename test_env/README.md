# env:
    ensure python3, not 2

# setup:
* change working dir to your local setup in run.sh
* go to service/google
    - sh install.sh
* go to google speech cloud, activate google speech to text API, and download credential (a .json file), rename and move the credential file to test_env/service/google/TIOBE.json
* change text normalization to your own one, in test_env/utils/compute_cer.sh, don't change other resources' filename

# usage:
* prepare testing corpus, take test_env/dataset/20200903 as example, it is pretty standard kaldi format
* run test_env/run.sh

