USE [master];
GO

CREATE DATABASE [TI]
    COLLATE SQL_Latin1_General_CP1_CI_AI
GO

USE [TI];
GO

PRINT N'Creating [dbo].[Departamento]...';


GO
CREATE TABLE [dbo].[Departamento] (
    [ID]              INT             NOT NULL,
    [Nome]            VARCHAR (255)   NOT NULL,
    [Sigla]           VARCHAR (5)     NOT NULL,
    [OrcamentoMensal] DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UN_Departamento_Nome] UNIQUE NONCLUSTERED ([Nome] ASC),
    CONSTRAINT [UN_Departamento_Sigla] UNIQUE NONCLUSTERED ([Sigla] ASC)
);


GO
PRINT N'Creating [dbo].[DespesaDepartamento]...';


GO
CREATE TABLE [dbo].[DespesaDepartamento] (
    [ID]             INT             NOT NULL,
    [Data]           DATE            NOT NULL,
    [DepartamentoID] INT             NOT NULL,
    [Descricao]      VARCHAR (255)   NOT NULL,
    [Valor]          DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_DespesaDepartamento] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[DespesaFuncionario]...';


GO
CREATE TABLE [dbo].[DespesaFuncionario] (
    [ID]            INT             NOT NULL,
    [Data]          DATE            NOT NULL,
    [FuncionarioID] INT             NOT NULL,
    [Descricao]     VARCHAR (255)   NOT NULL,
    [Valor]         DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_DespesaFuncionario] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[DespesaProjeto]...';


GO
CREATE TABLE [dbo].[DespesaProjeto] (
    [ID]        INT             NOT NULL,
    [Data]      DATE            NOT NULL,
    [ProjetoID] INT             NOT NULL,
    [Descricao] VARCHAR (255)   NOT NULL,
    [Valor]     DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_DespesaProjeto] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[Funcionario]...';


GO
CREATE TABLE [dbo].[Funcionario] (
    [ID]             INT           NOT NULL,
    [Nome]           VARCHAR (255) NOT NULL,
    [DepartamentoID] INT           NOT NULL,
    [Cargo]          VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Funcionario] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[Projeto]...';


GO
CREATE TABLE [dbo].[Projeto] (
    [ID]            INT             NOT NULL,
    [Nome]          VARCHAR (255)   NOT NULL,
    [Identificador] VARCHAR (50)    NOT NULL,
    [DataInicio]    DATE            NOT NULL,
    [DataTermino]   DATE            NOT NULL,
    [Orcamento]     DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_Projeto] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UN_Projeto_Identificador] UNIQUE NONCLUSTERED ([Identificador] ASC),
    CONSTRAINT [UN_Projeto_Nome] UNIQUE NONCLUSTERED ([Nome] ASC)
);


GO
PRINT N'Creating [dbo].[FK_DespesaDepartamento_Departamento]...';


GO
ALTER TABLE [dbo].[DespesaDepartamento]
    ADD CONSTRAINT [FK_DespesaDepartamento_Departamento] FOREIGN KEY ([DepartamentoID]) REFERENCES [dbo].[Departamento] ([ID]);


GO
PRINT N'Creating [dbo].[FK_DespesaFuncionario_Funcionario]...';


GO
ALTER TABLE [dbo].[DespesaFuncionario]
    ADD CONSTRAINT [FK_DespesaFuncionario_Funcionario] FOREIGN KEY ([FuncionarioID]) REFERENCES [dbo].[Funcionario] ([ID]);


GO
PRINT N'Creating [dbo].[FK_DespesaProjeto_Projeto]...';


GO
ALTER TABLE [dbo].[DespesaProjeto]
    ADD CONSTRAINT [FK_DespesaProjeto_Projeto] FOREIGN KEY ([ProjetoID]) REFERENCES [dbo].[Projeto] ([ID]);


GO
PRINT N'Creating [dbo].[FK_Funcionario_Departamento]...';


GO
ALTER TABLE [dbo].[Funcionario]
    ADD CONSTRAINT [FK_Funcionario_Departamento] FOREIGN KEY ([DepartamentoID]) REFERENCES [dbo].[Departamento] ([ID]);


GO

declare @Contador int = null;
declare @Data date = null;
declare @DataInicial date = dateadd(m, -5, sysdatetime())
declare @DataFinal date =  eomonth(sysdatetime());

set @DataInicial = dateadd(dd, -day(@DataInicial) + 1, @DataInicial);

if not exists(select top 1 ID from Projeto)
begin
	insert into Projeto
	(ID, DataInicio, DataTermino, Orcamento, Nome, Identificador)
	values
	(1, @DataInicial,  @DataFinal, 50000, 'Desenvolvimento de sistema de gestão de vendas', 'GESTVEND'),
	(2, @DataInicial,  @DataFinal, 30000, 'Implantação de sistema de help desk', 'HELPDESK'),
	(3, @DataInicial,  @DataFinal, 10000, 'Sistema de monitomanento e inventário de hardware', 'INVENTHARD');
end;

