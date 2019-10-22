download-CMIP6
inspired by https://github.com/lukelbd/cmip5-downloads.git, I improved it to be compatibility with CMIP6.

set your own variables like below.
experiment_ids=(historical piControl ssp126 ssp245 ssp370 ssp585)
variable_ids=(hus psl so ta thetao tos)
source_ids=(AWI-CM-1-1-MR BCC-CSM2-MR)
table_ids=(Amon Omon)
frequencys=(mon)
variant_labels=(r1i1p1f1)
realms=(atmos ocean)

mkdir wgets to store wget-*.sh
For example: wget-so-Omon-HadGEM3-GC31-LL-piControl-r1i1p1f1-20190820235657.sh

Though, user could set experiment_ids, variable_ids, source_ids etc, to include the most subject, but website might disclose your requests and/or block your account/IP. So the strategy is that, request ~100 wget-*.sh in one day and execute these scripts to download data. then next day. That's my experience.
