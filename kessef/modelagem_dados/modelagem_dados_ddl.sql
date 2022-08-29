/*
    Gerenciador de Pessoas
*/

drop table if exists tb_tipo_pessoa cascade;
create table tb_tipo_pessoa(
    codigo serial primary key,
    descricao varchar(100) unique not null
);

drop table if exists tb_pessoa cascade;
create table tb_pessoa(
    codigo serial primary key,
    id_tipo_pessoa integer not null,
    nome varchar(100) unique not null,
    foreign key (id_tipo_pessoa) references tb_tipo_pessoa (codigo)
);

/*
    Gerenciador de Conta Bancária
*/

drop table if exists tb_instituicao_bancaria cascade;
create table tb_instituicao_bancaria(
    codigo serial primary key,
    id_pessoa integer not null,
    numero_banco varchar(3) unique not null,
    foreign key (id_pessoa) references tb_pessoa (codigo)
);

drop table if exists tb_tipo_conta_bancaria cascade;
create table tb_tipo_conta_bancaria(
    codigo serial primary key,
    descricao varchar(100) unique not null
);

drop table if exists tb_conta_bancaria cascade;
create table tb_conta_bancaria(
    codigo serial primary key,
    id_tipo_conta_bancaria integer not null,
    id_instituicao_bancaria integer not null,
    id_pessoa_titular_conta integer not null,
    numero_agencia varchar(4) unique not null,
    numero_conta varchar(100) unique not null,
    data_abertura date not null,
    data_ecenrramento date null,
    saldo double precision not null,
    data_atualizacao date not null,
    usuario_atualizacao varchar(100) not null,
    foreign key (id_tipo_conta_bancaria) references tb_tipo_conta_bancaria (codigo),
    foreign key (id_instituicao_bancaria) references tb_instituicao_bancaria (codigo),
    foreign key (id_pessoa_titular_conta) references tb_pessoa (codigo)
);

/*
    Gerenciador de Cartão Bancário
*/

drop table if exists tb_funcao_cartao_bancario cascade;
create table tb_funcao_cartao_bancario(
    codigo serial primary key,
    descricao varchar(100) unique not null
);

drop table if exists tb_cartao_bancario cascade;
create table tb_cartao_bancario(
    codigo serial primary key,
    id_conta_bancaria integer not null,
    data_recebimento date null,
    data_liberacao date null,
    data_expiracao date not null,
    limite double precision not null,
    dia_vencimento integer not null,
    foreign key (id_conta_bancaria) references tb_conta_bancaria (codigo)
);

drop table if exists tb_cartao_bancario_funcao cascade;
create table tb_cartao_bancario_funcao(
    codigo serial primary key,
    id_cartao_bancario integer not null,
    id_funcao_cartao_bancario integer not null,
    foreign key (id_cartao_bancario) references tb_cartao_bancario (codigo),
    foreign key (id_funcao_cartao_bancario) references tb_funcao_cartao_bancario (codigo)
);

/*
    Gerenciador de Acessos
*/

drop table if exists tb_tipo_acesso cascade;
create table tb_tipo_acesso(
    codigo serial primary key,
    descricao varchar(100) unique not null
);

drop table if exists tb_acesso cascade;
create table tb_acesso(
    codigo serial primary key,
    id_pessoa_responsavel integer not null,
    id_tipo_acesso integer not null,
    descricao_acesso varchar(100) null,
    descricao_metodo_recuperacao_acesso varchar(100) null,
    descricao_identificador_recuperacao_acesso varchar(100) null,
    url varchar(100) null,
    data_criacao date not null,
    data_expiracao date null,
    chave_alfanumerica varchar(100) not null,
    foreign key (id_pessoa_responsavel) references tb_pessoa (codigo),
    foreign key (id_tipo_acesso) references tb_tipo_acesso (codigo)
);
