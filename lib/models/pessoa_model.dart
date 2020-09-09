class Pessoa{
  var tp_pessoa,
      tx_nome,
      tx_sobrenome,
      nr_cpf_cnpj,
      nr_rg,
      tx_sexo,
      tx_endereco,
      nr_endereco,
      tx_complemento,
      tx_cep,
      tx_bairro,
      cd_cidade,
      tx_estado,
      nr_ibge,
      dt_nascimento,
      dt_cadastro,
      tp_tipo_sanguineo,
      tx_foto_perfil_caminho,
      tx_cidade,
      tx_email,
      cd_cargo,
      tx_cargo,
      id_pessoa,
      nr_cns,
      nr_celular
  ;

  Pessoa(this.tp_pessoa, this.tx_nome, this.tx_sobrenome, this.nr_cpf_cnpj,
      this.nr_rg, this.tx_sexo, this.tx_endereco, this.nr_endereco,
      this.tx_complemento, this.tx_cep, this.tx_bairro, this.cd_cidade,
      this.tx_estado, this.nr_ibge, this.dt_nascimento, this.dt_cadastro,
      this.tp_tipo_sanguineo, this.tx_foto_perfil_caminho, this.tx_cidade,
      this.tx_email, this.cd_cargo, this.tx_cargo, this.id_pessoa);

  Pessoa.fromJson(Map<String, dynamic> json) {
    tp_pessoa = json['tp_pessoa'];
    tx_nome = json['tx_nome'];
    tx_sobrenome = json['tx_sobrenome'];
    nr_cpf_cnpj = json['nr_cpf_cnpj'];
    nr_rg = json['nr_rg'];
    tx_sexo = json['tx_sexo'];
    tx_endereco = json['tx_endereco'];
    nr_endereco = json['nr_endereco'];
    tx_complemento = json['tx_complemento'];
    tx_cep = json['tx_cep'];
    tx_bairro = json['tx_bairro'];
    cd_cidade = json['cd_cidade'];
    tx_estado = json['tx_estado'];
    nr_ibge = json['nr_ibge'];
    dt_nascimento = json['dt_nascimento'];
    dt_cadastro = json['dt_cadastro'];
    tp_tipo_sanguineo = json['tp_tipo_sanguineo'];
    tx_foto_perfil_caminho = json['tx_foto_perfil_caminho'];
    tx_cidade = json['tx_cidade'];
    tx_email = json['tx_email'];
    cd_cargo = json['cd_cargo'];
    tx_cargo = json['tx_cargo'];
    id_pessoa = json['cd_pessoa'];
  }

  cadastra_paciente(tx_nome, tx_sexo, nr_cpf_cnpj, nr_cns, nr_celular){
    print('$tx_nome $tx_sexo $nr_cpf_cnpj $nr_cns $nr_celular');
  }
}
