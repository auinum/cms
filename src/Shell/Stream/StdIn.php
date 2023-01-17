<?php
namespace Conshell\Stream;

class StdIn extends StandardStream implements StdInInterface {
	protected $stream;

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function __construct() {
		parent::__construct();

		$this->stream = fopen('php://stdin', 'r');
	}

	public function read() {
		return fgets($this->stream);
	}
}