<?php
namespace Cluency\Utility;

use PDO;
use Cluency\Helper\Design\Singleton;
use Cluency\Helper\Exception\SQLayerException;

class SQLayer extends Singleton {
	protected static $instance;

	/**
	 * @var PDO The connection to the database
	 */
	private $connection;

	private $statement;

	/**
	 * Connect to the database.
	 * 
	 * @return void
	 */
	public function __construct() {
		$dsn = sprintf(
			'mysql:host=%s;port=%u;dbname=%s;charset=utf8mb4',
			$_ENV['DB_HOST'],
			$_ENV['DB_PORT'],
			$_ENV['DB_DATABASE']
		);

		try {
			$this->connection = new PDO($dsn, $_ENV['DB_USERNAME'], $_ENV['DB_PASSWORD']);
			$this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_SILENT);
		} catch(\PDOException $e) {
			throw new \Exception('1234567890');
		}
	}

	/**
	 * Execute a SQL statement and return the result.
	 * 
	 * @param string $stmt The SQL statement
	 * @param array $values The values to bind to the statement
	 * @throws SQLayerException If the statement cannot be executed.
	 * @return self The result
	 */
	protected function run($stmt, $values = null) {
		$this->statement?->closeCursor();
		$this->statement = $this->connection->prepare($stmt);
		$this->statement->execute($values);

		return $this;
	}

	/**
	 * Description
	 * 
	 * @return array|false
	 */
	public function catch() {
		$stmt = $this->statement;

		return !($code = $stmt?->errorCode())
			? false
			: ['code' => $code, 'info' => $stmt->errorInfo()];
	}

	/**
	 * Description
	 * 
	 * @return array
	 */
	public function fetch($informative = false) {
		$stmt = $this->statement;
		$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return !$informative
			? $data
			: [
				'count' => $stmt->rowCount(),
				'data' => $data
			];
	}

	/**
	 * Begin a transaction.
	 * 
	 * @param callable $callback
	 * @return bool
	 */
	protected function transact($callback) {
		$handler = $this->connection;

		if ($handler->beginTransaction())
			throw new SQLayerException(...SQLayerException::TRANSACTION);

		return $callback()
			? $handler->commit()
			: $handler->rollback();
	}
}