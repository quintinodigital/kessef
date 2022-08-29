/*
    Gerenciador de Pessoas
*/

-- select * from tb_tipo_pessoa;
delete from tb_tipo_pessoa where codigo is not null;
insert into tb_tipo_pessoa(descricao) values('Pessoa Física');
insert into tb_tipo_pessoa(descricao) values('Pessoa Jurídica');

-- select * from tb_pessoa;
delete from tb_pessoa where codigo is not null;
insert into tb_pessoa(id_tipo_pessoa, nome) values((select codigo from tb_tipo_pessoa where descricao = 'Pessoa Física'), 'José Quintino');
insert into tb_pessoa(id_tipo_pessoa, nome) values((select codigo from tb_tipo_pessoa where descricao = 'Pessoa Física'), 'Priscila Mariano');
insert into tb_pessoa(id_tipo_pessoa, nome) values((select codigo from tb_tipo_pessoa where descricao = 'Pessoa Jurídica'), 'Banco do Brasil');
insert into tb_pessoa(id_tipo_pessoa, nome) values((select codigo from tb_tipo_pessoa where descricao = 'Pessoa Jurídica'), 'Banco Digio');

-- select * from tb_instituicao_bancaria;
delete from tb_instituicao_bancaria where codigo is not null;
insert into tb_instituicao_bancaria(id_pessoa, numero_banco) values((select codigo from tb_pessoa where nome = 'Banco do Brasil'), '000');

-- select * from tb_tipo_conta_bancaria;
delete from tb_tipo_conta_bancaria where codigo is not null;
insert into tb_tipo_conta_bancaria(descricao) values('Conta Corrente');
insert into tb_tipo_conta_bancaria(descricao) values('Conta Poupança');
insert into tb_tipo_conta_bancaria(descricao) values('Conta Salário');
insert into tb_tipo_conta_bancaria(descricao) values('Conta Investimento');

-- select * from tb_conta_bancaria;
delete from tb_conta_bancaria where codigo is not null;
insert into tb_conta_bancaria(id_tipo_conta_bancaria, id_instituicao_bancaria, id_pessoa_titular_conta, numero_agencia, numero_conta, data_abertura, data_ecenrramento, saldo, data_atualizacao, usuario_atualizacao) values(
    (select codigo from tb_tipo_conta_bancaria where descricao = 'Conta Corrente'),
    (select codigo from tb_instituicao_bancaria where numero_banco = '000'),
    (select codigo from tb_pessoa where nome = 'José Quintino'),
    '0001',
    '78985-4',
    current_date,
    null,
    0.0,
    current_date,
    'José Quintino'
);

-- select * from tb_funcao_cartao_bancario;
delete from tb_funcao_cartao_bancario where codigo is not null;
insert into tb_funcao_cartao_bancario(descricao) values('Crédito');
insert into tb_funcao_cartao_bancario(descricao) values('Débito');

-- select * from tb_cartao_bancario;
delete from tb_cartao_bancario where codigo is not null;
insert into tb_cartao_bancario(id_conta_bancaria, data_recebimento, data_liberacao, data_expiracao, limite, dia_vencimento) values(
    (select codigo from tb_conta_bancaria where numero_agencia = '0001'),
    null,
    null,
    '2027-01-01',
    2500,
    10
);

-- select * from tb_cartao_bancario_funcao;
delete from tb_cartao_bancario_funcao where codigo is not null;
insert into tb_cartao_bancario_funcao(id_cartao_bancario, id_funcao_cartao_bancario) values(
    (select codigo from tb_cartao_bancario where data_expiracao = '2027-01-01'),
    (select codigo from tb_funcao_cartao_bancario where descricao = 'Crédito')
);
insert into tb_cartao_bancario_funcao(id_cartao_bancario, id_funcao_cartao_bancario) values(
    (select codigo from tb_cartao_bancario where data_expiracao = '2027-01-01'),
    (select codigo from tb_funcao_cartao_bancario where descricao = 'Débito')
);

/*
    Gerenciador de Acessos
*/

-- select * from tb_tipo_acesso;
delete from tb_tipo_acesso where codigo is not null;
insert into tb_tipo_acesso(descricao) values('Aplicativo');
insert into tb_tipo_acesso(descricao) values('Opera��o Banc�ria');
insert into tb_tipo_acesso(descricao) values('Web Site');

-- select * from tb_acesso;
delete from tb_acesso where codigo is not null;
insert into tb_acesso(id_pessoa_responsavel, id_tipo_acesso, descricao_acesso, descricao_metodo_recuperacao_acesso, descricao_identificador_recuperacao_acesso, url, data_criacao, data_expiracao, chave_alfanumerica) values(
    (select codigo from tb_pessoa where nome = 'Jos� Quintino'),
    (select codigo from tb_tipo_acesso where descricao like 'Aplicativo'),
    'Aplicativo Banco do Brasil',
    null,
    null,
    null,
    '2022-01-01',
    null,
    sha256('senha_aplicativo')
);
