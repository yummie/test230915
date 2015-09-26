<?php
App::uses('AppModel', 'Model');
/**
 * Usuario Model
 *
 */
class Usuario extends AppModel {

/**
 * Display field
 *
 * @var string
 */

	public $displayField = 'id';
	public $name = 'Usuario';

/**
 * Validation rules
 *
 * @var array
 */
	public $validate = array(
		'vch_nome' => array(
			'notEmpty' => array(
				'rule' => array('notEmpty'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),

		'vch_senha' => array(
			'notEmpty' => array(
				'rule' => array('notEmpty'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),

		'vch_email' => array(
			'required' => array(
				'rule' => array('email', true), 
				'message' => 'Por favor entre um e-mail válido.'
			)
		),

		'flt_lat' => array(
			'numeric' => array(
				'rule' => array('numeric'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),		

		'flt_lng' => array(
			'numeric' => array(
				'rule' => array('numeric'),
				//'message' => 'Your custom message here',
				//'allowEmpty' => false,
				//'required' => false,
				//'last' => false, // Stop validation after this rule
				//'on' => 'create', // Limit validation to 'create' or 'update' operations
			),
		),	
		'vch_foto' => array(
		),

	);
	
	public function beforeSave($options = array()) {
		if (isset($this->data[$this->alias]['vch_senha'])) {
			$this->data[$this->alias]['vch_senha'] = AuthComponent::password($this->data[$this->alias]['vch_senha']);
		}
		return true;
	}	


}
