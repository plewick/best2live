<?php
$data = /** whatever you're serializing **/;
header('Content-Type: application/json');
echo json_encode($data);