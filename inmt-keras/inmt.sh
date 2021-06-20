#!/bin/bash

####################
## Default values ##
####################
export prefix=0
export dataset=''
export src=''
export ref=''
export model=''
export hyp=''
export log=''

#####################
## Parse arguments ##
#####################
while getopts ":d:s:r:m:h:l:p" opt; do
    case ${opt} in
	d )
	    export dataset="$OPTARG"
	    ;;
	s )
	    export src="$OPTARG"
	    ;;
	r )
	    export ref="$OPTARG"
	    ;;
	m )
	    export model="$OPTARG"
	    ;;
	h )
	    export hyp="$OPTARG"
	    ;;
  l )
	    export log="$OPTARG"
	    ;;
  p )
	    export prefix=1
	    ;;
	\? )
	    >&2 echo "Usage: $0 -d dataset.pkl -s src_file -r ref_file -m model -h hyp_file -l log {options}"
	    >&2 echo "options:"
	    >&2 echo "     -p: Use prefix-based approach. (Default: segment-based approach.)"
	    exit 1
	    ;;
    esac
done

if [[ ${dataset} == '' || ${src} == '' || ${ref} == '' || ${model} == '' || ${hyp} == '' || ${log} == '' ]]
then
  >&2 echo "Usage: $0 -d dataset.pkl -s src_file -r ref_file -m model -h hyp_file -l log {options}"
  >&2 echo "options:"
  >&2 echo "     -p: Use prefix-based approach. (Default: segment-based approach.)"
  exit 1
fi

export PATH="/opt/miniconda/bin:$PATH"
export LD_LIBRARY_PATH=/usr/local/cuda/lib64

if [[ ${prefix} -eq 1 ]]
then
  python /opt/nmt-keras/interactive_nmt_simulation.py -ds ${dataset} -src ${src} -trg ${ref} --models ${model} --prefix -d ${hyp} &> ${log}
else
  python /opt/nmt-keras/interactive_nmt_simulation.py -ds ${dataset} -src ${src} -trg ${ref} --models ${model} -d ${hyp} &> ${log}
fi
