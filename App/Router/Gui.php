<?php
use Cluency\Module\Storage\Session;
use const Cluency\PROJECT_DIR;
use Cluency\Module\Http\Response;
use Cluency\Module\Routing\Route;
use App\Controller\UserController;

new Route(Route::GET, '/user/', [UserController::class, 'browse']);

new Route(Route::GET, '/login/', function () {
	$response = new Response(file_get_contents(PROJECT_DIR . '/App/View/Login.php'), 200);

	if (Session::get('SN')) {
		http_response_code(302);
		$response->setHeader('Location', '/api/login/');
	}

	return $response;
});

new Route(Route::GET, '/logout/', function () {
	return new Response([
		'code' => $code = Session::destroy() ? 200 : 503
	], $code);
});