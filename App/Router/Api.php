<?php
use Cluency\Module\Http\Response;
use Cluency\Module\Routing\Route;
use Cluency\Module\Storage\Session;
use Cluency\Utility\SQLayer;

new Route(Route::POST, '/api/login/', function () {
	if (Session::get('SN')) {
		return new Response([
			'code' => 302,
			'message' => 'Logged in already.'
		], 302);
	}

	if (!isset($_POST['username'], $_POST['password'])) {
		return new Response([
			'code' => 400,
			'message' => 'Failed to validate.'
		], 400);
	}

	$result = SQLayer::run(
		'SELECT SN, PasswordHash, Nickname FROM User WHERE Username = ?',
		[$_POST['username']]
	)->fetch()[0];
	$verified = password_verify($_POST['password'], $result['PasswordHash'] ?? '');

	$response = $verified
		? sprintf('Hiya, %s.', $result['Nickname'])
		: 'Failed to log in.';

	if ($verified) {
		Session::set('SN', $result['SN']);
	}

	return new Response([
		'code' => $code = $verified ? 200 : 401,
		'message' => $response
	], $code);
});