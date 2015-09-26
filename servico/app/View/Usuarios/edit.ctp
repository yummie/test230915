<div id="topbar">
  <ol class="breadcrumb">
    <li><a href="<?php echo $this->Html->url(array('controller'=>'dashboards', 'action' => 'index')); ?>"><i class="fa fa-home"></i></a></li>
    <li><a href="#">Home</a></li>
    <li class="active">Editar Usuários</li>
  </ol>
</div>
<div class="container">
  <div class="row">
    <div class="col-md-12">


		<div class="panel">
			<div class="panel-heading">
			  <div class="panel-title"> <i class="fa fa-pencil"></i> Editar Usuário </div>
			</div>
			<div class="panel-body">
			  <!--form role="form" class="form-horizontal"-->
			﻿  <?php
				echo $this->Form->create('Usuario', array('class' => 'form-horizontal', 'role'=>'form'));
			  ?>
				<div class="form-group">
				  <label class="col-lg-2 control-label" for="inputStandard">Nome</label>
				  <div class="col-lg-10">
					<!--input type="text" placeholder="Nome" class="form-control" id="inputStandard"-->
					<?php
						echo $this->Form->input('Usuario.nome', array(
							'type' => 'text',
							'class' => 'form-control',
							'autocomplete' => 'off',
							'placeholder' => 'Nome',
							'label' => false,
						));
					?>
				  </div>
				</div>

				<div class="form-group">
				  <label class="col-lg-2 control-label" for="inputStandard">Login</label>
				  <div class="col-lg-10">
					<!--input type="text" placeholder="Nome" class="form-control" id="inputStandard"-->
					<?php
						echo $this->Form->input('Usuario.login', array(
							'type' => 'text',
							'class' => 'form-control',
							'autocomplete' => 'off',
							'placeholder' => 'Login',
							'label' => false,
						));
					?>
				  </div>
				</div>

				<div class="form-group">
				  <label class="col-lg-2 control-label" for="inputStandard">E-mail</label>
				  <div class="col-lg-10">
					<!--input type="text" placeholder="Nome" class="form-control" id="inputStandard"-->
					<?php
						echo $this->Form->input('Usuario.email', array(
							'type' => 'text',
							'class' => 'form-control',
							'autocomplete' => 'off',
							'placeholder' => 'E-mail',
							'label' => false,
						));
					?>
				  </div>
				</div>

				<div class="form-group">
					<label class="col-md-3 col-lg-2 control-label">&nbsp;</label>
					<div class="col-md-9">
						<label class="checkbox-inline">
							<div class="checker" id="uniform-inlineCheckbox1"><span><input type="checkbox" value="option1" id="showSenhaCheckbox" class="checkbox"></span></div>
							<b>Alterar senha.</b>
						</label>
					</div>
				</div>


				<div id="editsSenha" style="display:none;">
					<div class="form-group">
					  <label class="col-lg-2 control-label" for="inputPassword">Senha</label>
					  <div class="col-lg-10">
						<!--input type="Password" placeholder="Password" id="inputPassword" class="form-control"-->
						<?php
							echo $this->Form->input('Usuario.senha', array(
								'type' => 'password',
								'class' => 'form-control',
								'autocomplete' => 'off',
								'disabled' => 'disabled',
								'placeholder' => 'Senha',
								'label' => false,
							));
						?>
					  </div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label" for="inputPassword">Confirmar Senha</label>
						<div class="col-lg-10">
						<!--input type="Password" placeholder="Password" id="inputPassword" class="form-control"-->
						<?php
							echo $this->Form->input('Usuario.re_senha', array(
								'type' => 'password',
								'class' => 'form-control',
								'autocomplete' => 'off',
								'disabled' => 'disabled',
								'placeholder' => 'Confirmar Senha',
								'label' => false,
								'error' => false
								
							));
							if ($this->Form->isFieldError('Usuario.re_senha')) {
								echo $this->Form->error('Usuario.re_senha','Os campos senha e confirmar senha devem ser iguais.', array('wrap' => 'label','class'=>'error'));

							}

						?>
						</div>
					</div>					
				</div><?php 
				echo $this->Form->input('Usuario.id');
				 echo $this->Form->button('Salvar', array('type' => 'submit','class'=>'btn btn-info btn-gradient btn-lg pull-right margin-top'));?>
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
		openAbaMenu("idMenuUsuario",-1);
				
	$( "#showSenhaCheckbox" ).click(function() {
		if($("#UsuarioReSenha").attr("disabled") == "disabled"){
			$("#UsuarioReSenha").removeAttr("disabled"); 
			$("#UsuarioSenha").removeAttr("disabled"); 
		}else{
			$("#UsuarioReSenha").attr("disabled","disabled"); 
			$("#UsuarioSenha").attr("disabled","disabled"); 		
		}	

		$( "#editsSenha" ).slideToggle("slow", function() {

		});		

	});		
		
		
		
		
	});',
    array('inline' => false)
);

?>
