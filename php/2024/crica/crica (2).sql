-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12/12/2024 às 00:50
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `crica`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alunos`
--

CREATE TABLE `alunos` (
  `prontuario_alu` varchar(9) NOT NULL,
  `nome_alu` varchar(45) NOT NULL,
  `nascimento_alu` datetime DEFAULT NULL,
  `cpf_alu` varchar(14) DEFAULT NULL,
  `fone_alu` varchar(14) DEFAULT NULL,
  `email_alu` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `boletim`
--

CREATE TABLE `boletim` (
  `prontuario_alu` varchar(9) NOT NULL,
  `codigo_dis` varchar(6) NOT NULL,
  `ano_bol` int(11) DEFAULT NULL,
  `nota1_bol` float DEFAULT NULL,
  `nota2_bol` float DEFAULT NULL,
  `media_bol` float DEFAULT NULL,
  `faltas_bol` int(11) DEFAULT NULL,
  `situacao_bol` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cursos`
--

CREATE TABLE `cursos` (
  `codigo_curso` int(11) NOT NULL,
  `nome_curso` varchar(45) NOT NULL,
  `ch_curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `disciplinas`
--

CREATE TABLE `disciplinas` (
  `codigo_dis` varchar(6) NOT NULL,
  `nome_dis` varchar(45) NOT NULL,
  `curso_dis` varchar(45) DEFAULT NULL,
  `serie_dis` int(11) DEFAULT NULL,
  `ch_dis` int(11) DEFAULT NULL,
  `Cursos_codigo_curso` int(11) NOT NULL,
  `ano_dis` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `grade_horaria`
--

CREATE TABLE `grade_horaria` (
  `codigo_dis` varchar(6) NOT NULL,
  `codigo_hora` int(11) NOT NULL,
  `ano_grade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `horarios`
--

CREATE TABLE `horarios` (
  `codigo_hora` int(11) NOT NULL,
  `inicio_hora` datetime DEFAULT NULL,
  `fim_hora` datetime DEFAULT NULL,
  `periodo_hora` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `mapa_salas`
--

CREATE TABLE `mapa_salas` (
  `codigo_sala` varchar(3) NOT NULL,
  `codigo_dis` varchar(6) NOT NULL,
  `ano_mapa` int(11) DEFAULT NULL,
  `dia_mapa` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `professores`
--

CREATE TABLE `professores` (
  `codigo_prof` int(11) NOT NULL,
  `nome_prof` varchar(45) NOT NULL,
  `nascimento_prof` datetime DEFAULT NULL,
  `cpf_prof` varchar(14) DEFAULT NULL,
  `fone_prof` varchar(14) DEFAULT NULL,
  `email_prof` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `salas`
--

CREATE TABLE `salas` (
  `codigo_sala` varchar(3) NOT NULL,
  `nome_sala` varchar(45) NOT NULL,
  `capacidade_sala` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `turmas`
--

CREATE TABLE `turmas` (
  `codigo_dis` varchar(6) NOT NULL,
  `codigo_prof` int(11) NOT NULL,
  `ano_tur` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `verdadeiro`
--

CREATE TABLE `verdadeiro` (
  `nome` varchar(10) NOT NULL,
  `mapa` varchar(6) NOT NULL,
  `professores` text NOT NULL,
  `disciplinas` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `verdadeiro`
--

INSERT INTO `verdadeiro` (`nome`, `mapa`, `professores`, `disciplinas`) VALUES
('B10', '40', 'Andre', 'Geografia'),
('B29', '20', 'Moacir', 'Administracao e Empreendedorismo'),
('B20', '40', 'Vanessa', 'Português'),
('B10', '38', 'Adalberto', 'História'),
('B09', '40', 'Lilian', 'Análise de Software');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`prontuario_alu`);

--
-- Índices de tabela `boletim`
--
ALTER TABLE `boletim`
  ADD PRIMARY KEY (`prontuario_alu`,`codigo_dis`),
  ADD KEY `fk_Alunos_has_Disciplinas_Disciplinas1` (`codigo_dis`);

--
-- Índices de tabela `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`codigo_curso`);

--
-- Índices de tabela `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD PRIMARY KEY (`codigo_dis`),
  ADD KEY `fk_disciplinas_Cursos1` (`Cursos_codigo_curso`);

--
-- Índices de tabela `grade_horaria`
--
ALTER TABLE `grade_horaria`
  ADD PRIMARY KEY (`codigo_dis`,`codigo_hora`),
  ADD KEY `fk_disciplinas_has_Horarios_Horarios1` (`codigo_hora`);

--
-- Índices de tabela `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`codigo_hora`);

--
-- Índices de tabela `mapa_salas`
--
ALTER TABLE `mapa_salas`
  ADD PRIMARY KEY (`codigo_sala`,`codigo_dis`),
  ADD KEY `fk_Salas_has_disciplinas_disciplinas1` (`codigo_dis`);

--
-- Índices de tabela `professores`
--
ALTER TABLE `professores`
  ADD PRIMARY KEY (`codigo_prof`);

--
-- Índices de tabela `salas`
--
ALTER TABLE `salas`
  ADD PRIMARY KEY (`codigo_sala`);

--
-- Índices de tabela `turmas`
--
ALTER TABLE `turmas`
  ADD PRIMARY KEY (`codigo_dis`,`codigo_prof`),
  ADD KEY `fk_Disciplinas_has_Professores_Professores1` (`codigo_prof`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cursos`
--
ALTER TABLE `cursos`
  MODIFY `codigo_curso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `professores`
--
ALTER TABLE `professores`
  MODIFY `codigo_prof` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `boletim`
--
ALTER TABLE `boletim`
  ADD CONSTRAINT `fk_Alunos_has_Disciplinas_Alunos` FOREIGN KEY (`prontuario_alu`) REFERENCES `alunos` (`prontuario_alu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Alunos_has_Disciplinas_Disciplinas1` FOREIGN KEY (`codigo_dis`) REFERENCES `disciplinas` (`codigo_dis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `disciplinas`
--
ALTER TABLE `disciplinas`
  ADD CONSTRAINT `fk_disciplinas_Cursos1` FOREIGN KEY (`Cursos_codigo_curso`) REFERENCES `cursos` (`codigo_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `grade_horaria`
--
ALTER TABLE `grade_horaria`
  ADD CONSTRAINT `fk_disciplinas_has_Horarios_Horarios1` FOREIGN KEY (`codigo_hora`) REFERENCES `horarios` (`codigo_hora`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_disciplinas_has_Horarios_disciplinas1` FOREIGN KEY (`codigo_dis`) REFERENCES `disciplinas` (`codigo_dis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `mapa_salas`
--
ALTER TABLE `mapa_salas`
  ADD CONSTRAINT `fk_Salas_has_disciplinas_Salas1` FOREIGN KEY (`codigo_sala`) REFERENCES `salas` (`codigo_sala`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Salas_has_disciplinas_disciplinas1` FOREIGN KEY (`codigo_dis`) REFERENCES `disciplinas` (`codigo_dis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `turmas`
--
ALTER TABLE `turmas`
  ADD CONSTRAINT `fk_Disciplinas_has_Professores_Disciplinas1` FOREIGN KEY (`codigo_dis`) REFERENCES `disciplinas` (`codigo_dis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Disciplinas_has_Professores_Professores1` FOREIGN KEY (`codigo_prof`) REFERENCES `professores` (`codigo_prof`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
