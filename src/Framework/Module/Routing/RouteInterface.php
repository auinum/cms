<?php
namespace Cluency\Module\Routing;

interface RouteInterface {
	const CONNECT = 1;

	const DELETE = 2;

	const GET = 4;

	const HEAD = 8;

	const OPTIONS = 16;

	const PATCH = 32;

	const POST = 64;

	const PUT = 128;

	const TRACE = 256;

	const ANY = 511;

	/**
	 * Construct a route.
	 * 
	 * @param int $methods
	 * @param string $destination
	 * @param \Closure|string[] $handler
	 * @return void
	 */
	public function __construct($method, $destination, $handler);

	/**
	 * Destruct a route.
	 * 
	 * @return void
	 */
	public function __destruct();

	/**
	 * Match the given path against the destination.
	 * 
	 * @param int|string $method
	 * @param string $path
	 * @return array<string,string>|int|false
	 */
	public function match($method, $path);

	/**
	 * Drive to the destination.
	 * 
	 * @param array $args
	 * @return mixed
	 */
	public function drive(...$args);
}