if not exists(select top 1 ID from Departamento)
begin
	insert into Departamento
	(ID, Nome, Sigla, OrcamentoMensal)
	values
	(1, 'Administração', 'ADM', 10000),
	(2, 'Desenvolvimento', 'DEV', 12000),
	(3, 'Infra-estrutura', 'INFRA', 12000),
	(4, 'Suporte', 'SUP', 7000);
end;

if not exists(select top 1 ID from Funcionario)
begin
	insert into Funcionario
	(ID, DepartamentoID, Nome, Cargo)
	values
	(1, 1, 'Antonio Alves', 'Gerente'),
	(2, 2, 'Bruna Barbosa', 'Analista de Sistemas'),
	(3, 2, 'Carlos Cardoso', 'Analista de Sistemas'),
	(4, 3, 'Daniela Dantas', 'Analista de Redes'),
	(5, 3, 'Eduardo Emílio', 'Administrador de Sistemas'),
	(6, 4, 'Fernanda Ferrari', 'Analista de Suporte');
end;

if not exists(select top 1 ID from DespesaDepartamento)
begin
	set @Contador = 0;
	set @Data = @DataInicial;

	while (@Contador < 4)
	begin
		insert into DespesaDepartamento
		(ID,                 Data, DepartamentoID, Valor,               Descricao)
		values
		(@Contador * 7 +  1, @Data,             1, 5000 + month(@Data), 'Contratação de serviços de terceiros'),
		(@Contador * 7 +  2, @Data,             2, 2000 + month(@Data), 'Treinamento'),
		(@Contador * 7 +  3, @Data,             2, 5000 + month(@Data), 'Participação em eventos'),
		(@Contador * 7 +  4, @Data,             3, 5000 + month(@Data), 'Treinamento'),
		(@Contador * 7 +  5, @Data,             3, 5000 + month(@Data), 'Participação em eventos'),
		(@Contador * 7 +  6, @Data,             4, 5000 + month(@Data), 'Treinamento'),
		(@Contador * 7 +  7, @Data,             4, 5000 + month(@Data), 'Participação em eventos');
		
		set @Data = dateadd(m, 1, @Data);
		set @Contador += 1;
	end;
end;

if not exists(select top 1 ID from DespesaFuncionario)
begin
	set @Contador = 0;
	set @Data = @DataInicial;

	while (@Data <= @DataFinal)
	begin
		insert into DespesaFuncionario
		(ID,                 Data,  FuncionarioID,               Valor,  Descricao)
		values						 
		(@Contador * 6 + 1, @Data,             1, 8000 + month(@Data), 'Salário'),
		(@Contador * 6 + 2, @Data,             2, 5000 + month(@Data), 'Salário'),
		(@Contador * 6 + 3, @Data,             3, 5000 + month(@Data), 'Salário'),
		(@Contador * 6 + 4, @Data,             4, 5000 + month(@Data), 'Salário'),
		(@Contador * 6 + 5, @Data,             5, 5000 + month(@Data), 'Salário'),
		(@Contador * 6 + 6, @Data,             6, 3500 + month(@Data), 'Salário');
		
		set @Data = dateadd(m, 1, @Data);
		set @Contador += 1;
	end;
end;

if not exists(select top 1 ID from DespesaProjeto)
begin
	set @Contador = 0;
	set @Data = @DataInicial;

	insert into DespesaProjeto
	(ID,         Data, ProjetoID,   Valor,  Descricao)
	values
	(@Contador, @Data,         1,   15000, 'Aquisição de equipamentos');

	while (@Data <= @DataFinal)
	begin
		insert into DespesaProjeto
		(ID,                   Data, ProjetoID,                Valor,  Descricao)
		values
		(@Contador * 3 +  1, @Data,        1,   2000 + month(@Data), 'Serviços de hospedagem'),
		(@Contador * 3 +  2, @Data,        2,   5000 + month(@Data), 'Serviços de hospedagem'),
		(@Contador * 3 +  3, @Data,        3,   2000 + month(@Data), 'Parcela de aquisição de software');
		
		set @Data = dateadd(m, 1, @Data);
		set @Contador += 1;
	end;
end;
GO

-------------------------------------------------------------------------------------

GO
USE [master];
GO

CREATE DATABASE [TIDW]
    COLLATE SQL_Latin1_General_CP1_CI_AI
GO

USE [TIDW];
GO

PRINT N'Creating [dados]...';


GO
CREATE SCHEMA [dados]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [dados].[Projeto]...';


GO
CREATE TABLE [dados].[Projeto] (
    [ProjetoKey]    INT             IDENTITY (1, 1) NOT NULL,
    [IDOrigem]      INT             NOT NULL,
    [Nome]          VARCHAR (255)   NULL,
    [Identificador] VARCHAR (50)    NULL,
    [DataInicio]    DATE            NULL,
    [DataTermino]   DATE            NULL,
    [Orcamento]     DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_Projeto] PRIMARY KEY CLUSTERED ([ProjetoKey] ASC)
);


GO
PRINT N'Creating [dados].[Departamento]...';


