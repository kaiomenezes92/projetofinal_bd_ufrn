drop database if exists clinica;
create database clinica;
use clinica;
create table paciente(
	cpf_p varchar (11) not null,
	p_nome varchar (15) not null,
	sobrenome varchar (15) not null,
	dt_nasc date not null,
	endereco varchar (100),
	sexo char not null check(sexo in('M', 'F')),
	telefone varchar (11),
    email varchar (50) not null,
    primary key (cpf_p)
);

create table recepcionista(
	cpf_r varchar (11) not null,
	p_nome varchar (15) not null,
	sobrenome varchar (15) not null,
	telefone varchar (11),
    email varchar (50) not null,
    primary key (cpf_r)
);

create table medico(
	crm varchar (6) not null,
	p_nome varchar (15) not null,
	sobrenome varchar (15) not null,
    email varchar (50) not null,
    especialidade varchar (30),
    primary key (crm)
);

create table consulta(
	id int not null identity (1,1),
	dt_dia date not null,
	fk_cpf_recepcionista varchar (11),
    fk_cpf_paciente varchar (11) not null,
    fk_crm_medico varchar (6) not null,
	resultado_exame varchar (100),
    receita varchar (250),
    primary key (id),
    foreign key (fk_cpf_recepcionista) references recepcionista (cpf_r),
    foreign key (fk_cpf_paciente) references paciente (cpf_p),
    foreign key (fk_crm_medico) references medico (crm)
);

insert into recepcionista
(cpf_r, p_nome, sobrenome, telefone, email)
values
('00000000001', 'Maria', 'Paula', '84900000001', 'mariapaula@email.com'),
('00000000002', 'Leila', 'Silva', '84900000002', 'leilasilva@email.com'),
('00000000003', 'Joana', 'Rocha', '84900000003', 'joanarocha@email.com');

insert into paciente
(cpf_p, p_nome, sobrenome, dt_nasc, endereco, sexo, telefone, email)
values
('00000000101', 'Joao', 'Macedo', '1989-01-30', 'Rua Sao Pedro 50 Lagoa Nova', 'M', '84900000101', 'joaomacedo@email.com'),
('00000000102', 'Almir', 'Soares', '1960-06-02', 'Rua Sao Jose 100 Tirol', 'M', '84900000102', 'almirsoares@email.com'),
('00000000103', 'Sara', 'Cardoso', '2000-11-05', 'Rua Santa Maria 10 Candelaria', 'F', '84900000103', 'saracardoso@email.com'),
('00000000104', 'Filipe', 'Souza', '1992-03-25', 'Rua Sao Joao 15 Felipe Camarao', 'M', '84900000104', 'filipesouza@email.com'),
('00000000105', 'Ana', 'Beatriz', '1999-05-01', 'Rua Sao Paulo 105 Cidade da Esperanca', 'F', '84900000105', 'anabeatriz@email.com'),
('00000000106', 'Leandra', 'Velasques', '2001-07-23', 'Rua Sao Judas 1050 Cidade Nova', 'F', '84900000106', 'leandravelasques@email.com'),
('00000000107', 'Lidiana', 'Furtado', '2002-04-15', 'Rua Sao Marcos 3 Panatis', 'F', '84900000107', 'lidianafurtado@email.com'),
('00000000108', 'Marta', 'Paulos', '1975-06-10', 'Rua Santa Aparecida 135 Satelite', 'F', '84900000108', 'martapaulos@email.com'),
('00000000109', 'Adriele', 'Caeiro', '1988-12-24', 'Rua Santo Expedito 65 Nova Natal', 'F', '84900000109', 'adrielecaeiro@email.com'),
('00000000110', 'Adam', 'Belmonte', '2003-07-16', 'Rua Padre Cicero 50 Areia Preta', 'M', '84900000110', 'adambelmonte@email.com');

insert into medico
(crm, p_nome, sobrenome, email, especialidade)
values
('0001', 'Dr. Maurilio', 'Andrade', 'maurilioandrade@email.com', 'Cardiologista'),
('0002', 'Dra. Rosa', 'Mendes', 'rosamendes@email.com', 'Mastologista'),
('0003', 'Dra. Carla', 'Bezerra', 'carlabezerra@email.com', 'Dermatologista');

insert into consulta
(dt_dia, fk_cpf_recepcionista, fk_cpf_paciente, fk_crm_medico, resultado_exame, receita)
values
('2021-09-01', '00000000001', '00000000101', '0001', 'clinica.com/exame', 'Enalapril - 1 CX - 4/4h'),
('2021-09-01', '00000000002', '00000000102', '0002', 'clinica.com/exame', 'Dipirona - 1 CX - 6/6h'),
('2021-09-02', '00000000003', '00000000103', '0003', 'clinica.com/exame', 'Centrum - 1 CX - 24/24h'),
('2021-09-02', '00000000001', '00000000104', '0001', '', 'Enalapril - 1 CX - 4/4h'),
('2021-09-02', '00000000002', '00000000105', '0002', 'clinica.com/exame', 'Captopril - 1 CX - 6/6h'),
('2021-09-02', '00000000001', '00000000106', '0003', '', 'Dexametasona - 1 CX - 24/24h'),
('2021-09-02', '00000000002', '00000000107', '0003', '', 'Vit C - 1 CX - 4/4h'),
('2021-09-03', '00000000002', '00000000108', '0002', '', 'Dipirona - 1 CX - 6/6h'),
('2021-09-03', '00000000003', '00000000109', '0001', '', 'AS - 1 CX - 24/24h'),
('2021-09-03', '00000000003', '00000000110', '0001', 'clinica.com/exame', '');

-- Questao 1: Consultar se o paciente x foi atendido pelo medico y
select * from consulta where fk_cpf_paciente = '00000000101' and fk_crm_medico = '0001';

-- Questao 2: Contagem de consultas por medico
select count(fk_crm_medico) from consulta where fk_crm_medico = '0001';
select count(fk_crm_medico) from consulta where fk_crm_medico = '0002';
select count(fk_crm_medico) from consulta where fk_crm_medico = '0003';

-- Questao 3: Contagem de medico que mais fez consulta
select top 1 fk_crm_medico, COUNT(*) as qtd from consulta group by fk_crm_medico order by qtd desc;

