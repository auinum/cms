<?php
namespace Cluency\Helper\Design;

abstract class Singleton {
	/**
	 * @var bool
	 */
	const INSTANCE_GETTER = true;

	/**
	 * @var self|null The singleton instance
	 */
	private static $instance;

	/**
	 * Only constructe and instantiate internally.
	 * 
	 * @return void
	 */
	protected function __construct() {}

	/**
	 * Not allow to clone.
	 * 
	 * @return void
	 */
	final protected function __clone() {}

	/**
	 * Description
	 * 
	 * @return mixed
	 */
	final public function __call($name, $args) {
		return $this->{$name}(...$args);
	}

	/**
	 * Description
	 * 
	 * @return mixed
	 */
	final public static function __callStatic($name, $args) {
		return (static::$instance ??= new static())->{$name}(...$args);
	}

	/**
	 * Description
	 * 
	 * @return static
	 */
	final public static function getInstance() {
		return static::INSTANCE_GETTER
			? static::$instance
			: null;
	}
}