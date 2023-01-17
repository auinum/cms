<?php
namespace Cluency\Module\Core;

use Cluency\Module\Http\Response;

abstract class Controller {
	/**
	 * Description
	 * 
	 * @return Response
	 */
	public static function create($matches) {}

	/**
	 * Description
	 * 
	 * @return Response
	 */
	public static function read($matches) {}

	/**
	 * Description
	 * 
	 * @return Response
	 */
	public static function edit($matches) {}

	/**
	 * Description
	 * 
	 * @return Response
	 */
	public static function delete($matches) {}

	/**
	 * Description
	 * 
	 * @return Response
	 */
	public static function browse() {}
}

// class Controller {
// 	protected $data;
// 	protected $class;
// 	protected $model;

// 	public function __construct() {
// 		$this->class = new \ReflectionClass($this);
// 		$model = 'App\\Models\\' . $this->class->getShortName();
// 		$this->model = new $model();
// 	}

// 	protected function cache($name, $data) {
// 		$path = CACHE_DIR . $name;

// 		if (is_array($data)) return file_put_contents($path, serialize(json_encode($data)));

// 		if (!file_exists($path) || filemtime($path) < time() - CACHE_AGE * 3600) return false;

// 		return unserialize(file_get_contents($path));
// 	}
// }