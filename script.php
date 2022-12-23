<?php
  $db_host = 'localhost';
  $db_user = 'root';
  $db_password = 'root';
  $db_db = 'world';
 
  $mysqli = @new mysqli(
	$db_host,
	$db_user,
	$db_password,
	$db_db
  );
	
  if ($mysqli->connect_error) {
	exit();
  }

  /*
  $result = $mysqli->query("SELECT `Language` FROM `countryLanguage` GROUP BY `Language` ORDER BY `Language`");
	foreach ($result->fetch_all() as $city) {
		$name = $city[0];
		if (!$mysqli->query("INSERT INTO language (Name) VALUES ('$name')")) {
			exit();
		}
	}
	*/

	$result = $mysqli->query("SELECT * FROM `countryLanguage`");
	foreach ($result->fetch_all() as $countryLang) {
		$country = $countryLang[0];
		$lang = $countryLang[1];
		$result = $mysqli->query("SELECT * FROM `language` WHERE `Name` = '$lang'")->fetch_all()[0];
		$id = $result[0];
		if (!$mysqli->query("UPDATE `countryLanguage` SET `Language_id`=$id WHERE `Language`='$lang' AND `CountryCode`='$country'")) {
			echo "Error: " . $mysqli->error;
			exit();
		}
	}

  echo 'Done';

  $mysqli->close();
?>