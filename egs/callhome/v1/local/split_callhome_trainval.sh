#!/bin/bash
# Copyright 2017   David Snyder
# Apache 2.0.
#
# This script prepares the Callhome portion of the NIST SRE 2000
# corpus (LDC2001S97). It is the evaluation dataset used in the
# callhome_diarization recipe.

if [ $# -ne 3 ]; then
  echo "Usage: $0 <callhome-speech> <out-data-dir>"
  echo "e.g.: $0 /mnt/data/LDC2001S97 data/"
  exit 1;
fi

src_dir=$1
data_dir=$2
num_ch1=$3

utils/validate_data_dir.sh --no-text --no-feats $data_dir/callhome
utils/fix_data_dir.sh $data_dir/callhome

utils/copy_data_dir.sh $data_dir/callhome $data_dir/callhome1
utils/copy_data_dir.sh $data_dir/callhome $data_dir/callhome2

utils/shuffle_list.pl $data_dir/callhome/wav.scp | head -n "$num_ch1" \
  | utils/filter_scp.pl - $data_dir/callhome/wav.scp \
  > $data_dir/callhome1/wav.scp
utils/fix_data_dir.sh $data_dir/callhome1
utils/filter_scp.pl --exclude $data_dir/callhome1/wav.scp \
  $data_dir/callhome/wav.scp > $data_dir/callhome2/wav.scp
utils/fix_data_dir.sh $data_dir/callhome2
utils/filter_scp.pl $data_dir/callhome1/wav.scp $data_dir/callhome/reco2num_spk \
  > $data_dir/callhome1/reco2num_spk
utils/filter_scp.pl $data_dir/callhome2/wav.scp $data_dir/callhome/reco2num_spk \
  > $data_dir/callhome2/reco2num_spk


