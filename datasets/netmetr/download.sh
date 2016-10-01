for y in 2014 2015 2016; do
	for m in {01..12}; do	
		wget https://control.netmetr.cz/RMBTStatisticServer/export/NetMetr-opendata-$y-$m.zip
	done
done
