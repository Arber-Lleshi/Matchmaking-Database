<?php

	namespace MatchMaking;
	require_once(dirname(dirname(__FILE__)).'/vendor/autoload.php');

	ob_start();

	$return = [];

	try{
		if ($_SERVER['REQUEST_METHOD'] === 'GET') {
			$return = ['requestType' => 'GET'];
		}
		else if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
			$return = ['requestType' => 'PUT'];
		}
		else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
			$return = ['requestType' => 'POST'];
		}
		else if ($_SERVER['REQUEST_METHOD'] === 'DElETE') {
			$return = ['requestType' => 'DElETE'];
		}
	}
	catch (Throwable $t)
	{
		Log.error($t);
	}
	catch (Exception $e)
	{
		Log.error($t);
	}

	ob_clean();

	header('Content-Type: application/json; charset=utf-8');
	echo(json_encode($return));

?>
