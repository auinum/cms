<?php
namespace Conshell\Command;

class ServeCommand extends BaseCommand {
	const COMMAND_NAME = 'serve';
	const DEFAULT_HOST = 'localhost';
	const DEFAULT_PORT = 52300;

	protected function execute() {
		$args = $this->arguments;
		$host = $args['--host'] ?? self::DEFAULT_HOST;
		$server = escapeshellarg("$host:" . ($args['--port'] ?? self::DEFAULT_PORT));

		return exec("php -S $server -t www -d display_errors=On -d variables_order=EGPCS");
	}
}