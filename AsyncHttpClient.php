<?php
namespace Yunniao\Utils\Monitor;

class AsyncHttpClient
{
	protected $line = '';
	protected $headers = [];
	protected $body = '';

	protected $urlInfo;
	protected $errno;
	protected $errstr;
	protected $connection_timeout = 1;
	protected $timeout = 3;

	const METHOD_GET = 'GET';
	const METHOD_POST = 'POST';
	const HTTP_VERSION = 'HTTP/1.1';

	public function __construct($url = null) {
		if (!empty($url)) {
			$this->setUrl($url);
		}
	}

	/**
	 * 解析 url
	 */
	public function setUrl($url) {
		$urlInfo = parse_url($url);
		if (!$urlInfo) {
			return ;
		}

		if (empty($urlInfo['path'])) {
			$urlInfo['path'] = '/';
		}
		if (empty($urlInfo['port'])) {
			if ($urlInfo['scheme'] == 'https') {
				$urlInfo['port'] = 443;
			} else {
				$urlInfo['port'] = 80;
			}
		}

		$this->urlInfo = $urlInfo;
	}

	/**
	 * 设置 HTTP 请求行
	 */
	public function setLine($method = self::METHOD_GET) {
		$this->line .= ($method . ' ' . $this->urlInfo['path']);
		if (!empty($this->urlInfo['query'])) {
			$this->line .= ('?' . $this->urlInfo['query']);
		}
		$this->line .= (' ' . self::HTTP_VERSION);
	}

	/**
	 * 设置 HTTP 请求头
	 */
	public function setHeader($header) {
		if (is_string($header)) {
			$this->headers[] = $header;
		}
	}

	/**
	 * 设置 POST 正文内容
	 */
	public function setBody($data) {
		if (is_array($data)) {
			$data = http_build_query($data);
		}
		$this->body = $data;
	}

	/**
	 * HTTP POST 请求
	 */
	public function post($data) {
		$this->setLine(self::METHOD_POST);
		$this->setHeader('Host: ' . $this->urlInfo['host']);
		$this->setHeader('Connection: close');
		$this->setBody($data);
		$bodyLen = strlen($this->body);
		if ($bodyLen > 0) {
			$this->setHeader('Content-Length: ' . $bodyLen);
		}
		return $this->sendData(self::METHOD_POST);
	}

	public function getError() {
		return $this->errno . ', ' . $this->errstr;
	}

	protected function sendData($method = self::METHOD_GET) {
		if ($this->urlInfo['scheme'] == 'https') {
			$hostString = 'ssl://' . $this->urlInfo['host'];
		} else {
			$hostString = $this->urlInfo['host'];
		}
		$fsock = fsockopen($hostString,
				$this->urlInfo['port'],
				$this->errno,
				$this->errstr,
				$this->connection_timeout);

		if (!$fsock) {
			return false;
		}

		stream_set_timeout($fsock, $this->timeout);
		stream_set_blocking($fsock, 0);

		$reqString = $this->line . PHP_EOL;
		$reqString .= implode(PHP_EOL, $this->headers) . PHP_EOL . PHP_EOL;

		if ($method == self::METHOD_POST) {
			$reqString .= $this->body;
		} else {
			// get
		}

		fwrite($fsock, $reqString);
		fclose($fsock);
	}
}
