delete  from dados.Projeto

select * from dados.Departamento

select 
	dp.ID, dp.ProjetoID,
	dp.Descricao, dp.Valor, dp.Data,
                  'Projeto' as NomeOrigem
from DespesaProjeto dp

select * from dados.despesa

select * from dados.Departamento

select * from dados.Projeto

select 
 d.DespesaKey, d.Data, d.Descricao, d.Valor, dp.Sigla, p.Identificador, dp.Nome,
 p.Nome
from dados.Despesa d
full outer join dados.Departamento dp on dp.DepartamentoKey = d.DepartamentoKey
full outer join dados.Projeto p on p.ProjetoKey = d.ProjetoKey

select 
 d.DespesaKey, d.Data, d.Descricao, d.Valor, dp.Sigla, p.Identificador
from dados.Despesa d, dados.Departamento dp, dados.Projeto p
where dp.DepartamentoKey = d.DepartamentoKey or p.ProjetoKey = d.ProjetoKey

select * from dados.Despesa