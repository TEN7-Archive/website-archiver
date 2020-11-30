#!/usr/bin/env bash


if [[ -z "${HTTRACK_URI}" ]]; then
    "[ERROR] No uri set (HTTRACK_URI)"
    exit 1
fi


echo "Working directory in docker: $PWD"


echo "Starting httrack..."
echo ""
echo " Site to crawl: ${HTTRACK_URI}"
echo " HTTrack options: ${HTTRACK_OPTS}"
echo ""

exec httrack  "${HTTRACK_URI}" ${HTTRACK_OPTS}

echo ""
echo "Find and delete all .tmp files..."
exec find . -name "*.tmp" -type f -delete

