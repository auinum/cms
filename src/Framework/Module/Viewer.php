<?php
namespace Cluency\Module;

use const Cluency\PORTAL_DIR;

class Viewer {
	public static function view($view, $data = []) {
		extract($data, EXTR_SKIP);

		require self::cache(PORTAL_DIR . '/../App/View/' . $view);
	}

	private static function cache($view) {
		$dir = PORTAL_DIR . '/../' . trim(env('CACHE_DIR', 'cache'), '/');

		if (!is_dir($dir)) {
			mkdir($dir, 0744);
		}

		$file = "$dir/" . hash('sha256', $view) . ".phtml";

		// TODO: Cacheable
		if (1 || !is_file($file) || filemtime($file) < filemtime($view)) {
			$code = self::combine($view);
			$code = self::compile($code);

			file_put_contents(
				$file,
				"<?php class_exists('" . __CLASS__ . "') or exit ?>" . PHP_EOL . $code
			);
		}

		return $file;
	}

	// private static function clear() {
	// 	return in_array(false, array_map('unlink', glob(CACHE_DIR . '*')), true);
	// }

	private static function combine($view, $cdir = '') {
		$code = file_get_contents($view);

		preg_match_all(
			"/<File((?:\s+[A-Za-z:][\w:\-]*(?:=(?:'[^']*'|\"[^\"]*\"))?)*)\s+\/>/",
			$code, $tags, PREG_SET_ORDER);

		return array_reduce($tags, function ($a, $v) use ($view) {
			preg_match_all("/\s+src=(?:'([^:*?\"<>|]+?\.\w+)'|\"([^:*?\"<>|]+?\.\w+)\")/s", $v[0], $attr, PREG_SET_ORDER);

			return isset(end($attr)[2])
				? strtr($a, [$v[0] => self::combine(end($attr)[2], dirname($view))])
				: $a;
		}, $code);
	}

	private static function compile($code) {
		$code = array_reduce([
			["/{{\s*('||\")(.+?)\\1\s*}}/is", "<?= $2 ?>"],
			["/\[{\s*('||\")(.+?)\\1\s*}\]/is", "<?= htmlentities($2, ENT_QUOTES, 'UTF-8') ?>"],
			["/\(({\s*(.+?)\s*})\)/is", "<?php $2 ?>"]
		], function ($a, $v) {
			return preg_replace($v[0], $v[1], $a);
		}, $code);

		preg_match_all("/<([A-Z][\w:\-]*)((?:\s+[A-Za-z:][\w:\-]*(?:=(?:'[^']*'|\"[^\"]*\"))?)*)\s*>(.*?)<\/\\1>/s", $code, $tags, PREG_SET_ORDER);

		return array_reduce($tags, function ($a, $v) {
			return preg_replace_callback(
				"/<{$v[1]}((?:\s+[A-Za-z:][\w:\-]*(?:=(?:'[^']*'|\"[^\"]*\"))?)*)\s+\/>/",
				function ($m) use ($v) {
					$para = call_user_func(function () {
						return array_reduce(func_get_args(), function ($a, $v) {
							preg_match_all("/\s+([A-Za-z:][\w:\-]*)(?:=(?:'([^']*)'|\"([^\"]*)\"))?/", $v, $attr);
							$a[] = array_combine($attr[1], array_map(function ($i) use ($attr) {
								return $attr[2][$i] ?: $attr[3][$i];
							}, array_keys($attr[1])));
							return $a;
						}, []);
					}, $m[1], $v[2]);
					$args = array_merge($para[1], array_intersect_key($para[0], $para[1]));
					return array_reduce(array_keys($args), function ($a, $v) use ($args) {
						return preg_replace("/\\\${{$v}}/", $args[$v], $a);
					}, $v[3]);
				},
				str_replace($v[0], '', $a)
			);
		}, $code);
	}
}