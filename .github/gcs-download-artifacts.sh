#!/bin/bash

# $1 = ${{ secrets.GCP_SA_KEY }}
# $2 = ${{ github.run_id }}/${{ matrix.name }}
# $3 = source
# $4 = to
echo "Syncing bucket $BUCKET ..."

echo $1 | base64 -d > json.json
gcloud auth activate-service-account --key-file=json.json

rm -rf tmp || echo ""
mkdir tmp
gsutil -m cp -r gs://gh-zcash/$2/$3 tmp/.
mkdir -p $(dirname "$3") || echo ""
cp -a tmp/* $4