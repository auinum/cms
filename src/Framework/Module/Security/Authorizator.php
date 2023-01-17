<?php
namespace Cluency\Module\Security;

use Cluency\Module\Storage\Session;
use Cluency\Helper\Exception\AuthorizationException as AuthException;

abstract class Authorizator {
	/**
	 * Check whether a user has a right.
	 * 
	 * @param string $right
	 * @return void
	 */
	final public static function claim($right) {
		if (static::check($right)) return;

		throw new AuthException(AuthException::CLIENT_UNAUTHORIZED);
	}

	/**
	 * Description
	 * 
	 * @return bool
	 */
	public static function check($right) {
		
	}
}