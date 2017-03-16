<?php

$components = parse_url($_SERVER['REQUEST_URI']);
$components['path'] = str_replace("/api/php", "", $components['path']);
echo "<h1>PHP Endpoint</h1>";
echo "<p>requested: " . $components['path'] . "</p>";
