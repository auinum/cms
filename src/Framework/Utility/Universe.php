<?php
const REGEX_HTML_START_TAG = '/<\s*([A-Z_a-z:][.\w:-]*)(\s*[A-Z_a-z:][.\w:-]*(?:\s*=\s*(\'||\")(?:(?!\3).)*\3)?)*\s*\/?>/';

function def($name, $value) {
	return define("Cluency\\$name", $value);
}

function env($name, $default = null) {
	return $_ENV[$name] ?? $default;
}

function now() {
	static $start;

	return microtime(true) - ($start ??= $_SERVER['REQUEST_TIME_FLOAT']);
}

/**
 * Check if a value is HTML.
 * @param mixed $value
 * @return bool
 */
function is_html($value) {
	return is_string($value) && preg_match(REGEX_HTML_START_TAG, $value);
}