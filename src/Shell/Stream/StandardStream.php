<?php
namespace Conshell\Stream;

abstract class StandardStream {
	/**
	 * Description
	 * 
	 * @return void
	 */
	public function __construct(...$values) {
		if (ob_get_level())
			return;

		ob_start();
	}
}