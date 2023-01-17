<?php
namespace Cluency\Module\Http;

class Response {
	const TYPE_HTML = 1;

	const TYPE_JSON = 2;

	const TYPE_TEXT = 4;

	/**
	 * @var string
	 */
	private $body;

	/**
	 * @var int
	 */
	private $code;

	/**
	 * @var array
	 */
	private $headers = [];

	/**
	 * @var string|false
	 */
	private $json = false;

	/**
	 * Description
	 * 
	 * @param array|string $body
	 * @param int|null $code
	 * @return void
	 */
	public function __construct($body, $code = null) {
		$type = is_array($body) ? self::TYPE_JSON : self::TYPE_HTML;
		$this->body = is_scalar($body) ? $body : json_encode($body);
		$this->code = $code ?? ($body ? 200 : 204);

		if ($type === self::TYPE_JSON)
			$this->setHeader('Content-Type', 'application/json');
	}

	/**
	 * Send response to client.
	 * 
	 * @return void
	 */
	public function send() {
		http_response_code($this->code);

		foreach ($this->headers as $name => $value)
			header("$name: $value");

		echo $this->json ?: $this->body;
	}

	/**
	 * Set a header of response.
	 * 
	 * @param string $name
	 * @param string $value
	 * @return self
	 */
	public function setHeader($name, $value) {
		$this->headers[$name] = $value;

		return $this;
	}

	/**
	 * Set headers of response.
	 * 
	 * @param array $headers
	 * @return self
	 */
	public function setHeaders($headers) {
		$this->headers = array_merge($this->headers, $headers);

		return $this;
	}
}