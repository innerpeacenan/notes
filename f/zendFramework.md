### zend framework--form process handles###
* confirm the form submit event triggered
`$request->isPost ()`
* get request from form submit event
`$this->getRequest()->getPost()`
get param from both post or
`$this->getParam()`
```
Zend_Controller_Action::getParam(string $paramName, mixed $default)
```

* 页面跳转:
```php
<?php
$this->_helper->redirector();
$this->_redirect();
?>
```
###  zend framework debug
registry a log object and add a writter
`Zend_Registry::get('logger')->info('request - '. print_r($request,true));`


### zend framework view
* 禁用layout方法
     `$this->_helper->layout()->disableLayout() ;`

* 禁用view方法
   `$this->_helper->viewRenderer->setNoRender();
