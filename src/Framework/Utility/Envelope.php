<?php
namespace Cluency\Utility;

class Envelope {
	/**
	 * Load a .env file.
	 * 
	 * @return array
	 */
	public static function load($filename) {
		if (!($filename = realpath($filename)))
			throw new \InvalidArgumentException("Error Processing Request", 1);

		if (!is_readable($filename))
			throw new \RuntimeException("Error Processing Request", 1);

		return self::read(file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES));
	}

	/**
	 * Read a .env file.
	 * 
	 * @return array
	 */
	private static function read($file) {
		foreach ($file as $line)
			strpos(trim($line), '#') !== 0 && self::register($line, $envs);

		return $envs;
	}

	/**
	 * Bind a environment variable.
	 * 
	 * @return array<string,string>|void
	 */
	private static function register($line, &$envs) {
		[$key, $value] = array_map('trim', explode('=', $line, 2));

		if (array_key_exists($key, $_ENV))
			return;

		putenv(sprintf('%s=%s', $key, $envs[$key] = $_ENV[$key] = $value));

		return [$key, $value];
	}
}