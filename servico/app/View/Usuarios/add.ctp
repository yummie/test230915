<div class="container">
  <div class="row">
    <div class="col-md-12">


		<div class="panel">
			<div class="panel-heading">
			  <div class="panel-title"> <i class="fa fa-pencil"></i> Novo Usuário </div>
			</div>
			<div class="panel-body">
			  <!--form role="form" class="form-horizontal"-->
			﻿  <?php
				echo $this->Form->create('Usuario', array('enctype' => 'multipart/form-data','action' => 'saveFoto'));

			  ?>
				<div class="form-group">
				  <label class="col-lg-2 control-label" for="nomeUser">Nome</label>
				  <div class="col-lg-10">
					<!--input type="text" placeholder="Nome" class="form-control" id="inputStandard"-->
					<?php
						echo $this->Form->input('Usuario.nome', array(
							'type' => 'text',
							'class' => 'form-control',
							'autocomplete' => 'off',
							'id' => 'nomeUser',
							'placeholder' => 'Nome',
							'label' => false,
						));
					?>
				  </div>
				</div>

				<div class="form-group">
				  <label class="col-lg-2 control-label" for="loginUser">Login</label>
				  <div class="col-lg-10">
					<!--input type="text" placeholder="Nome" class="form-control" id="inputStandard"-->
					<?php
					echo $this->Form->input('Usuario.foto', array(
					    'type' => 'file'
					));		
					?>
				  </div>
				</div>

	
					<?php
					echo $this->Html->image( "../app/webroot/img/4.jpg", array('class'=>"img-responsive"));

						if ($this->Form->isFieldError('Usuario.re_senha')) {
							echo $this->Form->error('Usuario.re_senha','Os campos senha e confirmar senha devem ser iguais.', array('wrap' => 'label','class'=>'error'));
	
						}

						echo $this->Form->button('Salvar', array('type' => 'submit','class'=>'btn btn-info btn-gradient btn-lg pull-right margin-top'));

					?>
				  </div>
				</div>
			  </form>
			</div>
		</div>


	</div>
  </div>
</div>
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


echo $this->Html->scriptBlock(
    'jQuery(document).ready(function() {
		openAbaMenu("idMenuUsuario",0);
	});',
    array('inline' => false)
);
?>