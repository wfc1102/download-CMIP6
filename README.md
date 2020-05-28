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
---------------------------------------------------------------------------------------- 
The complete archive of CMIP6 output is accessible from any one of the following portals:
USA, PCMDI/LLNL (California) - https://esgf-node.llnl.gov/projects/cmip6/
France, IPSL - https://esgf-node.ipsl.upmc.fr/projects/cmip6-ipsl/
Germany, DKRZ - https://esgf-data.dkrz.de/projects/cmip6-dkrz/
UK, CEDA - https://esgf-index1.ceda.ac.uk/projects/cmip6-ceda/

the original wget-download.sh only use the USA node by setting
base="https://esgf-node.llnl.gov/esg-search/wget?distrib=true&latest=true&replica=true"

For my experience, sometimes data is missing in USA node while it can be found in other nodes. Thus, try to use below instead:
base="https://esgf-node.ipsl.upmc.fr/esg-search/wget?distrib=true&latest=true&replica=true"
base="https://esgf-data.dkrz.de/esg-search/wget?distrib=true&latest=true&replica=true"
base="https://esgf-index1.ceda.ac.uk/esg-search/wget?distrib=true&latest=true&replica=true"
