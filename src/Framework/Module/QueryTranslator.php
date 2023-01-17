<?php
namespace Cluency\Module;

class QueryTranslator {
	/**
	 * Description
	 * 
	 * @return string
	 */
	public static function infer($conditions) {
		$clause = '';
		$columns = array_filter($conditions, 'is_string', ARRAY_FILTER_USE_KEY);

		foreach ($columns as $column => $condition) {
			$operator = $clause ? '' : 'AND';

			if (is_scalar($condition))
				$clause .= "$operator $column = $condition";
		}
	}
}