#!/bin/bash
#----------------------------------------------------------------------------------------------------
#   The ESGF Search RESTful API:    https://earthsystemcog.org/projects/cog/esgf_search_restful_api
#   USEAGE:     http://<base_search_URL>/wget?[keyword parameters as (name, value) pairs][facet parameters as (name,value) pairs]
#   Example:    Download all obs4MIPs files from the JPL node with variable "hus" : 
#               http://esgf-node.jpl.nasa.gov/esg-search/wget?variable=hus&project=obs4MIPs&distrib=false
#----------------------------------------------------------------------------------------------------
#   View page source of https://esgf-node.llnl.gov/search/cmip6/ to find the keywords 
#           <input type='hidden' name='csrfmiddlewaretoken' value='NfURck7BuHVNt7iMVlFF43PBIhxT3bVxzBoO2czrAVwv8WoiLQiyi9vUhCDYXdnG' /> 
#           <input type="hidden" name="offset" value="0" />
#           <input type="hidden" name="limit" value="20" />
#           <input type="hidden" name="type" value="Dataset" />
#           <input type="hidden" name="product" value=""/>
#           <input type="hidden" name="variable_id" value=""/>          hus psl so ta thetao tos
#           <input type="hidden" name="realm" value=""/>                atmos ocean
#           <input type="hidden" name="mip_era" value=""/>
#           <input type="hidden" name="data_node" value=""/>
#           <input type="hidden" name="cf_standard_name" value=""/>
#           <input type="hidden" name="activity_id" value=""/>          CMIP
#           <input type="hidden" name="model_cohort" value=""/>
#           <input type="hidden" name="variant_label" value=""/>        r1i1p1f1
#           <input type="hidden" name="institution_id" value=""/>
#           <input type="hidden" name="source_type" value=""/>
#           <input type="hidden" name="frequency" value=""/>            mon
#           <input type="hidden" name="table_id" value=""/>             Amon Omon
#           <input type="hidden" name="experiment_id" value=""/>        historical piControl ssp126 ssp245 ssp370 ssp585
#           <input type="hidden" name="source_id" value=""/>            ??????
#           <input type="hidden" name="sub_experiment_id" value=""/>
#           <input type="hidden" name="nominal_resolution" value=""/>
#           <input type="hidden" name="grid_label" value=""/>
#----------------------------------------------------------------------------------------------------
#   After setting those 7 variables above, you will get models|source_ids below
# AWI-CM-1-1-MR (29)
# BCC-CSM2-MR (120)
# BCC-ESM1 (72)
# CAMS-CSM1-0 (103)
# CESM2 (112)
# CESM2-WACCM (102)
# CanESM5 (169)
# E3SM-1-0 (12)
# EC-Earth3 (36)
# EC-Earth3-LR (10)
# EC-Earth3-Veg (43)
# GFDL-CM4 (66)
# GFDL-ESM4 (19)
# GISS-E2-1-G (36)
# GISS-E2-1-H (35)
# HadGEM3-GC31-LL (12)
# IPSL-CM6A-LR (178)
# MIROC6 (120)
# MPI-ESM1-2-HR (24)
# MRI-ESM2-0 (68)
# SAM0-UNICON (33)

#----------------------------------------------------------------------------------------------------
experiment_ids=(historical piControl ssp126 ssp245 ssp370 ssp585)
variable_ids=(hus psl so ta thetao tos)
source_ids=(AWI-CM-1-1-MR BCC-CSM2-MR BCC-ESM1 CAMS-CSM1-0 CESM2 CESM2-WACCM CanESM5 E3SM-1-0 EC-Earth3 EC-Earth3-LR EC-Earth3-Veg GFDL-CM4 GFDL-ESM4 GISS-E2-1-G GISS-E2-1-H HadGEM3-GC31-LL IPSL-CM6A-LR MIROC6 MPI-ESM1-2-HR MRI-ESM2-0 SAM0-UNICON)
table_ids=(Amon Omon)
frequencys=(mon)
variant_labels=(r1i1p1f1)
realms=(atmos ocean)

base="https://esgf-node.llnl.gov/esg-search/wget?distrib=true&latest=true&replica=true"
for experiment_id in ${experiment_ids[*]};do
for   variable_id in   ${variable_ids[*]};do
for     source_id in     ${source_ids[*]};do
for      table_id in      ${table_ids[*]};do
for         realm in         ${realms[*]};do
for     frequency in     ${frequencys[*]};do
for variant_label in ${variant_labels[*]};do

    url="${base}&source_id=${source_id}&experiment_id=${experiment_id}&frequency=${frequency}&realm=${realm}&table_id=${table_id}&variant_label=${variant_label}&variable_id=${variable_id}"
    tim=`date "+%Y%m%d%H%M%S"`
    file="wgets/wget-${variable_id}-${table_id}-${source_id}-${experiment_id}-${variant_label}-${tim}.sh"
    echo "processing ... ${file}"
    wget -O - "$url" | grep -P "^(?!'(?!${variable_id}_)|'.*\.nc4)" 1>$file
    nwords=$(cat "$file" | wc -l)
    [ $nwords -le 1 ] && echo "No files found." && rm "$file"
done
done
done
done
done
done
done
