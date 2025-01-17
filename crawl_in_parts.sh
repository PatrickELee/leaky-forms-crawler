set -x  # uncomment to debug
# Usage:

URL_PARTS_DIR=$1  # all URLS must be in this dir, split into multiple CSVs
OUTDIR=$2  # out data dir
LOGFILE=$3  # out log dir
EMAIL=$4  # email address will be filled
PASSWORD=$5  # password will be filled
MOBILE=$6  # leave empty for desktop, -m mobile mobile

# if [[ $6="true" ]]
# then
#     MOBILE=$6


if [[ $7 = "true" ]];
then
    COLLECTORS="noEntryEmailPasswordFields,requests,cookies,targets,apis"
else
    COLLECTORS="emailPasswordFields,requests,cookies,targets,apis"
fi

echo "Will crawl urls in dir: ${URL_PARTS_DIR}"
echo "Output dir: ${OUTDIR}"
echo "Log file: ${LOGFILE}"
echo "Mobile: ${MOBILE}"
echo "Email: ${EMAIL}"
echo "Password: ${PASSWORD}"
echo "Collectors: ${COLLECTORS}"
echo ""

mkdir -p $OUTDIR

echo_date(){
  date -u +"%Y-%m-%dT%H:%M:%S.%3NZ"
}

for url_file in $URL_PARTS_DIR/*_*.csv; do
    echo "$(echo_date) Will crawl the urls in $url_file"
    npm run crawl -- -i $url_file  -o $OUTDIR -v -f -d $COLLECTORS -e $EMAIL -w $PASSWORD >> $LOGFILE
done
