<?php
namespace Cluency\Helper\Handler;

use Cluency\Utility\SQLayer;

class DatabaseBasedSessionHandler implements \SessionHandlerInterface {
	const TABLE = 'UserSession';

	const COLUMN_ID = 'ID';

	const COLUMN_DATA = 'Data';

	const COLUMN_TIME = 'DateIssued';

	/**
	 * @var SQLayer
	 */
	private $layer;

	/**
	 * Description
	 * 
	 * @return bool
	 */
	final public function open() {
		$this->layer = new SQLayer();

		return true;
	}

	/**
	 * Description
	 * 
	 * @return string|false
	 */
	final public function read($id) {
		static $stmt;

		$stmt ??= sprintf(
			"SELECT %s FROM %s WHERE %s = $id",
			self::COLUMN_DATA, self::TABLE, self::COLUMN_ID);

		return $this->layer->run($stmt)['result'][self::COLUMN_DATA];
	}

	/**
	 * Description
	 * 
	 * @return bool
	 */
	final public function write($id, $data) {
		static $stmt;

		$stmt ??= sprintf(
			"INSERT INTO %s(%s, %s) VALUES ($id, $data) ON DUPLICATE KEY UPDATE %s = $data",
			self::SESSION_TABLE, self::COLUMN_ID, self::COLUMN_DATA);

		$this->layer->run($stmt);

		return true;
	}

	/**
	 * Description
	 * 
	 * @return bool
	 */
	final public function destroy($id) {
		static $stmt;

		$stmt ??= sprintf(
			"DELETE FROM %s WHERE %s = $id",
			self::COLUMN_TIME, self::TABLE, self::COLUMN_ID);

		$this->layer->run($stmt)['result'][self::COLUMN_TIME];

		return true;
	}

	/**
	 * Description
	 * 
	 * @return bool
	 */
	final public function close() {
		$this->layer = null;

		return true;
	}

	/**
	 * Description
	 * 
	 * @return int|false
	 */
	final public function gc($max_lifetime) {
		static $stmt;

		$stmt ??= sprintf(
			"DELETE FROM %s WHERE %s < NOW() - $max_lifetime",
			self::TABLE, self::COLUMN_TIME);

		return true;
	}
}