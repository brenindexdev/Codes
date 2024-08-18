CREATE TABLE `cadcli` (
  `id` int(11) NOT NULL,
  `nome` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `cpf` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `rg` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sexo` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `senha` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `end_nome` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `end_num` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `end_comp` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `cep` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `bairro` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `cidade` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `uf` varchar(2) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE categoria;

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `data_inc` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`id`, `descricao`, `status`, `data_inc`) VALUES
(1, 'Ônibus', '', '0000-00-00 00:00:00'),
(2, 'Automóveis', '', '0000-00-00 00:00:00'),
(3, 'Máquinas Pesadas', '', '0000-00-00 00:00:00'),
(4, 'Caminhões', '', '0000-00-00 00:00:00'),
(5, 'Motocicletas', '', '0000-00-00 00:00:00'),
(6, 'Aviões', '', '0000-00-00 00:00:00'),
(7, 'Militares', '', '0000-00-00 00:00:00');


CREATE TABLE `itens` (
  `id` int(11) NOT NULL,
  `num_ped` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `nome` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `qt` int(11) NOT NULL,
  `preco` decimal(18,2) NOT NULL,
  `preco_boleto` decimal(18,2) NOT NULL,
  `peso` decimal(9,3) NOT NULL,
  `desconto` int(11) NOT NULL,
  `desconto_boleto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `miniaturas` (
  `id` int(11) NOT NULL,
  `codigo` varchar(5) DEFAULT '',
  `destaque` char(1) DEFAULT 'S',
  `nome` varchar(60) DEFAULT '',
  `ano` varchar(4) DEFAULT '',
  `id_categoria` int(11) DEFAULT 0,
  `subcateg` varchar(30) DEFAULT '',
  `escala` varchar(10) DEFAULT '1:18',
  `peso` float(9,1) DEFAULT 0.0,
  `comprimento` float(9,1) DEFAULT 0.0,
  `largura` float(9,1) DEFAULT 0.0,
  `altura` float(9,1) DEFAULT 0.0,
  `cor` varchar(20) NOT NULL DEFAULT '',
  `preco` float(9,2) DEFAULT 0.00,
  `desconto` tinyint(4) DEFAULT 5,
  `desconto_boleto` tinyint(4) DEFAULT 10,
  `max_parcelas` tinyint(4) DEFAULT 10,
  `estoque` int(11) DEFAULT 100,
  `min_estoque` int(11) DEFAULT 10,
  `credito` varchar(200) DEFAULT 'http://www.motormint.com (acesso 21/09/2009)',
  `data_cad` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `miniaturas` (`id`, `codigo`, `destaque`, `nome`, `ano`, `id_categoria`, `subcateg`, `escala`, `peso`, `comprimento`, `largura`, `altura`, `cor`, `preco`, `desconto`, `desconto_boleto`, `max_parcelas`, `estoque`, `min_estoque`, `credito`, `data_cad`) VALUES
(1, '10510', 'N', 'Marcopolo Paradiso 1200', '2009', 1, 'Ônibus rodoviário', '1:36', 1.0, 20.2, 7.9, 11.3, 'Branco', 100.00, 5, 5, 3, 210, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(2, '10511', 'N', 'Marcopolo Paradiso 1550 LD', '2009', 1, 'Ônibus rodoviário', '1:36', 0.9, 20.2, 8.7, 11.3, 'Azul', 78.30, 5, 10, 2, 2, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(3, '10512', 'N', 'Marcopolo Viaggio 1050 MD', '2009', 1, 'Ônibus rodoviário', '1:36', 0.9, 20.2, 8.7, 11.3, 'Azul', 120.30, 5, 10, 5, 140, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(4, '10513', 'N', 'Marcopolo Viaggio 1050 MT', '2009', 1, 'Ônibus rodoviário', '1:36', 1.2, 20.2, 8.3, 11.3, 'Amarelo', 140.70, 5, 10, 7, 85, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(5, '10514', 'S', 'Marcopolo Paradiso 1800 DD', '2009', 1, 'Ônibus rodoviário', '1:36', 1.0, 20.2, 8.1, 13.1, 'Prata/verde', 155.25, 5, 10, 10, 105, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(6, '11510', 'N', 'Marcopolo Senior Midi', '2009', 1, 'Ônibus urbano', '1:36', 1.1, 20.2, 7.8, 11.3, 'Branco', 175.00, 5, 10, 10, 2, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(7, '11511', 'N', 'Marcopolo Torino', '2009', 1, 'Ônibus urbano', '1:36', 1.2, 20.2, 7.5, 11.3, 'Branco', 115.00, 5, 10, 10, 140, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(8, '11512', 'N', 'Marcopolo Viale', '2009', 1, 'Ônibus urbano', '1:36', 1.0, 20.2, 8.3, 11.3, 'Branco', 170.30, 5, 10, 10, 18, 10, 'http://www.marcopolo.com.br (acesso 21/09/2009)', '2009-05-27'),
(9, '12510', 'N', 'BRIT L004 Leyland Titan PD2 deck bus', '1962', 1, 'Ônibus dois andares', '1:36', 0.9, 10.8, 4.2, 2.5, 'Verde/branco', 120.50, 5, 10, 10, 45, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(10, '12511', 'N', 'RM2217 - The Last Routemaster', '1952', 1, 'Ônibus dois andares', '1:36', 0.9, 11.5, 4.3, 2.5, 'Vermelho', 201.00, 5, 10, 10, 32, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(11, '12512', 'N', 'RCL Routmaster Coach Greenline', '1952', 1, 'Ônibus dois andares', '1:36', 1.0, 10.7, 3.8, 2.5, 'Verde', 175.00, 5, 10, 10, 25, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(12, '12513', 'N', 'East Lancs Myllenium', '2000', 1, 'Ônibus dois andares', '1:36', 1.0, 11.5, 3.9, 2.5, 'Vermelho', 167.00, 5, 10, 10, 130, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(13, '12514', 'N', 'Crossley DD42 Portsmouth Eastney/Cosham', '1960', 1, 'Ônibus dois andares', '1:36', 1.1, 11.0, 4.2, 2.5, 'Vermelho/branco', 132.00, 5, 10, 10, 157, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(14, '12515', 'N', 'Queen Mary - British Shoe Corporation', '1936', 1, 'Ônibus dois andares', '1:36', 1.3, 11.7, 5.0, 2.5, 'Azul', 225.00, 5, 10, 10, 1, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(15, '12516', 'N', 'Bedford Val - West Riding', '1975', 1, 'Ônibus rodoviário', '1:36', 1.0, 10.5, 4.8, 2.5, 'Branco/verde', 248.00, 5, 10, 10, 15, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(16, '12517', 'N', 'Bimingham/Worcester Split run, 2 of each dest', '1967', 1, 'Ônibus urbano', '1:36', 1.2, 11.5, 4.7, 2.5, 'Vermelho/preto', 156.60, 5, 10, 10, 147, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-05-27'),
(17, '12518', 'N', 'Scania Irizar PB - Bus Eireann', '2007', 1, 'Ônibus rodoviário', '1:36', 1.1, 11.5, 4.3, 2.5, 'Branco/vermelho', 205.00, 5, 10, 10, 18, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-06-10'),
(18, '12519', 'N', 'Bussing 6500 T - Sauerland', '1967', 1, 'Ônibus rodoviário', '1:36', 1.0, 11.5, 4.9, 2.5, 'Azul/creme', 148.00, 5, 10, 10, 9, 10, 'http://krwmodels.co.uk (acesso 21/09/2009)', '2009-06-10'),
(19, '20301', 'N', 'Volvo S40', '2009', 2, 'Linha Volvo', '1:18', 0.4, 11.5, 5.1, 2.5, 'Vermelho', 95.00, 5, 10, 5, 35, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(20, '20302', 'N', 'Volvo S80', '2009', 2, 'Linha Volvo', '1:18', 0.5, 11.5, 5.3, 2.5, 'Preto', 78.00, 5, 10, 3, 48, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(21, '20303', 'N', 'Volvo V50', '2009', 2, 'Linha Volvo', '1:18', 0.7, 11.5, 4.2, 2.5, 'Azul', 95.50, 5, 10, 6, 23, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(22, '20304', 'N', 'Volvo V70', '2009', 2, 'Linha Volvo', '1:18', 0.6, 11.5, 4.2, 2.5, 'Cinza', 89.50, 5, 10, 2, 120, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(23, '20305', 'N', 'Volvo XC70', '2009', 2, 'Linha Volvo', '1:18', 0.5, 11.5, 4.2, 2.5, 'Verde', 95.00, 5, 10, 3, 237, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(24, '20306', 'N', 'Volvo XC90', '2009', 2, 'Linha Volvo', '1:18', 0.8, 11.5, 4.8, 2.5, 'Prata', 95.00, 5, 10, 3, 8, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(25, '20307', 'N', 'Volvo C30', '2009', 2, 'Linha Volvo', '1:18', 0.4, 11.5, 4.1, 2.5, 'Vermelho', 95.00, 5, 10, 3, 4, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(26, '20308', 'S', 'Volvo C70', '2009', 2, 'Linha Volvo', '1:18', 0.4, 11.5, 4.0, 2.5, 'Prata', 95.00, 5, 10, 3, 13, 10, 'http://www.volvocars.com/us/models/s40/Pages (acesso 22/09/2009)', '2009-06-10'),
(27, '21301', 'N', 'Hummer H3', '2009', 2, 'Linha Hummer', '1:18', 0.5, 11.6, 5.0, 3.2, 'Preto', 290.00, 5, 10, 10, 27, 10, 'http://www.hummer.com (acesso 22/09/2009)', '2009-06-10'),
(28, '21302', 'N', 'Hummer H3T', '2009', 2, 'Linha Hummer', '1:18', 0.6, 10.8, 5.3, 3.2, 'Vermelho', 310.00, 5, 10, 10, 78, 10, 'http://www.hummer.com (acesso 22/09/2009)', '2009-06-10'),
(29, '21303', 'N', 'Hummer H3x', '2009', 2, 'Linha Hummer', '1:18', 0.6, 11.5, 4.8, 3.2, 'Cinza', 210.00, 5, 10, 10, 56, 10, 'http://www.hummer.com (acesso 22/09/2009)', '2009-06-10'),
(30, '21304', 'S', 'Hummer H3 Alpha', '2009', 2, 'Linha Hummer', '1:18', 0.6, 11.5, 4.2, 3.2, 'Azul', 238.00, 5, 10, 10, 54, 10, 'http://www.hummer.com (acesso 22/09/2009)', '2009-06-29'),
(31, '21305', 'N', 'Hummer H2', '2009', 2, 'Linha Hummer', '1:18', 0.5, 11.5, 4.3, 3.2, 'Vermelho', 185.00, 5, 10, 10, 83, 10, 'http://www.hummer.com (acesso 22/09/2009)', '2009-06-29'),
(32, '21306', 'N', 'Hummer H2 SUT', '2009', 2, 'Linha Hummer', '1:18', 0.6, 11.5, 4.8, 3.2, 'Cinza', 230.00, 5, 10, 10, 254, 10, 'http://www.hummer.com (acesso 22/09/2009)', '2009-06-29'),
(33, '22301', 'N', 'Chevrolet Malibu', '2009', 2, 'Linha Chevrolet', '1:18', 0.6, 11.5, 4.2, 3.2, 'Ouro', 157.00, 5, 10, 10, 1, 10, 'http://www.gm.com (acesso 22/09/2009)', '2009-06-29'),
(34, '22302', 'N', 'Chevrolet Traversi', '2009', 2, 'Linha Chevrolet', '1:18', 0.7, 11.5, 4.2, 3.2, 'Vinho', 195.00, 5, 10, 10, 0, 10, 'http://www.gm.com (acesso 22/09/2009)', '2009-06-29'),
(35, '22303', 'N', 'Chevrolet Camaro', '2009', 2, 'Linha Chevrolet', '1:18', 0.5, 11.5, 5.1, 2.0, 'Amarelo', 195.00, 5, 10, 10, 17, 10, 'http://www.gm.com (acesso 22/09/2009)', '2009-06-29'),
(36, '22304', 'N', 'Chevrolet Equinox', '2009', 2, 'Linha Chevrolet', '1:18', 0.5, 11.5, 5.3, 3.2, 'Vermelho', 230.00, 5, 10, 10, 168, 10, 'http://www.gm.com (acesso 22/09/2009)', '2009-06-29'),
(37, '22305', 'N', 'Chevrolet Tahoe Hybrid', '2009', 2, 'Linha Chevrolet', '1:18', 0.6, 11.5, 4.9, 3.2, 'Azul', 156.30, 5, 10, 10, 21, 10, 'http://www.gm.com (acesso 22/09/2009)', '2009-06-29'),
(38, '22306', 'S', 'Chevrolet Corvette ZR1', '2009', 2, 'Linha Chevrolet', '1:18', 0.7, 11.5, 4.8, 3.2, 'Amarelo', 89.00, 5, 10, 3, 75, 10, 'http://www.gm.com (acesso 22/09/2009)', '2009-06-29'),
(39, '30101', 'N', 'Retroescavadeira 416E', '2009', 3, 'Retroescavadeiras', '1:46', 1.0, 15.2, 4.2, 5.5, 'Amarelo', 85.00, 5, 10, 3, 14, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(40, '30102', 'N', 'Retroescavadeira 420E', '2009', 3, 'Retroescavadeiras', '1:46', 1.0, 14.8, 5.6, 5.5, 'Amarelo', 131.00, 5, 10, 10, 2, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(41, '30103', 'N', 'Retroescavadeira 450E', '2009', 3, 'Retroescavadeiras', '1:46', 1.0, 13.7, 5.7, 5.5, 'Amarelo', 156.00, 5, 10, 10, 45, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(42, '32101', 'N', 'Fresadora PM-101', '2009', 3, 'Fresadoras', '1:46', 1.0, 11.8, 5.0, 5.5, 'Amarelo', 157.00, 5, 10, 10, 15, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(43, '32102', 'N', 'Fresadora PM-201', '2009', 3, 'Fresadoras', '1:46', 1.1, 13.8, 5.3, 5.5, 'Amarelo', 98.00, 5, 10, 3, 32, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(44, '33101', 'N', 'Escavadeira Hidráulica 307D ', '2009', 3, 'Escavadeiras', '1:46', 1.1, 11.7, 4.2, 5.5, 'Amarelo', 75.00, 5, 10, 2, 45, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(45, '33102', 'N', 'Escavadeira Hidráulica 314D CR/314D LCR', '2009', 3, 'Escavadeiras', '1:46', 0.9, 11.5, 4.2, 5.5, 'Amarelo', 85.60, 5, 10, 10, 125, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(46, '34101', 'N', 'Caminhão Fora de Estrada 770', '2009', 3, 'Fora de estrada', '1:46', 1.3, 15.6, 4.2, 5.5, 'Amarelo', 295.00, 5, 10, 10, 100, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(47, '34102', 'N', 'Caminhão Fora de Estrada 775F', '2009', 3, 'Fora de estrada', '1:46', 1.2, 16.4, 4.2, 5.5, 'Amarelo', 268.00, 5, 10, 10, 45, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(48, '35101', 'S', 'Minerador 785D', '2009', 3, 'Mineração', '1:46', 1.1, 14.6, 4.7, 5.5, 'Amarelo', 194.00, 5, 10, 10, 41, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(49, '35102', 'N', '789C Mining Truck', '2009', 3, 'Mineração', '1:46', 1.1, 14.8, 4.6, 5.5, 'Amarelo', 189.50, 5, 10, 10, 75, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(50, '36101', 'N', 'Pavimentadora de Asfalto AP-1000D', '2009', 3, 'Pavimentação', '1:46', 1.3, 13.4, 4.2, 5.5, 'Amarelo', 127.00, 5, 10, 10, 46, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-18'),
(51, '36102', 'S', 'Misturador Rotativo RM-500', '2009', 3, 'Pavimentação', '1:46', 1.1, 12.8, 4.5, 5.5, 'Amarelo', 95.60, 5, 10, 10, 24, 10, 'http://brasil.cat.com (acesso 21/09/2009)', '2009-07-20'),
(52, '41101', 'N', 'American LaFrance Fire Pumper', '1921', 4, 'Caminhões de bombeiro', '1:36', 1.2, 11.5, 4.2, 5.5, 'Vermelho', 155.00, 5, 10, 10, 12, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(53, '41102', 'N', 'Studebaker South Bend, Indiana F.D. ', '1928', 4, 'Caminhões de bombeiro', '1:36', 1.1, 11.5, 4.3, 5.5, 'Vermelho', 147.00, 5, 10, 10, 44, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(54, '41103', 'N', 'GMC CO2 Firewagon', '1941', 4, 'Caminhões de bombeiro', '1:36', 1.3, 11.5, 4.3, 5.5, 'Vermelho', 135.00, 5, 10, 10, 19, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(55, '41104', 'N', 'MACK C (1000GPM) Fire Pumper', '1960', 4, 'Caminhões de bombeiro', '1:36', 1.0, 11.5, 4.2, 5.5, 'Vermelho', 155.00, 5, 10, 10, 29, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(56, '41105', 'S', 'Ford Fire Engine', '1938', 4, 'Caminhões de bombeiro', '1:36', 1.1, 11.5, 4.9, 5.5, 'Vermelho', 155.00, 5, 10, 10, 44, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(57, '41106', 'N', 'Mercedes-Benz L4500F Fire Engine', '1944', 4, 'Caminhões de bombeiro', '1:36', 1.1, 11.5, 5.3, 5.5, 'Vermelho', 168.00, 5, 10, 10, 1, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(58, '41107', 'N', 'F.D.N.Y. E-One Rescue Truck ', '1985', 4, 'Caminhões de bombeiro', '1:36', 1.1, 11.5, 5.0, 5.5, 'Vermelho', 169.00, 5, 10, 10, 0, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(59, '41108', 'N', 'F.D.N.Y. Super Tender', '1970', 4, 'Caminhões de bombeiro', '1:36', 0.8, 11.5, 4.2, 5.5, 'Vermelho', 97.50, 5, 10, 10, 0, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(60, '41109', 'N', 'Ford Tanker Truck', '1934', 4, 'Veículos antigos', '1:36', 1.0, 11.5, 4.3, 5.5, 'Azul', 127.00, 5, 10, 5, 0, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(61, '41110', 'N', 'Ford Chain Truck', '1934', 4, 'Veículos antigos', '1:36', 1.1, 11.5, 4.2, 5.5, 'Verde', 136.50, 5, 10, 10, 0, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-20'),
(62, '41111', 'N', 'Chevrolet Ajax Flatbed Truck', '1941', 4, 'Veículos antigos', '1:36', 1.1, 11.5, 4.2, 5.5, 'Laranja', 122.00, 5, 10, 10, 0, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-25'),
(63, '41112', 'N', 'Historical UPS Truck - Ford', '1934', 4, 'Veículos antigos', '1:36', 0.9, 11.5, 4.3, 5.5, 'Preto', 105.00, 5, 10, 10, 18, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-25'),
(64, '41113', 'N', 'Ford F100', '1956', 4, 'Veículos antigos', '1:36', 0.8, 11.5, 5.8, 5.5, 'Amarelo', 155.00, 5, 10, 10, 45, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-25'),
(65, '42101', 'N', 'JDH', '1928', 5, 'Motos antigas', '1:18', 0.4, 7.5, 2.5, 5.5, 'Preto', 85.00, 5, 10, 4, 79, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(66, '42102', 'N', 'Indian Sport Scout', '1934', 5, 'Motos antigas', '1:18', 0.4, 6.2, 2.5, 5.5, 'Amarelo', 85.00, 5, 10, 4, 85, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(67, '42103', 'N', 'Harley Davidson El Knucklehead', '1936', 5, 'Motos antigas', '1:18', 0.5, 5.3, 2.4, 5.5, 'Roxo', 85.00, 5, 10, 4, 47, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(68, '42104', 'N', 'Panhead ', '1948', 5, 'Motos antigas', '1:18', 0.4, 7.3, 2.8, 5.5, 'Vermelho', 85.00, 5, 10, 4, 65, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(69, '42105', 'S', 'Duo-Glide', '1958', 5, 'Motos antigas', '1:18', 0.6, 6.4, 2.8, 5.5, 'Azul', 85.00, 5, 10, 4, 54, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(70, '42106', 'N', 'Harley Davidson FLHT Virginia State Police', '1998', 5, 'Motos atuais', '1:18', 0.6, 5.9, 2.9, 5.5, 'Preto', 85.00, 5, 10, 4, 24, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(71, '42107', 'N', 'Harley Davidson FLSTC Heritage Softail Classic ', '2000', 5, 'Motos atuais', '1:18', 0.6, 6.7, 2.7, 5.5, 'Preto', 85.00, 5, 10, 4, 25, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-07-28'),
(72, '51101', 'N', 'Embraer ERJ 135', '2009', 6, 'Embraer', '1:42', 1.1, 20.5, 18.5, 5.5, 'Azul/branco', 210.00, 5, 10, 10, 4, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-07-28'),
(73, '51102', 'N', 'Embraer EMB 120', '2009', 6, 'Embraer', '1:42', 1.1, 19.5, 17.2, 5.5, 'Azul/branco', 205.00, 5, 10, 10, 0, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-07-28'),
(74, '51103', 'N', 'Embraer ERJ 140', '2009', 6, 'Embraer', '1:42', 1.3, 21.7, 18.2, 5.5, 'Azul/branco', 187.00, 5, 10, 10, 45, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-08-15'),
(75, '51104', 'N', 'Embraer Super Tucano', '2009', 6, 'Embraer', '1:42', 1.0, 19.6, 19.4, 5.5, 'Verde/branco', 157.00, 5, 10, 10, 3, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-08-15'),
(76, '51105', 'N', 'Embraer EMB 145 AEW&C', '2009', 6, 'Embraer', '1:42', 1.3, 18.6, 17.2, 5.5, 'Prata', 196.00, 5, 10, 10, 2, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-08-15'),
(77, '51106', 'N', 'Embraer 175', '2009', 6, 'Embraer', '1:42', 1.3, 19.5, 19.0, 5.5, 'Azul/branco', 178.50, 5, 10, 10, 48, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-08-15'),
(78, '51107', 'N', 'Embraer 195', '2009', 6, 'Embraer', '1:42', 1.0, 21.9, 17.2, 5.5, 'Azul/branco', 152.00, 5, 10, 10, 214, 10, 'http://www.embraer.com.br (acesso 21/09/2009)', '2009-08-15'),
(79, '51108', 'N', 'Boeing 777-400', '2009', 6, 'Boeing', '1:42', 1.4, 24.8, 21.8, 5.5, 'Azul/branco', 210.50, 5, 10, 10, 48, 10, 'http://www.boeing.com (acesso 21/09/2009)', '2009-08-15'),
(80, '61101', 'S', 'Dodge Military Power Wagon', '1946', 7, 'Veículos antigos', '1:18', 1.0, 11.5, 4.2, 5.5, 'Verde', 78.00, 5, 10, 2, 42, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(81, '61102', 'N', 'White Ambulance', '1920', 7, 'Veículos antigos', '1:18', 1.0, 11.5, 4.2, 5.5, 'Verde', 75.60, 5, 10, 10, 1, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(82, '61103', 'N', 'Willys U.S. Army Jeep', '1941', 7, 'Veículos antigos', '1:18', 1.1, 11.5, 4.2, 5.5, 'Verde', 89.60, 5, 10, 10, 44, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(83, '61104', 'N', 'Original World War II Jeep', '1941', 7, 'Veículos antigos', '1:18', 0.9, 11.5, 4.2, 5.5, 'Verde', 72.00, 5, 10, 10, 67, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(84, '61105', 'S', 'Chevrolet® U.S. Hickam Air Field Flatbed ', '1941', 7, 'Veículos antigos', '1:18', 0.9, 11.5, 4.2, 5.5, 'Verde', 65.00, 5, 10, 10, 47, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(85, '61106', 'N', 'Berlin Express Tanker', '1952', 7, 'Veículos antigos', '1:18', 1.1, 11.5, 4.2, 5.5, 'Verde', 110.00, 5, 10, 10, 127, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(86, '61107', 'N', 'German Panther Tank', '1960', 7, 'Veículos antigos', '1:18', 1.2, 11.5, 4.2, 5.5, 'Verde', 95.60, 5, 10, 10, 4, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(87, '61108', 'N', 'Marine M1A1 Abrams Tank', '1972', 7, 'Veículos antigos', '1:18', 1.2, 11.5, 4.2, 5.5, 'Verde', 105.50, 5, 10, 10, 0, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(88, '61109', 'N', 'Westland Wessex HC', '1985', 7, 'Veículos antigos', '1:18', 0.9, 11.5, 4.2, 5.5, 'Verde', 89.70, 5, 10, 10, 87, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(89, '61110', 'N', 'WWII Army Ambulance ', '1925', 7, 'Veículos antigos', '1:18', 0.9, 11.5, 4.2, 5.5, 'Verde', 85.20, 5, 10, 10, 39, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-20'),
(90, '51109', 'N', 'Boeing 747-Cargo', '2003', 6, 'Boeing', '1:42', 1.2, 38.4, 21.1, 12.2, 'Azu/branco', 312.00, 5, 10, 10, 100, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2009-08-15'),
(104, '55555', 'S', 'TESTE DE IMPRESSAO', '', 0, '', '10', 10.0, 10.0, 10.0, 10.0, '', 10.00, 10, 10, 10, 10, 10, 'http://www.motormint.com (acesso 21/09/2009)', '2023-09-25'),
(105, '12345', 'S', 'TESTE DE MINIATURA', '', 0, '', '545', 454.0, 5.0, 54.0, 54.0, '', 54.00, 54, 4, 54, 5, 45, 'http://www.motormint.com (acesso 21/09/2009)', '2023-09-25');

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `num_ped` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `data` date NOT NULL,
  `hora` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `valor` decimal(18,2) NOT NULL,
  `vencimento` date NOT NULL,
  `frete` decimal(18,2) NOT NULL,
  `desconto` decimal(18,2) NOT NULL,
  `formapag` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `peso` decimal(9,3) NOT NULL,
  `cartao` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `num_cartao` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `venc_cartao` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `nome_cartao` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `cod_cartao` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `parcelas` int(11) NOT NULL,
  `data_pag` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `tb_estados` (
  `id` int(2) UNSIGNED ZEROFILL NOT NULL,
  `uf` varchar(2) NOT NULL DEFAULT '',
  `nome` varchar(20) NOT NULL DEFAULT '',
  `frete` float(9,2) DEFAULT NULL,
  `cepi` char(8) DEFAULT NULL,
  `cepf` char(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tb_estados` (`id`, `uf`, `nome`, `frete`, `cepi`, `cepf`) VALUES
(01, 'AC', 'Acre', 9.75, '69900000', '69999999'),
(02, 'AL', 'Alagoas', 7.70, '57000000', '57999999'),
(03, 'AM', 'Amazonas', 9.70, '69000000', '69899999'),
(04, 'AP', 'Amapá', 7.85, '68900000', '68999999'),
(05, 'BA', 'Bahia', 6.56, '40000000', '48999999'),
(06, 'CE', 'Ceará', 8.30, '60000000', '63999999'),
(07, 'DF', 'Distrito Federal', 7.50, '70000000', '73699999'),
(08, 'ES', 'Espírito Santo', 4.50, '29000000', '29999999'),
(09, 'GO', 'Goiás', 5.20, '72800000', '76799999'),
(10, 'MA', 'Maranhão', 7.20, '65000000', '65999999'),
(11, 'MG', 'Minas Gerais', 5.25, '78000000', '78899999'),
(12, 'MS', 'Mato Grosso do Sul', 5.18, '79000000', '79999999'),
(13, 'MT', 'Mato Grosso', 6.17, '30000000', '39999999'),
(14, 'PA', 'Pará', 7.78, '66000000', '68899999'),
(15, 'PB', 'Paraíba', 8.20, '58000000', '58999999'),
(16, 'PE', 'Pernambuco', 9.10, '50000000', '56999999'),
(17, 'PI', 'Piauí', 8.57, '64000000', '64999999'),
(18, 'PR', 'Paraná', 4.70, '80000000', '87999999'),
(19, 'RJ', 'Rio de Janeiro', 4.50, '20000000', '28999999'),
(20, 'RN', 'Rio Grande do Norte', 7.25, '59000000', '59999999'),
(21, 'RO', 'Rondônia', 8.25, '78900000', '78999999'),
(22, 'RR', 'Roraima', 7.89, '69300000', '69399999'),
(23, 'RS', 'Rio Grande do Sul', 5.12, '90000000', '99999999'),
(24, 'SC', 'Santa Catarina', 4.78, '88000000', '89999999'),
(25, 'SE', 'Sergipe', 7.90, '49000000', '49999999'),
(26, 'SP', 'São Paulo', 0.00, '01000000', '19999999'),
(27, 'TO', 'Tocantins', 8.20, '77000000', '77999999');


ALTER TABLE `cadcli`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `itens`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `miniaturas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `id_categoria` (`id_categoria`);

ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_estados`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `cadcli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

ALTER TABLE `itens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

ALTER TABLE `miniaturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;

ALTER TABLE `tb_estados`
  MODIFY `id` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;