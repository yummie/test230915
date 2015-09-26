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
		echo $this->Html->css(array('http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css',
									'http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css',
									'../fonts/glyphicons_pro/glyphicons.min.css',
									'../fonts/icomoon/style.min.css',
									'../fonts/whhg-font/css/whhg.css',
									'../fonts/typicons/typicons.min.css'
									)
							);
		
		echo $this->Html->css(array('theme', 'pages', 'plugins','responsive'));

		echo $this->fetch('meta');
		echo $this->fetch('css');

	?>
</head>
<body class="dashboard">
	<!-- Start: Header -->
	<header class="navbar navbar-fixed-top">
	  <div class="pull-left"> <a class="navbar-brand" href="<?php echo $this->Html->url(array('controller'=>'dashboards', 'action' => 'index')); ?>">
		<div class="navbar-logo">
			<?php echo $this->Html->image('logos/logo-red.png', array('alt' => 'logo','class'=>'img-responsive')); ?>
		</div>
		</a> </div>
	  <div class="pull-right header-btns">
		<div class="alerts-menu">
		  <!--button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown"> <span class="glyphicons glyphicons-bell"></span> <b>3</b> </button-->
		  <ul class="dropdown-menu checkbox-persist" role="menu">
			<li class="menu-arrow">
			  <div class="menu-arrow-up"></div>
			</li>
			<li class="dropdown-header">Avisos Recentes <span class="pull-right glyphicons glyphicons-bell"></span></li>
			<li>
			  <ul class="dropdown-items">
				<li>
				  <div class="item-icon"><i style="color: #5cb85c;" class="fa fa-check"></i> </div>
				  <div class="item-message"><a href="#">Robert <b>completed task</b> - Client SEO Revamp</a></div>
				</li>
				<li>
				  <div class="item-icon"><i style="color: #f0ad4e" class="fa fa-user"></i> </div>
				  <div class="item-message"><a href="#"><b>Marko</b> logged 12 hours</a></div>
				</li>
			  </ul>
			</li>
			<li class="dropdown-footer"><a href="#">View All Alerts <i class="fa fa-caret-right"></i> </a></li>
		  </ul>
		</div>

		<div class="btn-group user-menu">
		  <button type="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown"> <span class="glyphicons glyphicons-user"></span> <b>
		  <?php   
			$userLogado =  $this->Session->read("Auth.User");
			echo $userLogado["nome"];
		  ?>
		  </b> </button>
		  <button type="button" class="btn btn-sm dropdown-toggle padding-none" data-toggle="dropdown"><?php echo $this->Html->image('avatars/header/header-login.png', array('alt' => 'user avatar','width'=>'28','height'=>'28')); ?> </button>
		  <ul class="dropdown-menu checkbox-persist" role="menu">
			<li class="menu-arrow">
			  <div class="menu-arrow-up"></div>
			</li>
			<li class="dropdown-header">Sua Conta <span class="pull-right glyphicons glyphicons-user"></span></li>
			<li>
			  <ul class="dropdown-items">
				<li class="border-bottom-none">
				  <div class="item-icon"><i class="fa fa-cog"></i> </div>
				  <a class="item-message" href="<?php $usrLogado =  $this->Session->read('Auth.User'); echo $this->Html->url(array('controller'=>'usuarios','action' => 'edit', $usrLogado['id']))  ?>">Configuração</a> </li>
				<li class="padding-none">
				  <div class="dropdown-signout" style="width:100%;"><i class="fa fa-sign-out"></i> <?php echo $this->Html->link('Deslogar', array('controller'=>'Usuarios', 'action'=>'logout')); ?></div>
				</li>
			  </ul>
			</li>
		  </ul>
		</div>
	  </div>
	</header>
	<!-- End: Header --> 


	<!-- Start: Main -->
	<div id="main"> 
	  <!-- Start: Sidebar -->
	  <aside id="sidebar">
		<div id="sidebar-search">
		  <div class="sidebar-toggle"> <i class="fa fa-bars"></i> </div>
		</div>
		<div id="sidebar-menu"><!-- Inicio: Menu -->
		  <ul class="nav sidebar-nav">
			<li> 
				<a class="accordion-toggle" id="idMenuAlunos" href="#acorAluno">
					<span class="glyphicons icon-useralt"></span>
					<span class="sidebar-title">Alunos</span>
					<span class="caret"></span>
				</a>
			  <ul id="acorAluno" class="nav sub-nav">
				<!--li><a href="buttons.html"><span class="glyphicons icon-adduseralt"></span> Novo</a></li-->
				<li><a href="<?php echo $this->Html->url(array('controller'=>'alunos', 'action' => 'index')); ?>"><span class="glyphicons glyphicons-list"></span> Listar</a></li>
				<li><a href="<?php echo $this->Html->url(array('controller'=>'alunos', 'action' => 'indexporturma')); ?>"><span class="glyphicons glyphicons-search"></span> Por Turma</a></li>
			  </ul>
			</li>
			<li> <a id="idMenuDash" href="<?php echo $this->Html->url(array('controller'=>'dashboards', 'action' => 'index')); ?>"><span class="glyphicons glyphicons-star"></span><span class="sidebar-title">Dashboard</span></a> </li>
			<li> 
				<a class="accordion-toggle" id="idMenuUsuario" href="#acorUsuarios">
					<span class="glyphicons glyphicons-user"></span>
					<span class="sidebar-title">Usuários</span>
					<span class="caret"></span>
				</a>
			  <ul id="acorUsuarios" class="nav sub-nav">
				<li><a href="<?php echo $this->Html->url(array('controller' => 'usuarios', 'action' => 'add'));?>"><span class="glyphicons glyphicons-user_add"></span> Novo</a></li>
				<li><a href="<?php echo $this->Html->url(array('controller' => 'usuarios', 'action' => 'index'));?>"><span class="glyphicons glyphicons-list"></span> Listar</a></li>
			  </ul>
			</li>
			<li> 
				<a class="accordion-toggle" id="idMenuCurso" href="#acorCursos">
					<span class="glyphicons typcn typcn-mortar-board"></span>
					<span class="sidebar-title">Cursos</span>
					<span class="caret"></span>
				</a>
			  <ul id="acorCursos" class="nav sub-nav">
				<li><a href="<?php echo $this->Html->url(array('controller' => 'cursos', 'action' => 'add'));?>"><span class="glyphicons typcn typcn-mortar-board"></span> Novo</a></li>
				<li><a href="<?php echo $this->Html->url(array('controller' => 'cursos', 'action' => 'index'));?>"><span class="glyphicons glyphicons-list"></span> Listar</a></li>
			  </ul>
			</li>
			<li> 
				<a class="accordion-toggle" id="idMenuTurma" href="#acorTurma">
					<span class="glyphicons glyphicons-group"></span>
					<span class="sidebar-title">Turmas</span>
					<span class="caret"></span>
				</a>
			  <ul id="acorTurma" class="nav sub-nav">
				<li><a href="<?php echo $this->Html->url(array('controller' => 'turmas', 'action' => 'add'));?>"><span class="glyphicons glyphicons-group"></span> Novo</a></li>
				<li><a href="<?php echo $this->Html->url(array('controller' => 'turmas', 'action' => 'index'));?>"><span class="glyphicons glyphicons-list"></span> Listar</a></li>
			  </ul>
			</li>
			<li> 
				<a class="accordion-toggle" id="idMenuCert" href="#acorCert">
					<span class="glyphicons glyphicons-group"></span>
					<span class="sidebar-title">Certificados</span>
					<span class="caret"></span>
				</a>
			  <ul id="acorCert" class="nav sub-nav">
				<li><a href="<?php echo $this->Html->url(array('controller' => 'certificados', 'action' => 'index'));?>"><span class="glyphicons glyphicons-list"></span> Listar</a></li>
			  </ul>
			</li>			
		  </ul>
		</div><!-- fim: Main -->
	  </aside>
	  <!-- End: Sidebar --> 
	<!-- Start: Content -->
	<section id="content">
	<?php echo $this->fetch('content'); ?>
	</section>	<!-- End: Content --> 	


	</div><!-- End: Main --> 


