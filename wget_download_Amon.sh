#!/bin/bash
experiment_ids=(historical)
variable_ids=(hfds psl tauu tauv hfls hfss pr rlds rlus rsds rsus cl ua va pr tas sfcWind hus)
#----------------------------------------------models and corresponding run
source_ids=(ACCESS-CM2
ACCESS-ESM1-5
AWI-CM-1-1-MR
AWI-ESM-1-1-LR
BCC-CSM2-MR
BCC-ESM1
CAMS-CSM1-0
CanESM5
CanESM5-1
CanESM5-CanOE
CAS-ESM2-0
CESM2
CESM2-FV2
CESM2-WACCM
CESM2-WACCM-FV2
CIESM
CMCC-CM2-HR4
CMCC-CM2-SR5
CMCC-ESM2
CNRM-CM6-1
CNRM-CM6-1-HR
CNRM-ESM2-1
E3SM-1-0
E3SM-1-1
E3SM-1-1-ECA
E3SM-2-0
E3SM-2-0-NARRM
EC-Earth3
EC-Earth3-AerChem
EC-Earth3-CC
EC-Earth3-Veg
EC-Earth3-Veg-LR
FGOALS-f3-L
FGOALS-g3
FIO-ESM-2-0
GFDL-CM4
GFDL-ESM4
GISS-E2-1-G
GISS-E2-1-G-CC
GISS-E2-1-H
GISS-E2-2-G
GISS-E2-2-H
HadGEM3-GC31-LL
HadGEM3-GC31-MM
ICON-ESM-LR
IITM-ESM
INM-CM4-8
INM-CM5-0
IPSL-CM5A2-INCA
IPSL-CM6A-LR
IPSL-CM6A-LR-INCA
KACE-1-0-G
KIOST-ESM
MCM-UA-1-0
MIROC6
MIROC-ES2H
MIROC-ES2L
MPI-ESM-1-2-HAM
MPI-ESM1-2-HR
MPI-ESM1-2-LR
MRI-ESM2-0
NESM3
NorCPM1
NorESM2-LM
NorESM2-MM
SAM0-UNICON
TaiESM1
UKESM1-0-LL
UKESM1-1-LL)

variant_labels=(r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p2f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f2
r1i1p1f2
r1i1p1f2
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f3
r1i1p1f3
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p4f2
r1i1p1f2
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f1
r1i1p1f2
r1i1p1f2)

num=${#variant_labels[*]}
((num--))

table_ids=(Amon)
frequencys=(mon)
realms=(atmos)

base="https://esgf-node.llnl.gov/esg-search/wget?distrib=true&latest=true&replica=true"

for experiment_id in ${experiment_ids[*]};do
for   variable_id in   ${variable_ids[*]};do
for      table_id in      ${table_ids[*]};do
for         realm in         ${realms[*]};do
for     frequency in     ${frequencys[*]};do
for m in `seq 0 ${num}`;do
    source_id=${source_ids[${m}]}
    variant_label=${variant_labels[${m}]}
    url="${base}&source_id=${source_id}&experiment_id=${experiment_id}&frequency=${frequency}&realm=${realm}&table_id=${table_id}&variant_label=${variant_label}&variable_id=${variable_id}"
    tim=`date "+%Y%m%d%H%M%S"`
    file="wgets/wget-${variable_id}-${table_id}-${source_id}-${experiment_id}-${variant_label}-${tim}.sh"
    echo "processing ... ${file}"
    wget -O - "$url" | grep -P "^(?!'(?!${variable_id}_)|'.*\.nc4)" 1>$file
    nwords=$(cat "$file" | wc -l)
    [ $nwords -le 1 ] && echo "No files found." && rm "$file"
    sleep 1
done
done
done
done
done
done
