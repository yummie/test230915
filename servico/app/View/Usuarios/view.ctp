<div id="topbar">
  <ol class="breadcrumb">
    <li><a href="<?php echo $this->Html->url(array('controller'=>'dashboards', 'action' => 'index')); ?>"><i class="fa fa-home"></i></a></li>
    <li><a href="#">Home</a></li>
    <li class="active">Visualizar Usuário</li>
  </ol>
</div>
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="panel">
				<div class="panel-heading">
					<div class="panel-title"> <i class="fa fa-pencil"></i>Dados Usuário </div>
				</div>
				<div class="panel-body">




					<form method="post" role="form" class="form-horizontal" id="post_id_<?php echo $usuario['Usuario']['id'];?>" name="post_id_<?php echo $usuario['Usuario']['id'];?>" action="<?php echo $this->Html->url(array('action' => 'delete', $usuario['Usuario']['id']));?>">
						<input type="hidden" value="POST" name="_method">
		                <div class="form-group">
		                  <label for="inputStandard" class="col-lg-2 control-label">Nome</label>
		                  <div class="col-lg-10">
		                    <p class="form-control-static text-muted"><?php echo h($usuario['Usuario']['nome']); ?></p>
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="inputPassword" class="col-lg-2 control-label">Login</label>
		                  <div class="col-lg-10">
						  	<p class="form-control-static text-muted"><?php echo h($usuario['Usuario']['login']); ?></p>
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="inputPassword" class="col-lg-2 control-label">Ultimo acesso em</label>
		                  <div class="col-lg-10">
						  	<p class="form-control-static text-muted"><?php echo h($usuario['Usuario']['ultimo_login']); ?></p>
		                  </div>
		                </div>
						<div class="form-group">
							<div class="col-lg-12">
								<button class="btn btn-danger btn-gradient pull-right" style="margin-right:8px;" onClick='if (confirm("Are you sure you want to delete # <?php echo $usuario['Usuario']['nome']; ?>?")) { document.post_id_<?php echo $usuario["Usuario"]["id"];?>.submit(); } event.returnValue = false; return false;' type="button"><i class="glyphicon glyphicon-trash"></i> Excluir </button>
								<button type="button" class="btn btn-success btn-gradient pull-right" style="margin-right:8px;" onClick="callPage('<?php echo $this->Html->url(array('action' => 'edit', $usuario['Usuario']['id']));?>');"> <i class="glyphicon glyphicon-pencil"></i> Editar </button>
								<button class="btn btn-primary btn-gradient pull-right" type="button" style="margin-right:8px;" onClick="callPage('<?php echo $this->Html->url(array('action' => 'add'));?>');"><i class="glyphicons glyphicons-user_add"></i> Novo</button>
							</div>
						</div>
					</form>




				</div><!--fim panel-body -->
			</div><!--fim panel -->
		</div><!--fim col-md-12 -->
	</div><!--row -->
</div><!--container -->
<script type="text/javascript">

function callPage(pUrl){

	window.location.href = pUrl;

}

</script>
<?php 
$this->Html->script('vendor/plugins/datatables/js/datatables.js', array('inline' => false));
$this->Html->script('vendor/editors/xeditable/js/bootstrap-editable.js', array('inline' => false));
$this->Html->css('vendor/plugins/datatables/css/datatables.min.css', array('inline' => false));
$this->Html->css('vendor/plugins/chosen/chosen.min', array('inline' => false));
//Theme Javascript 

$this->Html->script('uniform.min', array('inline' => false));
$this->Html->script('main', array('inline' => false));
$this->Html->script('custom', array('inline' => false));
//echo $this->Html->css(array('vendor/plugins/calendar/fullcalendar.css','vendor/plugins/datatables/css/datatables.min.css','css/animate.css'));

?>