<!-- Core Javascript - via CDN -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

<!-- Plugins - Via CDN -->
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/flot/0.8.1/jquery.flot.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery-sparklines/2.1.2/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/fullcalendar/1.6.4/fullcalendar.min.js"></script>

<!-- Plugins - Via Local Storage
<script type="text/javascript" src="vendor/plugins/jqueryflot/jquery.flot.min"></script>
<script type="text/javascript" src="vendor/plugins/sparkline/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="vendor/plugins/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="vendor/plugins/calendar/fullcalendar.min.js"></script>
-->


<?php
 		echo $this->fetch('script'); 


?>


<script type="text/javascript">
jQuery(document).ready(function() {

  Core.init();

  $('#datatable').dataTable( {
	"aoColumnDefs": [{ 'bSortable': false, 'aTargets': [ -1 ] }],
	"oLanguage": { 
	"oPaginate": {"sPrevious": "", "sNext": ""}, 
	"sInfo": "Exibindo _START_ a _END_ de _TOTAL_ entradas",
	"sInfoFiltered": "(filtro feito em _MAX_ entradas)",
	"sZeroRecords": "Sem resultado.",
	"sInfoEmpty": "Não foi encontrado nenhum resultado",
	"sLengthMenu": "Exibir _MENU_ registros"
	},
	"iDisplayLength": 10,
	"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
  });	
  
  $("select[name='datatable_length']").chosen();	
  $.fn.editable.defaults.mode = 'popup';
  $.fn.editable.defaults.ajaxOptions = {type: "put"}
  $('.xedit').editable({
	value: 0,
	source: [
	{value: 0, text: 'Selecione'},
	{value: 1, text: 'Cursando'},
	{value: 2, text: 'Trancado'},
	{value: 3, text: 'Abandonado'},
	{value: 4, text: 'Concluido'}
	],
	url:"",
	success: function(response, newValue) {
		var url = "/AlunosTurmas/edit/" +$(this).attr('data-pk');


		var request = $.ajax({
			url: url,
			type: "PUT",
			data: { status_aluno : newValue },
			dataType: "json"
		});

	}

});



  $('.editavelNota').editable({
	value: "",
	url:"",
	success: function(response, newValue) {
		var url = "";
		var method = "";
		if($(this).attr('data-pk')){
			method = "PUT";
			url = "/Notas/edit/" +$(this).attr('data-pk');
		}else{
			method = "POST";
			url = "/Notas/add/";
		}
		 


		var request = $.ajax({
			url: url,
			type: method,
			data: { nota : newValue, materia_id: $(this).attr('materia_id'), aluno_id : $(this).attr('aluno_id') },
			dataType: "json"
		});

	}

});




});
</script>	
</body>
</html>
