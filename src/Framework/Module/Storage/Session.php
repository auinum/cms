<?php
namespace Cluency\Module\Storage;

use Cluency\Helper\Design\Singleton;
use Cluency\Helper\Handler\DatabaseBasedSessionHandler;

class Session extends Singleton {
	protected static $instance;

	/**
	 * Description
	 * 
	 * @return void
	 */
	protected function __construct() {
		session_name(env('SESSION_NAME'));

		if (env('SESSION_HANDLER') === 'Database')
			session_set_save_handler(new DatabaseBasedSessionHandler());

		session_start();
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	protected function get($name) {
		return $_SESSION[$name] ?? false;
	}

	/**
	 * Description
	 * 
	 * @return void
	 */
	protected function set($name, $value) {
		$_SESSION[$name] = $value;
	}

	/**
	 * Description
	 * 
	 * @return bool
	 */
	protected function destroy() {
		return session_destroy();
	}
}