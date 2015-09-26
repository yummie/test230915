<?php
App::uses('AppController', 'Controller');
App::import('Vendor', 'kint/Kint');
/**
 * Usuarios Controller
 *
 * @property Usuario $Usuario
 * @property PaginatorComponent $Paginator
 */
class UsuariosController extends AppController {

/**
 * Components
 *
 * @var array
 */
	public $components = array('RequestHandler');


	
	public function beforeFilter() {
		//$this->Auth->autoRedirect = false;
		parent::beforeFilter();
		$this->Auth->allow('add', 'login', 'edit', 'saveFoto');
	}
	

public function login() {

		if($this->RequestHandler->isPost() ){
			$dado = $this->request->input('json_decode');
			if (isset($dado->vch_senha) && isset($dado->vch_email)) {
				if ($dado->vch_email == "" || $dado->vch_senha == "") {
					echo '{"error":true}';
					exit;
				}
				$dado = $this->request->input('json_decode');
				$options = array('conditions' => array('Usuario.vch_email' => $dado->vch_email, 'Usuario.vch_senha' => AuthComponent::password($dado->vch_senha)));
				$usuario =  $this->Usuario->find('first', $options);
				if($usuario != null){
					echo json_encode($usuario["Usuario"]);
				}else{
					echo '{"error":true}';
				}
				exit;				
			}

		}
		echo '{"error":true}';
		exit;


}

	
/**
 * index method
 *
 * @return void
 */
	public function index() {

	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {

	}

/**
 * add method
 *
 * @return void
 */
	public function add() {
		if($this->RequestHandler->isPost() ){
			$this->Usuario->create();
			
			$dado = $this->request->input('json_decode');

			$usuario = array('Usuario' => array(
				'vch_nome' => $dado->vch_nome, 
				'vch_email' => $dado->vch_email,
				'vch_senha' => $dado->vch_senha,
				'flt_lat' => $dado->flt_lat,
				'flt_lng' => $dado->flt_lng								
			)); 

			$msgRetorno ="";

			if ($this->Usuario->save($usuario)) {
				$msgRetorno ='{"error":false}';
			}else{
				$msgRetorno ='{"error":true}';
			}
			echo $msgRetorno;
			exit;
		}		
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {

		$msgRetorno = "";

		if (!$this->Usuario->exists($id)) {
			$msgRetorno ='{"error":false, "msg":"Usuário não encontrado!"}';
			echo json_encode($msgRetorno);
			exit;
		}

		if ($this->request->is(array('post', 'put'))) {

			$dado = $this->request->input('json_decode');

			$usuario = array('Usuario' => array(
				'vch_nome'  => $dado->vch_nome, 
				'vch_email' => $dado->vch_email,
				'id'	    => $id,				
			));

			if(isset($dado->vch_senha)){
				$usuario["Usuario"]["vch_senha"] = $dado->vch_senha;
			}

			if ($this->Usuario->save($usuario)) {
				$msgRetorno ='{"error":false}';
			} else {
				$msgRetorno ='{"error":true}';
			}
			echo $msgRetorno;
			exit;
		}

	}


/**
 * saveFoto method
 *
 * @throws NotFoundException
 * @param Array $imagem
 * @return void
 */
	public function saveFoto($id = null){
		$dir = 'img';
		$dir = WWW_ROOT.$dir.DS;

		//var_dump($this->request->data);
		//exit;
		if (!empty($this->request->data)) {
			$imagem = $this->request->data["Usuario"]["foto"];
		}else{
			echo '{"error":true}';
			exit;
		}

		
		if(($imagem['error']!=0) and ($imagem['size']==0)) {
			echo '{"error":true}';
		}
		$this->checa_dir($dir);	
		$this->move_arquivos($imagem, $dir);
		$url_foto = $dir.$imagem['name'];
		
		$this->Usuario->id = $id;
		$this->Usuario->saveField('url_foto', $url_foto);

		echo '{"error":false, "url_foto":"'.$url_foto.'" }';	
		exit;
	}

/**
 * delete method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function delete($id = null) {

	}


	/**
	 * Verifica se o diretório existe, se não ele cria.
	 * @access private
	 * @param String $caminho
	 * 
	*/ 
	private function checa_dir($dir)
	{
		App::uses('Folder', 'Utility');
		$folder = new Folder();
		if (!is_dir($dir)){
			$folder->create($dir);
		}
	}

	/**
	 * Move o arquivo para a pasta de destino.
	 * @access private
	 * @param Array $imagem
	 * @param String $caminho
	*/ 
	private function move_arquivos($imagem, $dir)
	{
		App::uses('File', 'Utility');
		$arquivo = new File($imagem['tmp_name']);
		$arquivo->copy($dir.$imagem['name']);
		$arquivo->close();
	}

	/**
	 * Trata o nome removendo espaços, acentos e caracteres em maiúsculo.
	 * @access private
	 * @param String $imagem_nome
	*/ 
	private function trata_nome($imagem_nome)
	{
		$imagem_nome = strtolower(Inflector::slug($imagem_nome,'-'));
		return $imagem_nome;
	}

	
}
