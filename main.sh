#!/bin/bash

set -xv
set -e

ref_fa=${1}
tumor_bam=${2}
normal_bam=${3}
control_bam_1=${4}
control_bam_2=${5}
control_bam_3=${6}
control_bam_4=${7}
eb_result=${8}

fisher comparison -o /var/fisher_result.txt --ref_fa ${ref_fa} --samtools_path /bin/samtools -1 ${tumor_bam} -2 ${normal_bam} --min_depth 8 --base_quality 15 --min_variant_read 4 --min_allele_freq 0.02 --max_allele_freq 0.1 --fisher_value 0.1 --samtools_params "-q 20 -BQ0 -d 10000000 --ff UNMAP,SECONDARY,QCFAIL,DUP" 

python /bin/ctrl_panel_list.py /var/ctrl_bam_list.txt ${control_bam_1} ${control_bam_2} ${control_bam_3} ${control_bam_4}

EBFilter --loption -f anno -q 20 -Q 15 --ff UNMAP,SECONDARY,QCFAIL,DUP /var/fisher_result.txt ${tumor_bam} /var/ctrl_bam_list.txt ${eb_result}

