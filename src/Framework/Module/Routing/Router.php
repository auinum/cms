<?php
namespace Cluency\Module\Routing;

use Cluency\Module\Http\Response;
use Cluency\Helper\Design\Singleton;
use Cluency\Helper\Exception\RegularException;

class Router extends Singleton {
	/**
	 * @var int
	 */
	const CLIENT_UNAUTHORIZED = 403;

	/**
	 * @var int
	 */
	const ROUTE_NOT_FOUND = 404;

	/**
	 * @var int
	 */
	const METHOD_NOT_ALLOWED = 405;

	protected static $instance;

	/**
	 * @var \ArrayObject
	 */
	private $routes;

	/**
	 * Description
	 * 
	 * @return void
	 */
	protected function __construct() {
		$this->routes = new \ArrayObject();
	}

	/**
	 * Listen to a route.
	 * 
	 * @param Route $route
	 * @return Route
	 */
	protected function listen(Route $route) {
		return $this->routes[] = $route;
	}

	/**
	 * Deliver to a route.
	 * 
	 * @return void
	 */
	protected function deliver() {
		foreach ($this->routes as $route) {
			$matches = $route->match();

			if ($matches === false) {
				continue;
			}

			if ($matches === true) {
				$response = new Response([], static::METHOD_NOT_ALLOWED);
			}

			try {
				$response = $route->drive($matches);
			} catch (RegularException $e) {
				$response = new Response([], static::CLIENT_UNAUTHORIZED);
			}

			break;
		}

		($response ?? new Response([], static::ROUTE_NOT_FOUND))->send();
	}
}
