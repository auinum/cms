<?php
namespace Cluency\Helper\Exception;

class AuthorizationException extends RegularException {
	const CLIENT_UNAUTHORIZED = 1;

	const MESSAGES = [
		self::CLIENT_UNAUTHORIZED => 'Lack valid authentication credentials for the resource.'
	];
}