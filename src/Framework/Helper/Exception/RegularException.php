<?php
namespace Cluency\Helper\Exception;

class RegularException extends \Exception {
	const MESSAGES = [];

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function __construct($code) {
		parent::__construct(static::MESSAGES[$code], $code);
	}
}