<?php
namespace Cluency\Helper\Exception;

class SQLayerException extends \RuntimeException {
	const EXECUTION = ['Failed to execute the SQL statement.', 1 << 0];
	const TRANSACTION = ['Failed to begin a transaction.', 1 << 1];
}