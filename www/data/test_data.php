<?php
//header('Content-Type: application/json');
$data = array();
ini_set('memory_limit', '2048M');
for ($i=0; $i < 10000; $i++) {
	$addition = array(
		'id' => $i,

		'lng' => rand(1423608410,1469877890)/100000000,
		'lat' => rand(499212284,501979864)/10000000,
		"count" => rand(0,1000)
		); 
	$data[] = $addition;
}
echo json_encode($data);

$fp = fopen('bigdata.json', 'w');
fwrite($fp, json_encode($data));
fclose($fp);
echo "done";/**/