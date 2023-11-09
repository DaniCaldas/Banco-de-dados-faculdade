CREATE SEQUENCE seq_log2;
CREATE TABLE log2(
	id 			integer default(nextval('seq_log2')) primary key,
	id_pessoa 	numeric(11),
	nome 		varchar(100),
	data 		timestamp,
	usuario 	text
);

CREATE TABLE pessoa(
	id 		numeric(11) primary key,
	nome 	varchar(100),
	rg 		numeric(9) NOT NULL unique,
	cpf 	numeric(13) unique
);

-- exercicio 1
CREATE OR REPLACE FUNCTION func_log2()
RETURNS trigger AS
'
BEGIN
	
	IF NEW.nome IS NULL THEN
		RAISE EXCEPTION '' O nome não pode estar vazio'';
	END IF;
	
	IF NEW.cpf IS NULL THEN
		RAISE EXCEPTION '' Campo cpf não pode estar vazio!'';
	END IF;
	
	Insert into log2 (id_pessoa, nome, data, usuario) 
		values (NEW.id, NEW.nome, now(), current_user);
	RETURN NEW;

END;
'
Language 'plpgsql';

CREATE TRIGGER tg_log2 BEFORE insert ON pessoa
	FOR EACH ROW EXECUTE PROCEDURE func_log2();


SELECT * FROM PESSOA;
SELECT * FROM LOG1;
SELECT * FROM LOG2;

INSERT INTO PESSOA VALUES (4,'',32131,154712);

SELECT * FROM PESSOA;
	SELECT * FROM LOG1;
	SELECT * FROM LOG2;



--exercicio 2

CREATE TABLE emp(
	id 				integer primary key,
	nome_emp 		text,
	salario 		numeric(10,2),
	ultima_data 	timestamp,
	ultimo_usuario 	text
);
create sequence log_emp_seq;
create table log_emp(
	id 			integer default(nextval('log_emp_seq')) primary key,
	id_emp			integer,
	nome_emp 	text,
	data 		timestamp,
	usuario 	text
);
alter table log_emp 
drop column id_emp 

create or replace function log_emp_update()
returns trigger as 
'
	begin
		insert into log_emp values (new.id, new.nome_emp, now(), current_user);
	return new;
	end;
	
'
language 'plpgsql';

create or replace function log_emp_delete()
returns trigger as 
'
	begin
		insert into log_emp values (old.id, old.nome_emp, now(), current_user);
	return old;
	end;
	
'
language 'plpgsql';


create trigger new_emp_log after update
on emp for row execute procedure log_emp_update();

create trigger old_emp_log before update
on emp for row execute procedure log_emp_delete();

select * from emp;
select * from log_emp;
insert into emp values (1, 'JBGMOL', 10000.00, now(), current_user)

update emp
set salario = 90000.90
where id = 1

delete from emp
where id = 1

-- exercicio 3
