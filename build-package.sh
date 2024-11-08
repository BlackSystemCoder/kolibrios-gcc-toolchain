
cp -f install.sh package/DEBIAN/postinst

dpkg-deb --build ./package
