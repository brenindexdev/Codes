-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 24-Jun-2024 às 20:41
-- Versão do servidor: 10.4.6-MariaDB
-- versão do PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `web`
--
CREATE DATABASE IF NOT EXISTS `web` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `web`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `data_inclusao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `titulo`, `data_inclusao`, `data_alteracao`) VALUES
(1, 'Ã”nibus', '2024-04-01 15:32:55', '2024-06-24 12:47:18');

-- --------------------------------------------------------

--
-- Estrutura da tabela `estado`
--

CREATE TABLE `estado` (
  `sigla` char(2) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `data_inclusao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL,
  `endereco` varchar(60) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `fornecedor`
--

INSERT INTO `fornecedor` (`id`, `nome`, `data_inclusao`, `data_alteracao`, `endereco`, `cidade`, `bairro`, `estado`, `cep`) VALUES
(1, 'Luis AndrÃ© AlteraÃ§Ã£o', '2024-06-24 14:18:57', '2024-06-24 15:15:29', 'Teste de EndereÃ§o', 'Cidade', 'Cidade', '', '1212121212');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sobrenome` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `senha` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data_inclusao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`id`, `nome`, `sobrenome`, `email`, `senha`, `data_inclusao`, `data_alteracao`) VALUES
(1, 'Luis AndrÃ© alteraÃ§Ã£o', 'Claudiano', 'laclaudi@teste.com.br', 'c3cc5d169465cc9cce9518ee774ba63c19f2ce7f', '2024-03-25 13:26:59', '2024-03-25 15:28:06'),
(3, 'Luis AndrÃ© alteraÃ§Ã£o', 'Claudi', 'laclaudi@teste.com.br', 'c3cc5d169465cc9cce9518ee774ba63c19f2ce7f', '2024-03-25 15:49:24', '0000-00-00 00:00:00'),
(4, 'AndrÃ©', 'Teste', 'email@teste.com.br', 'c3cc5d169465cc9cce9518ee774ba63c19f2ce7f', '2024-04-01 14:54:45', '0000-00-00 00:00:00');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`sigla`);

--
-- Índices para tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
