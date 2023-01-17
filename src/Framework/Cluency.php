<?php
namespace Cluency;

use Cluency\Module\Routing\Router;

class Cluency {
	/**
	 * Launch the application.
	 * 
	 * @param int $levels The depth of "index.php" relative to the root directory
	 * @return void
	 */
	public static function launch($levels) {
		require_once 'Utility/Universe.php';

		def('REQUEST_METHOD', $_SERVER['REQUEST_METHOD']);
		def('REQUEST_PATH', trim($_SERVER['PATH_INFO'] ?? '', '/'));
		def('PORTAL_DIR', dirname($_SERVER['SCRIPT_FILENAME']));
		def('PROJECT_DIR', dirname(PORTAL_DIR, $levels - 1));

		// Utility\Envelope::load(PROJECT_DIR . '/.env');

		self::transfer();
	}

	/**
	 * Transfer to the router.
	 * 
	 * @return void
	 */
	public static function transfer() {
		$router = str_starts_with(REQUEST_PATH, 'api')
			? 'Api' : 'Gui';

		require_once PROJECT_DIR . "/App/Router/$router.php";

		Router::deliver();
	}
}
