#CRIANDO O BANCO DE DADOS
CREATE DATABASE universidade_u;

#LISTANDO OS BANCOS DE DADOS
SHOW DATABASES;

#SELECIONAR O BANCO DE DADOS
USE universidade_u;

#CRIAR TABELA
CREATE TABLE Aluno ( 
 sexo CHAR(1),  
 idade INT,  
 data_inscricao_curso DATE,  
 telefone VARCHAR(20),  
 valor_pago_curso FLOAT(10,2),  
 ativo_sn INT,  
 endereco VARCHAR(255),  
 nome VARCHAR(255) ); 

#DELETANDO TABELA
 DROP TABLE Aluno;

# LISTANDO AS TABELAS
SHOW TABLES;