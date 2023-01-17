<?php
namespace Conshell\Stream;

interface StdInInterface {
	/**
	 * Read the input stream.
	 * 
	 * @return string
	 */
	public function read();
}