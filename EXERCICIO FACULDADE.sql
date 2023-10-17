CREATE DATABASE FACULDADE;

SET foreign_key_checks = 0;


-- CRIACAO DA TABELA CURSOS 
CREATE TABLE Curso(
id_curso int not null primary key,
nome_curso varchar(100) not null unique,
duracao_curso int unsigned,
professor_curso int,
foreign key (professor_curso) references Professor(id_professor)
);


-- CRIACAO DO PROCEDURE PARA CRIACAO DE CURSOS 
DELIMITER $ 

CREATE PROCEDURE inserirCurso(id INT ,nome varchar (100), duracao int , professor int)

BEGIN 

declare existe int;
SELECT COUNT(*) into existe from Professor where professor = id_professor; 
IF existe!=0 then
INSERT INTO Curso (id_curso,nome_curso,duracao_curso,professor_curso) values (id,nome,duracao,professor);
INSERT INTO Curso_Prof (id_curso_CP,id_prof_CP) values (id,professor);
END IF ;

END$

DELIMITER ;

DELIMITER $ 

CREATE PROCEDURE buscarCurso(id INT)

BEGIN 

declare existe int;
SELECT COUNT(*) into existe from Curso where id = id_curso; 
IF existe!=0 then
SELECT curso.nome_curso as Nome_Curso, curso.duracao_curso as Duracao_Semestres, Professor.nome_professor
from Curso
JOIN
    Curso_Prof ON Curso.id_curso = Curso_Prof.id_curso_CP
JOIN
    Professor ON Curso_Prof.id_prof_CP = Professor.id_professor;
END IF ;

END$

DELIMITER ;

call buscarCurso(1);




CREATE TABLE Professor(
id_professor int primary key not null,
nome_professor varchar(100) not null,
curso_professor int not null,
foreign key (curso_professor) references Curso(id_curso)
);


INSERT INTO Professor values ('1','Nelio Alves', '1');
INSERT INTO Professor values ('2','Agnaldo Sousa', '2');
INSERT INTO Professor values ('4','Roberto Santos', '3');
call InserirCurso ('1', 'Curso Java', 4, 1);
call InserirCurso ('2', 'Curso PhP', 4, 2);
call InserirCurso ('3', 'Curso C++', 4, 4);




Create Table Aluno(
id_aluno int primary key not null,
primeiro_nome_aluno varchar(50) not null,
sobrenome_aluno varchar(50) not null,
nome_completo_aluno varchar(120) as (concat(primeiro_nome_aluno, " ", sobrenome_aluno)),
id_curso_aluno int not null,
email_aluno varchar(100),
foreign key (id_curso_aluno) references Curso(id_curso)
);


CREATE TABLE Curso_Aluno (
id_curso_CA int,
id_aluno_CA int,
foreign key (id_curso_CA) references Curso(id_curso),
foreign key (id_aluno_CA) references Aluno(id_aluno)
);

CREATE TABLE Curso_Prof (
id_curso_CP int,
id_prof_CP int,
foreign key (id_curso_CP) references Curso(id_curso),
foreign key (id_prof_CP) references Professor(id_professor)
);




DELIMITER $ 

CREATE PROCEDURE inserirAluno(id INT ,nome varchar (50), sobrenome varchar (50), curso int)

BEGIN 

DECLARE contador int ;
DECLARE email varchar(100);
SELECT Count(*) into contador from Aluno where nome = primeiro_nome_aluno and sobrenome = sobrenome_aluno;
if contador = 0 THEN
SET email = concat (nome,'.',sobrenome,'@facens.br');
ELSE 
SET email = concat (nome,'.',sobrenome,contador,'@facens.br');
END IF;

INSERT INTO Aluno (id_aluno,primeiro_nome_aluno, sobrenome_aluno,id_curso_aluno,email_aluno) values (id,nome,sobrenome,curso,email);
INSERT INTO Curso_Aluno (id_curso_CA,id_aluno_CA) values (curso,id);
END$

DELIMITER ;













    
