<?php

App::uses('AppShell', 'Console/Command');
App::uses('CakeEmail', 'Network/Email');


class ReciclagemShell extends AppShell {
	public $uses = array('Aluno', 'AlunosTurma');
	
	public function main() {
		$alunosReciclagem = $this->Aluno->query("SELECT * FROM turmas t
										INNER JOIN alunos_turmas at ON ( t.id = at.turma_id )
										INNER JOIN alunos a ON ( at.aluno_id = a.id )
										INNER JOIN cursos c ON (c.id = t.curso_id)
										WHERE DATE_FORMAT( now( ) , '%Y-%d-%m' ) = DATE_FORMAT( DATE_ADD( t.dtFim, INTERVAL 2 YEAR ) , '%Y-%d-%m' )
										");	
										
       
		
		//carregndo o template do email
		$strHtml = file_get_contents(WWW_ROOT."files/emailReciclagen.html");
		$email = new CakeEmail();
		foreach ($alunosReciclagem as $key=>$aluno){
			$corpoEmail =  $strHtml;
			$nome = $aluno['a']['nome'];
			$curso = $aluno['c']['titulo'];
			$corpoEmail = str_replace("##NOME##", $nome, $corpoEmail);
			$corpoEmail = str_replace("##CURSO##", $curso, $corpoEmail);
			
			$email->emailFormat('html');
			$email->from('admin@cetafba.com.br');
			$email->to($aluno['a']['email']);
			$email->subject("Reciclagem do curso " . $aluno['c']['titulo']);
			$result = $email->send($corpoEmail);
			$aluno['at']['reciclagem'] = 1;
			$this->AlunosTurma->save( $aluno['at']);
				
			
		}
		
	}

}