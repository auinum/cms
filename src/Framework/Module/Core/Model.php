<?php
namespace Cluency\Module\Core;

use Cluency\Utility\SQLayer;

abstract class Model {
	/**
	 * @var string
	 */
	const TABLE = null;

	/**
	 * @var string|string[]
	 */
	const PRIMARY_KEY = null;

	/**
	 * @var array
	 */
	private $data = [];

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function __construct($data) {
		$this->data += $data;
	}

	/**
	 * Description
	 * 
	 * @return mixed
	 */
	public function __get($name) {
		return $this->data[$name];
	}

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function __set($name, $value) {
		$this->data[$name] = $value;
	}

	/**
	 * Description
	 * 
	 * @param string[] $columns
	 * @param array $conditions
	 * @return self[]
	 */
	public static function select($conditions) {
		$stmt = 'SELECT * FROM ' . static::TABLE . self::makeWhereClause($conditions);
	}

	/**
	 * Description
	 * 
	 * @return void
	 */
	public static function delete($conditions) {
		$stmt = 'DELETE FROM ' . static::TABLE . self::makeWhereClause($conditions);

		SQLayer::run($stmt);
	}

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function insert() {
		static $stmt = 'INSERT INTO ' . static::TABLE . ' VALUES %s';
	}

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function update() {
		static $stmt = 'UPDATE ' . static::TABLE . ' SET %s';
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereClause($conditions, $isSubclause = false) {
		$clause = $isSubclause ? '1' : 'WHERE 1';

		foreach ($conditions as $column => $condition) {
			if (is_int($column)) {
				if ($condition instanceof self) {
					// TODO: WHERE EXIST ()
					$clause .= ' EXISTS ()';
				} elseif (is_array($condition)) {
					$clause .= ' OR (' . self::{__FUNCTION__}($condition, true) . ')';
				}
			} else {
				$clause .= " AND {$column} ";

				if (is_scalar($condition)) {
					$clause .= '= ?';
				} elseif (array_is_list($condition)) {
					$clause .= 'IN (' . substr(str_repeat(', ?', count($condition)), 2) . ')';
				}
			}
		}

		return $clause;
	}
}