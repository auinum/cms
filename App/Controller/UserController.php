<?php
namespace App\Controller;

use App\Model\UserModel as User;
use Cluency\Module\Core\Controller;
use Cluency\Module\Http\Response;
use Cluency\Module\Security\Authorizator;
use Cluency\Module\Storage\Session;
use Cluency\Utility\SQLayer;

class UserController extends Controller {
	public static function browse() {
		if (!Session::get('SN')) {
			return new Response([
				'code' => 401,
				'message' => 'Please log in.'
			], 401);
		}

		// Authorizator::claim('READ_USER');

		$result = SQLayer::run(
			'SELECT SN, Username, FirstName, LastName, DateRegistered, Deactivated, CreatorUserSN FROM User WHERE CreatorUserSN = ?',
			[Session::get('SN')]
		)->fetch();

		return new Response($result, 200);
	}

	public static function read($matches) {
		
	}
}