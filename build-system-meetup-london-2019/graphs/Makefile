dune-overview-embed.svg: dune-overview.svg
	echo "s#xlink:href=\"[^\"]*\"#xlink:href=\"data:image/png;base64,`base64 -w 0 ../images/dune.png`\"#" \
          | sed -f - $< > $@
