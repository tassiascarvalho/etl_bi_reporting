select 
	df.ID, df.Data,
	df.FuncionarioID, df.Descricao, 
	df.Valor, 'Funcionário' as NomeOrigem
from DespesaFuncionario df

select 
	dp.ID, dp.ProjetoID,
	dp.Descricao, dp.Valor
from DespesaProjeto dp


select 
	df.ID, df.Data,
	df.FuncionarioID, df.Descricao, f.DepartamentoID as IDDepartamento,
	df.Valor, 'Funcionario' as NomeOrigem
from DespesaFuncionario df
inner join Funcionario f on f.ID = df.FuncionarioID

select Sum(Valor) from DespesaDepartamento
select Sum(Valor) from DespesaProjeto
select Sum(Valor) from DespesaFuncionario
select * from DespesaDepartamento
select * from DespesaProjeto
select * from DespesaFuncionario

select * from Projeto


