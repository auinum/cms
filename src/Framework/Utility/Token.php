<?php
namespace Cluency\Utility;

class Token {
	/**
	 * Generate a token.
	 * 
	 * @return string
	 */
	public static function create($length) {
		return bin2hex(random_bytes($length));
	}

	/**
	 * Verify a token.
	 * 
	 * @return bool
	 */
	public static function verify($token) {
		$key = $_ENV['APP_KEY'];

		return $token === hash_hmac('sha256');
	}

	/**
	 * Encode a string with URL-safe base64.
	 * 
	 * @return string
	 */
	public static function safeBase64Encode($string) {
		return strtr(base64_encode($string), ['+' => '-', '/' => '_', '=' => '']);
	}
}