GO
CREATE TABLE [dados].[Departamento] (
    [DepartamentoKey] INT             IDENTITY (1, 1) NOT NULL,
    [IDOrigem]        INT             NOT NULL,
    [Nome]            VARCHAR (255)   NULL,
    [Sigla]           VARCHAR (5)     NULL,
    [OrcamentoMensal] DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED ([DepartamentoKey] ASC)
);


GO
PRINT N'Creating [dados].[Tempo]...';


GO
CREATE TABLE [dados].[Tempo] (
    [TempoKey] DATE NOT NULL,
    [Ano]      AS   year(TempoKey) PERSISTED,
    [Mes]      AS   month(TempoKey) PERSISTED,
    [Dia]      AS   day(TempoKey) PERSISTED,
    [AnoMes]   AS   CAST (CAST (year(TempoKey) AS CHAR (4)) + RIGHT(CAST (100 + month(TempoKey) AS CHAR (3)), 2) AS INT) PERSISTED,
    CONSTRAINT [PK_Tempo] PRIMARY KEY CLUSTERED ([TempoKey] ASC)
);


GO
PRINT N'Creating [dados].[Despesa]...';


GO
CREATE TABLE [dados].[Despesa] (
    [DespesaKey]      INT             IDENTITY (1, 1) NOT NULL,
    [Data]            DATE            NOT NULL,
    [IDOrigem]        INT             NOT NULL,
    [NomeOrigem]      VARCHAR (100)   NOT NULL,
    [Valor]           DECIMAL (14, 2) NOT NULL,
    [Descricao]       VARCHAR (255)   NULL,
    [DepartamentoKey] INT             NULL,
    [ProjetoKey]      INT             NULL,
    CONSTRAINT [PK_Despesa] PRIMARY KEY CLUSTERED ([DespesaKey] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dados].[Projeto]...';


GO
ALTER TABLE [dados].[Projeto]
    ADD DEFAULT 0 FOR [Orcamento];


GO
PRINT N'Creating unnamed constraint on [dados].[Departamento]...';


GO
ALTER TABLE [dados].[Departamento]
    ADD DEFAULT 0 FOR [OrcamentoMensal];


GO
PRINT N'Creating [dados].[FK_Despesa_Departamento]...';


GO
ALTER TABLE [dados].[Despesa]
    ADD CONSTRAINT [FK_Despesa_Departamento] FOREIGN KEY ([DepartamentoKey]) REFERENCES [dados].[Departamento] ([DepartamentoKey]);


GO
PRINT N'Creating [dados].[FK_Despesa_Projeto]...';


GO
ALTER TABLE [dados].[Despesa]
    ADD CONSTRAINT [FK_Despesa_Projeto] FOREIGN KEY ([ProjetoKey]) REFERENCES [dados].[Projeto] ([ProjetoKey]);


GO
PRINT N'Creating [dados].[FK_Despesa_Tempo]...';


GO
ALTER TABLE [dados].[Despesa]
    ADD CONSTRAINT [FK_Despesa_Tempo] FOREIGN KEY ([Data]) REFERENCES [dados].[Tempo] ([TempoKey]);


GO
PRINT N'Creating [dados].[CK_Despesa_NomeOrigem]...';


GO
ALTER TABLE [dados].[Despesa]
    ADD CONSTRAINT [CK_Despesa_NomeOrigem] CHECK (NomeOrigem in ('Departamento', 'Funcionario', 'Projeto'));


GO

with Datas (Data)
as
(
	select Data
	from TI..DespesaDepartamento
	union
	select Data
	from TI..DespesaFuncionario
	union
	select Data
	from TI..DespesaProjeto
)

insert into dados.Tempo
(TempoKey)
select distinct Data
from Datas;
GO


---Criação da tempo
GO
CREATE SCHEMA [temp]
    AUTHORIZATION [dbo];


-- Criação Stages
GO
CREATE TABLE [temp].[StageDepartamento] (
    [ID]              INT             NOT NULL,
    [Nome]            VARCHAR (255)   NOT NULL,
    [Sigla]           VARCHAR (5)     NOT NULL,
    [OrcamentoMensal] DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_Departamento] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UN_Departamento_Nome] UNIQUE NONCLUSTERED ([Nome] ASC),
    CONSTRAINT [UN_Departamento_Sigla] UNIQUE NONCLUSTERED ([Sigla] ASC)
);

GO
CREATE TABLE [temp].[StageProjeto] (
    [ID]            INT             NOT NULL,
    [Nome]          VARCHAR (255)   NOT NULL,
    [Identificador] VARCHAR (50)    NOT NULL,
    [DataInicio]    DATE            NOT NULL,
    [DataTermino]   DATE            NOT NULL,
    [Orcamento]     DECIMAL (14, 2) NOT NULL,
    CONSTRAINT [PK_Projeto] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UN_Projeto_Identificador] UNIQUE NONCLUSTERED ([Identificador] ASC),
    CONSTRAINT [UN_Projeto_Nome] UNIQUE NONCLUSTERED ([Nome] ASC)
);