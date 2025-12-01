-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01/12/2025 às 12:50
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
-- Banco de dados: `locadora`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_carro` int(11) NOT NULL,
  `data_reserva` date NOT NULL,
  `data_devolucao` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamentos`
--

INSERT INTO `agendamentos` (`id`, `id_cliente`, `id_carro`, `data_reserva`, `data_devolucao`) VALUES
(1, 1, 3, '2024-01-10', '2024-01-17'),
(2, 2, 5, '2024-02-05', '2024-02-12'),
(3, 3, 7, '2024-03-15', '2024-03-22'),
(4, 4, 1, '2024-04-01', '2024-04-08'),
(5, 5, 6, '2024-05-20', '2024-05-27'),
(6, 6, 4, '2024-06-15', '2024-06-21'),
(7, 7, 2, '2024-07-14', '2024-07-20'),
(8, 8, 8, '2024-08-01', '2024-08-08'),
(9, 9, 10, '2024-09-15', '2024-09-22'),
(10, 10, 9, '2024-10-12', '2024-10-19'),
(11, 11, 11, '2024-11-01', '2024-11-08'),
(12, 12, 12, '2024-12-01', '2024-12-08'),
(13, 13, 14, '2024-01-15', '2024-01-22'),
(14, 14, 2, '2024-02-10', '2024-02-17'),
(15, 15, 3, '2024-03-05', '2024-03-12'),
(16, 16, 6, '2024-04-10', '2024-04-17'),
(17, 17, 7, '2024-05-15', '2024-05-22'),
(18, 18, 12, '2024-06-01', '2024-06-08'),
(19, 19, 13, '2024-07-01', '2024-07-08'),
(20, 20, 15, '2024-08-15', '2024-08-22');

-- --------------------------------------------------------

--
-- Estrutura para tabela `carros`
--

CREATE TABLE `carros` (
  `id` int(11) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `placa` varchar(20) NOT NULL,
  `ano` int(11) NOT NULL,
  `cor` varchar(30) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'disponível'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `carros`
--

INSERT INTO `carros` (`id`, `modelo`, `marca`, `placa`, `ano`, `cor`, `status`) VALUES
(1, 'Chevrolet Onix', NULL, 'ABC-1234', 2022, 'Preto', 'Sim'),
(2, 'Fiat Argo', NULL, 'DEF-5678', 2021, 'Branco', 'Não'),
(3, 'Honda Civic', NULL, 'GHI-9101', 2020, 'Prata', 'Sim'),
(4, 'Toyota Corolla', NULL, 'JKL-1122', 2023, 'Azul', 'Sim'),
(5, 'Volkswagen Gol', NULL, 'MNO-3344', 2020, 'Vermelho', 'Não'),
(6, 'Ford Ka', NULL, 'PQR-5566', 2021, 'Preto', 'Sim'),
(7, 'Nissan Sentra', NULL, 'STU-7788', 2020, 'Branco', 'Sim'),
(8, 'Hyundai HB20', NULL, 'VWX-9900', 2021, 'Azul', 'Não'),
(9, 'Renault Kwid', NULL, 'XYZ-1234', 2023, 'Prata', 'Sim'),
(10, 'Jeep Compass', NULL, 'ABC-5678', 2022, 'Verde', 'Não'),
(11, 'Peugeot 208', NULL, 'DEF-9101', 2021, 'Amarelo', 'Sim'),
(12, 'Chevrolet Spin', NULL, 'GHI-1122', 2020, 'Cinza', 'Sim'),
(13, 'Honda Fit', NULL, 'JKL-3344', 2023, 'Branco', 'Não'),
(14, 'Toyota Etios', NULL, 'MNO-5566', 2022, 'Vermelho', 'Sim'),
(15, 'Volkswagen Polo', NULL, 'PQR-7788', 2021, 'Preto', 'Não'),
(16, 'Citroën C3', NULL, 'STU-9900', 2020, 'Azul', 'Sim'),
(17, 'Ford Fiesta', NULL, 'VWX-1234', 2023, 'Cinza', 'Sim'),
(18, 'Nissan Kicks', NULL, 'XYZ-5678', 2022, 'Verde', 'Sim'),
(19, 'Renault Duster', NULL, 'ABC-9100', 2021, 'Preto', 'Sim'),
(20, 'BMW X1', NULL, 'DEF-1122', 2020, 'Branco', 'Não');

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `cpf`, `email`, `telefone`) VALUES
(1, 'João Silva', 123456, 'joao@email.com', '11987654321'),
(2, 'Maria Oliveira', 234567, 'maria@email.com', '11987654321'),
(3, 'Pedro Costa', 345678, 'pedro@email.com', '11987654323'),
(4, 'Ana Souza', 456789, 'ana@email.com', '11987654324'),
(5, 'Carlos Pereira', 567890, 'carlos@email.com', '11987654325'),
(6, 'Juliana Lima', 678901, 'juliana@email.com', '11987654326'),
(7, 'Roberto Martins', 789012, 'roberto@email.com', '11987654327'),
(8, 'Fernanda Almeida', 890123, 'fernanda@email.com', '11987654328'),
(9, 'Thiago Santos', 901234, 'thiago@email.com', '11987654329'),
(10, 'Larissa Costa', 123456, 'larissa@email.com', '11987654330'),
(11, 'Marcos Rodrigues', 234567, 'marcos@email.com', '11987654331'),
(12, 'Silvia Oliveira', 345678, 'silvia@email.com', '11987654332'),
(13, 'Daniel Costa', 456789, 'daniel@email.com', '11987654333'),
(14, 'Gabriela Silva', 567890, 'gabriela@email.com', '11987654334'),
(15, 'Fábio Lima', 678901, 'fabio@email.com', '11987654335'),
(16, 'Camila Pereira', 789012, 'camila@email.com', '11987654336'),
(17, 'Eduardo Santos', 890123, 'eduardo@email.com', '11987654337'),
(18, 'Mariana Oliveira', 901234, 'mariana@email.com', '11987654338'),
(19, 'Lucas Almeida', 123456, 'lucas@email.com', '11987654339'),
(20, 'Tatiane Martins', 234567, 'tatiane@email.com', '11987654340');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
