<?php
return [
	'mysql' => [
		'dsn' => [
			'{=host};{=port};{=dbname};{=charset}',
			'{=unix_socket};{=dbname};{=charset}'
		],
		'host' => $_ENV['DB_HOST'] ?? '127.0.0.1',
		'port' => $_ENV['DB_PORT'] ?? '3306',
		'dbname' => $_ENV['DB_DATABASE'],
		'unix_socket' => $_ENV['DB_SOCKET'],
		'charset' => 'utf8mb4',
		'username' => $_ENV['DB_USERNAME'] ?? 'user',
		'password' => $_ENV['DB_PASSWORD'] ?? ''
	],

	'sqlite' => [
		'dsn' => [
			'sqlite:%s'
		],
	],

	'pgsql' => [
		'dsn' => [
			'{=host};{=port};{=dbname};{=sslmode}'
		],
	],

	'sqlsrv' => [
		'dsn' => [
			'sqlsrv:'
		]
	],

	'odbc' => [
		'dsn' => [
			'odbc:%s'
		],
	],

	'oci' => [
		'dsn' => [
			'dbname={base};{=charset}',
			'dbname=//{host}/{base};{=charset}',
			'dbname=//({host}(:{port})/){base};{=charset}'
		]
	]
];