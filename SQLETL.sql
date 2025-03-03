


---seleção dos dados
select 
	d.DepartamentoKey, d.IDOrigem,
	d.nome, d.Sigla, d.OrcamentoMensal
from dados.Departamento d


--updates departamento
update dados.Departamento set
	Nome = d.Nome,
	Sigla = d.Sigla,
	OrcamentoMensal = d.OrcamentoMensal
from dados.Departamento d
inner join temp.StageDepartamento std on std.ID = d.IDOrigem;

select * from dados.Projeto


select 
	p.IDOrigem, p.Nome as NomeLkp,
	p.Identificador as IdentificadorLkp, p.DataInicio as DataInicioLkp,
	p.DataTermino as DataTerminoLkp, p.Orcamento as OrcamentoLkp
from dados.Projeto p 

update dados.Projeto set
	Nome = p.Nome,
	Identificador = p.Identificador,
	DataInicio = p.DataInicio,
	DataTermino = p.DataTermino,
	Orcamento = p.Orcamento
from dados.Projeto p
inner join temp.StageProjeto stp on stp.ID = p.IDOrigem;

select * from dados.Despesa

select distinct
	d.DepartamentoKey
from dados.Despesa d


select
	d.DepartamentoKey, d.IDOrigem
from dados.Departamento as d;

truncate table dados.despesa;

select distinct
	
	 d.ProjetoKey
 
from dados.Despesa d


select
	p.ProjetoKey, p.IDOrigem 
from dados.Projeto as p;

select distinct
 d.DepartamentoKey
from dados.Despesa d
where d.NomeOrigem = 'Funcionario'

select * from dados.Projeto
