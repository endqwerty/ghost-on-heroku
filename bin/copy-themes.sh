themes=(
	casper
	massively
	london
)

for theme in "${themes[@]}"
do
	cp -Rf "node_modules/$theme" content/themes
done
