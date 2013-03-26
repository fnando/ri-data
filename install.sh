#!/usr/bin/env sh

target="$HOME/.rdoc"
tgz="https://raw.github.com/fnando/ri-data/master/ri-data.tar.gz"

if [ -d "$target" ]; then
  echo -n "=> $target will be replaced. Continue (y/n)? "
  read confirm

  if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "=> Exiting."
    exit 1
  fi
fi


tmpdir=`mktemp -d`
cd $tmpdir

echo -n "=> Downloading $tgz... "
wget --quiet "$tgz"
echo "done!"

echo -n "=> Extracting... "
tar xf ri-data.tar.gz
echo "done!"

rm -rf "$target"
mv ri-data "$target"

echo -n "=> Fixing permission... "
find "$target" -type f -exec chmod -R 644 {} \;
find "$target" -type d -exec chmod -R 755 {} \;
echo "done!"

rm -rf $tmpdir
echo "=> Finished!"
