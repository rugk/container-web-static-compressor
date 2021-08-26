#!/bin/sh
set -e
#set -x # debug

targetDir="/app"
[ -n "$COMPRESSOR_DIRECTORY" ] && targetDir="$COMPRESSOR_DIRECTORY"
[ -n "$1"  ] && targetDir="$1"

if [ ! -d "$targetDir" ]; then
    echo "The provided target value '$targetDir' does not exist or is no directory."
    exit 1
fi

# debug output
echo "Checking tools..."
zstd --version
node -v

echo "Starting compression..."
# compress zstd
# "threads=0" uses one thread per CPU core
find . -type f -exec zstd -z -f -19 --threads=0 {} +

# compress GZIP and Brotli
gzipper compress --level 9 --remove-larger --exclude 'gz,br,zst' "$targetDir"
gzipper compress --level 9 --brotli --remove-larger --exclude 'gz,br,zst' "$targetDir"

echo "Compression finisedh. Result:"
ls -la "$targetDir"

echo "Process finished."