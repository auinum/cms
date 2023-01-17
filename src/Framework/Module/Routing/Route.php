<?php
namespace Cluency\Module\Routing;

use const Cluency\REQUEST_METHOD;
use const Cluency\REQUEST_PATH;

class Route implements RouteInterface {
	const PATH_NOT_FOUND = 404;

	const METHOD_NOT_ALLOWED = 405;

	/**
	 * @var string[] The allowed methods
	 */
	private $methods;

	/**
	 * @var string
	 */
	private $destination;

	/**
	 * @var callable
	 */
	private $handler;

	/**
	 * @var bool
	 */
	private $isBeingListened = false;

	public function __construct($methods, $destination, $handler) {
		$this->destination = trim($destination, '/');
		$this->handler = $handler;
		$this->methods = is_int($methods) ? $methods : self::GET;
	}

	public function __destruct() {
		if ($this->isBeingListened) return;

		Router::listen($this)->isBeingListened = true;
	}

	public function match($method = REQUEST_METHOD, $path = REQUEST_PATH) {
		$dest = str_replace('%2F', '/', rawurlencode($this->destination));
		$pattern = preg_replace('#([^/]*)%7B(\w+)%7D([^/]*)#', '(?P<$2>$1[^/]+$3)', $dest);
		$method = !defined("self::$method") ?: constant("self::$method");

		return preg_match("#^$pattern$#", $path, $matches)
			? !($method & $this->methods)
				?: array_filter($matches, 'is_string', ARRAY_FILTER_USE_KEY)
			: false;
	}

	public function drive(...$args) {
		return call_user_func($this->handler, ...$args);
	}
}