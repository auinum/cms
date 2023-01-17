<?php
namespace Cluency\Module;

class QueryStatement {
	/**
	 * @var string
	 */
	private $clause = '';

	/**
	 * Description
	 * 
	 * @return void
	 */
	public function __construct(...$values) {
		
	}

	/**
	 * Description
	 * 
	 * @return self
	 */
	private function formClause() {
		$this->clause .= $this->clause ? 'AND' : '';
	}

	/**
	 * Description
	 * 
	 * @return array
	 */
	// public static function makeWhereClause($conditions, &$values) {
	// 	$clause = 'WHERE 1';

	// 	foreach ($conditions as $column => $condition) {
	// 		$method = is_int($column)
	// 			? $condition instanceof self
	// 				? 'Exists'
	// 				: is_array($condition)
	// 					? 'Or'
	// 					: false
	// 			: is_string($column)
	// 				? is_scalar($condition)
	// 					? '='
	// 					: 'And'
	// 				: false;
	// 	}
	// }

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereClause($conditions, $either = false) {
		$clause = ' AND (' . +!$either;
		$conjunction = $either ? 'OR' : 'AND';

		foreach ($conditions as $column => $condition) {
			$clause .= is_int($column)
				? self::makeWhereClause($condition, true)
				: " $conjunction $column = $condition";
		}

		return "$clause)";
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereSubclause($conditions, &$values, $either = false) {
		$subclause = ' AND (' . +!$either;
		$conjunction = $either ? 'OR' : 'AND';

		foreach ($conditions as $column => $condition) {
			if (is_int($column)) {
				$subclause .= self::{__FUNCTION__}($condition, $values, true);
			}

			$subclause .= "$conjunction";
		}

		return ($subclause .= ')');
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereAndSubclause($column, $conditions, &$values) {
		
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereOrSubclause($column, $conditions, &$values) {
		
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereBetweenSubclause($column, $conditions, &$values) {
		$values = array_merge($values, [$conditions[0], $conditions[1]]);

		return "BETWEEN {$conditions[0]} AND {$conditions[1]}";
	}

	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function makeWhereInSubclause($column, $conditions, &$values) {
		$count = count($conditions);
		$markers = implode(', ', array_fill(0, $count, '?'));
		$values = array_merge($values, $conditions);

		return "IN ($markers)";
	}
}