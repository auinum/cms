<?php
define('PRJ_DIR', __DIR__ . '/../');
define('APP_DIR', PRJ_DIR . 'App/');
define('SRC_DIR', PRJ_DIR . 'src/');


// require_once APP_ROOT_DIR . "Helpers/JwtPack.php";
// require_once APP_ROOT_DIR . "Helpers/comparser.php";
// require_once APP_ROOT_DIR . "Configurations/config.php";

spl_autoload_register(function ($class) {
	list(, $module, $member) = explode('\\', $class);

	if (!file_exists($file = SRC_DIR . "$module/$member.php"))
		return;

	require_once $file;
});