<?php
namespace Conshell;

use Cluency\Helper\Design\Singleton;

class Kernel extends Singleton {
	protected static $instance;

	/**
	 * @var string
	 */
	private $script;

	/**
	 * @var string
	 */
	private $command;

	/**
	 * @var string[] The shell modules
	 */
	private $modules;

	/**
	 * @return void
	 */
	protected function __construct() {
		$this->script = array_shift($argv);
		$this->command = array_shift($argv);
		$this->modules = array_map('basename', glob('*.php'));
	}

	/**
	 * Launch the kernel.
	 * 
	 * @return self
	 */
	public static function launch() {
		return self::init();
	}
}