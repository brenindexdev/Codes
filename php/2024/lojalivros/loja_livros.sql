-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19-Ago-2024 às 21:10
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
-- Banco de dados: `loja_livros`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `autores`
--

CREATE TABLE `autores` (
  `autor_id` int(11) NOT NULL,
  `nome` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `nacionalidade` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categorias`
--

CREATE TABLE `categorias` (
  `categoria_id` int(11) NOT NULL,
  `nome` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `data_inclusao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` int(11) NOT NULL,
  `nome` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `sobrenome` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `senha` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `endereço` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `telefone` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `cpf` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `data_inclusao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_do_pedido`
--

CREATE TABLE `itens_do_pedido` (
  `item_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preço_unitario` float NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `livro_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros`
--

CREATE TABLE `livros` (
  `livro_id` int(11) NOT NULL,
  `título` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `autor` char(80) COLLATE utf8_unicode_ci NOT NULL,
  `sobre_autor` text COLLATE utf8_unicode_ci NOT NULL,
  `editora` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `sinopse` text COLLATE utf8_unicode_ci NOT NULL,
  `ano_publicacao` date NOT NULL,
  `preço` decimal(18,2) NOT NULL,
  `estoque` int(11) NOT NULL,
  `data_inclusao` datetime NOT NULL,
  `data_alteracao` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros_autores`
--

CREATE TABLE `livros_autores` (
  `livro_id` int(11) NOT NULL,
  `autor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros_categorias`
--

CREATE TABLE `livros_categorias` (
  `livro_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `pedido_id` int(11) NOT NULL,
  `data_pedido` date NOT NULL,
  `total` decimal(18,2) NOT NULL,
  `forma_pag` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `pix` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `chave_pix` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `cartao` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `num_cartao` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `nome_cartao` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `venc_cartao` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `cod_cartao` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `cliente_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `autores`
--
ALTER TABLE `autores`
  ADD PRIMARY KEY (`autor_id`);

--
-- Índices para tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`);

--
-- Índices para tabela `itens_do_pedido`
--
ALTER TABLE `itens_do_pedido`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `livro_id` (`livro_id`);

--
-- Índices para tabela `livros`
--
ALTER TABLE `livros`
  ADD PRIMARY KEY (`livro_id`);

--
-- Índices para tabela `livros_autores`
--
ALTER TABLE `livros_autores`
  ADD PRIMARY KEY (`livro_id`,`autor_id`),
  ADD KEY `autor_id` (`autor_id`);

--
-- Índices para tabela `livros_categorias`
--
ALTER TABLE `livros_categorias`
  ADD PRIMARY KEY (`livro_id`,`categoria_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Índices para tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`pedido_id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `autores`
--
ALTER TABLE `autores`
  MODIFY `autor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `categoria_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itens_do_pedido`
--
ALTER TABLE `itens_do_pedido`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `livros`
--
ALTER TABLE `livros`
  MODIFY `livro_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `pedido_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `itens_do_pedido`
--
ALTER TABLE `itens_do_pedido`
  ADD CONSTRAINT `itens_do_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`),
  ADD CONSTRAINT `itens_do_pedido_ibfk_2` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`livro_id`);

--
-- Limitadores para a tabela `livros_autores`
--
ALTER TABLE `livros_autores`
  ADD CONSTRAINT `livros_autores_ibfk_1` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`livro_id`),
  ADD CONSTRAINT `livros_autores_ibfk_2` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`autor_id`);

--
-- Limitadores para a tabela `livros_categorias`
--
ALTER TABLE `livros_categorias`
  ADD CONSTRAINT `livros_categorias_ibfk_1` FOREIGN KEY (`livro_id`) REFERENCES `livros` (`livro_id`),
  ADD CONSTRAINT `livros_categorias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`categoria_id`);

--
-- Limitadores para a tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
