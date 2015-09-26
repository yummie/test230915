<?php
/**
 *
 *
 * CakePHP(tm) : Rapid Development Framework (http://cakephp.org)
 * Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @copyright     Copyright (c) Cake Software Foundation, Inc. (http://cakefoundation.org)
 * @link          http://cakephp.org CakePHP(tm) Project
 * @package       app.View.Layouts
 * @since         CakePHP(tm) v 0.10.0.1076
 * @license       http://www.opensource.org/licenses/mit-license.php MIT License
 */

?>
<!DOCTYPE html>
<html>
<head>
	<?php echo $this->Html->charset(); ?>
	<title>
		<?php echo $title_for_layout; ?>
	</title>
	<?php
		echo $this->Html->meta('icon');

		//Font CSS
		echo $this->Html->css('http://fonts.googleapis.com/css?family=Open+Sans:400,600,700');
		
		//Core CSS
		echo $this->Html->css(array('http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css','http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css'));
		
		echo $this->Html->css(array('theme', 'pages', 'plugins','responsive'));

		echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->fetch('script');
	?>
</head>
<body class="login-page">
<!-- Start: Main -->
<div id="main">
  <div class="container">
    <div class="row">
      <div id="page-logo">
	  </div>
    </div>
    <div class="row">
      <div class="panel">
        <div class="panel-heading">
          <div class="panel-title"> Demo Yummie/test230915 </div>
        </div>
		<?php echo $this->fetch('content'); ?>
      </div>
    </div>
  </div>
</div>
<!-- End: Main --> 
</body>
</html>
