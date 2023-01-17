<?php
namespace Conshell\Command;

abstract class Command {
	/**
	 * @var string[]
	 */
	private $arguments;

	/**
	 * Description
	 * 
	 * @return void
	 */
	final public function __construct() {
		parse_str(implode('&', $_SERVER['argv']), $this->arguments);
	}

	/**
	 * Execute the command.
	 * 
	 * @return bool
	 */
	abstract protected function execute();
}