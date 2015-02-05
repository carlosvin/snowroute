rm -rf *.html* *.dart* packages/ manifest.appcache *.css
cp -R ../snowroute/build/web/* .
git add .
git commit . -m "new deploy"
git push origin gh-pages

