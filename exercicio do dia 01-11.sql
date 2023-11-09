select * from tiponota;
select * from notas;

-- exercicio 1
create or replace function tipodanota(nota integer)
returns varchar as
$$
	declare result varchar;
	begin
		raise notice 'Função que retorna o tipo da nota';
		
		if nota = 1 then
			result := 'Nota do tipo p1';
		else 
			result := 'Nota do tipo p2';
		end if;
		return (result);
	end;
$$
language 'plpgsql';

select * from tipodanota(2);

--exercicio 2

create or replace function verificar_se_existe(nota varchar)
returns setof tiponota as
	$$
		select t.* from tiponota as t where t.nome = nota;		
	$$
language 'sql';

select * from  verificar_se_existe('p3')

-- exercicio 3

create or replace function adicionar_nota(tipo_nota int, nota numeric(3,2))
returns varchar as
	$$ 
		declare	result varchar;
		begin
			raise notice 'adicionando nota e verificando se o tipo dela existe';
			if tipo_nota in (select codigo from tiponota) then
				insert into notas values (5,1,1, tipo_nota, nota);
			else
				result := 'Tipo de nota não existe';
			end if;
			return (result);
		end;
	$$
language'plpgsql';

select * from adicionar_nota(1,9.00)		

-- exercicio 4
select * from notas
select * from aluno


CREATE OR REPLACE FUNCTION procurar_p1(int,varchar)
returns varchar as
	$$ 
		  	select a.rgm, d.nome, tp.nome
			from aluno as a, disciplina as d, tiponota as tp, notas as n 
			where a.rgm = n.rgm_aluno and d.codigo = n.codigo_disciplina and tp.codigo = n.tipo_nota
			and a.rgm = $1 and d.nome = $2 and tp.nome = 'p1';
	$$
language 'sql';

select * from procurar_p1(2, 'bd')