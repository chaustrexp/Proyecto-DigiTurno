-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-05-2026 a las 18:24:54
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `apesena`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesor`
--

CREATE TABLE `asesor` (
  `ase_id` int(11) NOT NULL,
  `ase_nrocontrato` varchar(45) DEFAULT NULL,
  `ase_tipo_asesor` enum('OT','OV','AT') NOT NULL DEFAULT 'OT',
  `ase_sede` varchar(100) NOT NULL DEFAULT 'Sede Central Antioquia',
  `ase_capacitado_victimas` tinyint(1) NOT NULL DEFAULT 0,
  `ase_genero` varchar(10) DEFAULT NULL,
  `ase_vigencia` varchar(45) DEFAULT NULL,
  `ase_password` varchar(255) DEFAULT NULL,
  `ase_correo` varchar(100) DEFAULT NULL,
  `PERSONA_pers_doc` bigint(20) UNSIGNED DEFAULT NULL,
  `ase_foto` varchar(255) DEFAULT 'images/foto de perfil.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asesor`
--

INSERT INTO `asesor` (`ase_id`, `ase_nrocontrato`, `ase_tipo_asesor`, `ase_sede`, `ase_capacitado_victimas`, `ase_genero`, `ase_vigencia`, `ase_password`, `ase_correo`, `PERSONA_pers_doc`, `ase_foto`) VALUES
(2, NULL, 'OT', 'Prado Norte', 1, 'M', NULL, '$2y$12$twjPYhrAOILfvs5WX4F3L.xczNt.ILB0EcQFwy9VJS6/66664yFae', 'asesor1@sena.edu.co', 12345678, 'images/foto de perfil asesor.png'),
(3, NULL, 'AT', 'Centro Cúcuta', 0, 'F', NULL, '$2y$12$T7yXlFnj/aB82c64HiSH4ORZuKsf93JXkNJAEVlJwqSHBfWigYYzu', 'asesor2@sena.edu.co', 11111111, 'images/foto de perfil asesora.png'),
(4, NULL, 'OT', 'Villa del Rosario', 1, 'M', NULL, '$2y$12$UgIula2LRZjnKiaol.YkWuaIjLtWd3AigKd6mm7SQX.XTdq.7kdMW', 'asesor3@sena.edu.co', 22222222, 'images/foto de perfil asesor.png'),
(10, 'cont-272', 'OT', 'Sede Norte de Santander', 1, 'F', '2027-05-05', '$2y$12$6/TTlyfB6IzBjrBykPUOWeZtbHaiTJE.Z7yA4AyxgM1u0KxFqJzgu', 'asesor4@sena.edu.co', 60253100, 'images/foto de perfil asesora.png'),
(11, 'CONT-MOD-003', 'AT', 'Sede Norte de Santander', 0, 'F', '2027-05-06', '$2y$12$D.pbc47We1OhcoNFRaTTYuwQFDfXJE6Y795R1VmXPMzJBcDBnOJHC', 'asesor5@sena.edu.co', 30000003, 'images/foto de perfil asesora.png'),
(12, 'cont-2734', 'AT', 'Sede Norte de Santander', 0, 'F', '2027-05-06', '$2y$12$fZ5pZz8/WNuFRIk9bPD07ebUiEvDIGzTLnsvFaOd8VktPxAkjaaBm', 'asesor6@sena.edu.co', 10534567, 'images/foto de perfil asesora.png'),
(13, 'cont-275', 'AT', 'Sede Norte de Santander', 0, 'M', '2027-05-06', '$2y$12$42ZHH.oYVp7134TTWQK4hu39ZpSVvX4I7IHalkPlRTdNPHbZAdvJ6', 'asesor7@sena.edu.co', 1005026715, 'images/foto de perfil asesor.png'),
(14, 'cont-290', 'OV', 'Sede Norte de Santander', 1, 'M', '2027-05-11', '$2y$12$8DB.7UHNaT7p01Y0aE/Wm.rbCxG2FwGrniCu116Bo1JzhKkqdRHjq', 'asesor8@sena.edu.co', 602334546, 'images/foto de perfil asesor.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `atencion`
--

CREATE TABLE `atencion` (
  `atnc_id` int(11) NOT NULL,
  `atnc_hora_inicio` datetime DEFAULT NULL,
  `atnc_hora_real_inicio` timestamp NULL DEFAULT NULL,
  `atnc_hora_fin` datetime DEFAULT NULL,
  `observaciones` text DEFAULT NULL COMMENT 'Conclusión o notas del trámite registradas por el asesor',
  `atnc_tipo` enum('General','Prioritaria','Victimas') NOT NULL,
  `atnc_veces_llamado` int(11) NOT NULL DEFAULT 1,
  `ASESOR_ase_id` int(11) DEFAULT NULL,
  `TURNO_tur_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `atencion`
--

INSERT INTO `atencion` (`atnc_id`, `atnc_hora_inicio`, `atnc_hora_real_inicio`, `atnc_hora_fin`, `observaciones`, `atnc_tipo`, `atnc_veces_llamado`, `ASESOR_ase_id`, `TURNO_tur_id`) VALUES
(1, '2026-05-04 22:33:52', NULL, '2026-05-04 22:34:14', NULL, 'General', 1, 3, 7),
(2, '2026-05-05 16:18:09', NULL, '2026-05-05 16:19:38', NULL, 'General', 1, 10, 8),
(3, '2026-05-06 14:03:34', NULL, '2026-05-06 14:13:50', NULL, 'Prioritaria', 1, 10, 10),
(4, '2026-05-06 14:32:03', NULL, '2026-05-06 14:32:50', NULL, 'Prioritaria', 1, 11, 9),
(5, '2026-05-06 14:42:48', NULL, '2026-05-13 09:46:27', NULL, 'Prioritaria', 1, 11, 11),
(6, '2026-05-06 15:08:14', NULL, '2026-05-06 15:10:05', NULL, 'Prioritaria', 1, 12, 12),
(7, '2026-05-07 14:44:29', NULL, '2026-05-07 15:08:43', NULL, 'Prioritaria', 1, 3, 13),
(8, '2026-05-07 16:42:41', NULL, '2026-05-07 16:47:28', NULL, 'Prioritaria', 1, 3, 14),
(9, '2026-05-07 16:47:34', NULL, '2026-05-07 16:48:52', NULL, 'Prioritaria', 1, 3, 15),
(10, '2026-05-11 13:40:19', NULL, '2026-05-11 20:59:17', NULL, 'General', 1, 3, 16),
(11, '2026-05-11 15:23:14', NULL, '2026-05-11 20:45:53', NULL, 'General', 1, 2, 17),
(12, '2026-05-11 20:59:23', NULL, '2026-05-11 21:02:30', NULL, 'General', 1, 3, 18),
(13, '2026-05-11 21:55:53', NULL, '2026-05-11 22:10:26', NULL, 'Prioritaria', 1, 2, 19),
(14, '2026-05-11 22:10:30', NULL, '2026-05-11 18:09:37', NULL, 'General', 1, 2, 24),
(15, '2026-05-11 22:13:40', NULL, '2026-05-11 17:27:36', NULL, 'Prioritaria', 1, 4, 21),
(16, '2026-05-11 17:27:40', NULL, '2026-05-11 17:27:45', NULL, 'General', 1, 4, 26),
(17, '2026-05-11 17:27:50', NULL, '2026-05-11 17:27:51', NULL, 'Prioritaria', 1, 4, 27),
(18, '2026-05-11 17:27:56', NULL, '2026-05-11 17:39:03', NULL, 'Prioritaria', 1, 4, 22),
(19, '2026-05-11 17:39:07', NULL, '2026-05-11 17:42:47', NULL, 'General', 1, 4, 28),
(20, '2026-05-11 17:43:05', NULL, '2026-05-11 18:07:44', NULL, 'General', 1, 4, 29),
(21, '2026-05-11 18:07:49', NULL, '2026-05-11 18:08:01', NULL, 'General', 1, 4, 30),
(22, '2026-05-11 18:08:06', NULL, '2026-05-11 18:08:29', NULL, 'General', 1, 4, 31),
(23, '2026-05-11 18:08:34', NULL, '2026-05-13 08:50:26', NULL, 'General', 1, 4, 32),
(24, '2026-05-11 18:09:43', NULL, '2026-05-11 18:09:59', NULL, 'Prioritaria', 1, 2, 23),
(25, '2026-05-11 18:10:04', NULL, '2026-05-11 18:10:06', NULL, 'Prioritaria', 1, 2, 25),
(26, '2026-05-11 18:10:12', NULL, '2026-05-11 18:10:25', NULL, 'General', 1, 2, 20),
(27, '2026-05-12 10:49:25', NULL, '2026-05-12 10:50:34', NULL, 'Prioritaria', 1, 2, 33),
(28, '2026-05-12 10:53:33', NULL, '2026-05-12 10:58:14', NULL, 'General', 1, 2, 34),
(29, '2026-05-12 11:03:44', NULL, '2026-05-12 11:04:55', NULL, 'Prioritaria', 1, 13, 35),
(30, '2026-05-13 07:56:56', NULL, '2026-05-13 08:01:28', NULL, 'Prioritaria', 1, 2, 36),
(31, '2026-05-13 08:08:57', NULL, '2026-05-13 08:11:31', NULL, 'Prioritaria', 1, 2, 37),
(32, '2026-05-13 08:13:46', NULL, '2026-05-13 08:31:06', 'no asisitio', 'General', 1, 2, 38),
(33, '2026-05-13 08:45:53', NULL, '2026-05-13 08:49:56', 'no se presento', 'Prioritaria', 1, 2, 39),
(34, '2026-05-13 08:52:03', NULL, '2026-05-13 08:53:24', NULL, 'Prioritaria', 1, 2, 40),
(35, '2026-05-13 08:53:50', NULL, '2026-05-13 08:54:51', NULL, 'Prioritaria', 1, 2, 41),
(36, '2026-05-13 08:55:59', NULL, '2026-05-13 08:56:08', 'no se presento', 'Prioritaria', 1, 2, 42),
(37, '2026-05-13 09:18:33', '2026-05-13 14:39:51', '2026-05-13 09:41:06', NULL, 'Prioritaria', 3, 2, 43),
(38, '2026-05-13 09:42:36', NULL, '2026-05-13 09:43:37', 'no se presento', 'General', 3, 2, 44),
(39, '2026-05-13 09:48:07', NULL, '2026-05-13 09:49:11', NULL, 'Prioritaria', 3, 2, 45),
(40, '2026-05-13 10:32:37', NULL, '2026-05-13 10:38:22', NULL, 'Prioritaria', 3, 2, 46),
(41, '2026-05-13 10:39:11', NULL, '2026-05-13 10:39:32', NULL, 'General', 3, 2, 47),
(42, '2026-05-13 10:40:05', NULL, '2026-05-13 10:40:05', NULL, 'Prioritaria', 2, 2, 48),
(43, '2026-05-13 10:40:33', NULL, '2026-05-13 10:40:38', NULL, 'Prioritaria', 2, 2, 49),
(44, '2026-05-13 11:07:17', NULL, '2026-05-13 11:07:25', NULL, 'Prioritaria', 2, 13, 53),
(45, '2026-05-13 11:07:31', NULL, '2026-05-13 11:07:40', NULL, 'Prioritaria', 1, 13, 54),
(46, '2026-05-13 11:07:46', NULL, '2026-05-13 11:08:02', NULL, 'Prioritaria', 1, 13, 55),
(47, '2026-05-13 11:08:51', NULL, '2026-05-13 11:12:32', NULL, 'General', 3, 13, 50),
(48, '2026-05-13 11:13:15', NULL, NULL, NULL, 'Prioritaria', 3, 13, 51),
(49, '2026-05-15 09:30:23', NULL, '2026-05-15 09:34:14', NULL, 'General', 3, 2, 56),
(50, '2026-05-15 09:35:27', NULL, NULL, NULL, 'Prioritaria', 3, 2, 57),
(51, '2026-05-15 10:29:01', NULL, '2026-05-15 10:30:26', 'no se presento el solicitante', 'Prioritaria', 1, 4, 58),
(52, '2026-05-15 10:30:31', NULL, '2026-05-15 10:37:53', 'no se presento', 'Prioritaria', 1, 4, 59),
(53, '2026-05-15 10:43:48', NULL, '2026-05-15 10:44:03', 'no se presento\r\nn', 'General', 2, 4, 60);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-53f11be06b43e2ad45a869078b38dfd8', 'i:1;', 1778859239),
('laravel-cache-53f11be06b43e2ad45a869078b38dfd8:timer', 'i:1778859239;', 1778859239),
('laravel-cache-ef855c70c9e517abb1c7e71b78a2eded', 'i:1;', 1778601877),
('laravel-cache-ef855c70c9e517abb1c7e71b78a2eded:timer', 'i:1778601877;', 1778601877),
('laravel-cache-prioritario_counter', 'i:1;', 1778775158);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_sistema`
--

CREATE TABLE `configuracion_sistema` (
  `id` int(10) UNSIGNED NOT NULL,
  `clave` varchar(100) NOT NULL COMMENT 'Nombre del parámetro',
  `valor` varchar(255) NOT NULL COMMENT 'Valor del parámetro',
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Descripción del parámetro',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion_sistema`
--

INSERT INTO `configuracion_sistema` (`id`, `clave`, `valor`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'ciclo_turno', 'dia', 'Ciclo de reinicio de numeración de turnos: dia | semana | mes', '2026-04-30 18:10:01', '2026-04-30 18:10:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinador`
--

CREATE TABLE `coordinador` (
  `coor_id` int(11) NOT NULL,
  `coor_vigencia` varchar(45) DEFAULT NULL,
  `coor_correo` varchar(100) DEFAULT NULL,
  `coor_password` varchar(100) DEFAULT NULL,
  `PERSONA_pers_doc` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `coordinador`
--

INSERT INTO `coordinador` (`coor_id`, `coor_vigencia`, `coor_correo`, `coor_password`, `PERSONA_pers_doc`) VALUES
(4, '2027-12-31', 'coordinador@sena.edu.co', '$2y$12$qM/lCRGlfpEwgZBZv1juc.U.jdzeOQcONT6oHPgMcxeAmsLKEDo/q', 9000000001);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_21_032735_change_pers_doc_to_bigint_on_multiple_tables', 2),
(5, '2026_04_15_000001_add_fields_to_turno_table', 3),
(6, '2026_04_15_000002_create_pausas_asesor_table', 4),
(7, '2026_04_20_000001_add_hora_llamado_to_turno_table', 5),
(8, '2026_04_20_000002_standardize_ase_tipo_asesor', 6),
(9, '2026_04_22_024747_add_triggers_to_pausas_asesor', 7),
(10, '2026_04_25_225000_optimize_turno_table', 8),
(11, '2026_04_29_000001_add_estado_to_turno_table', 9),
(12, '2026_04_29_000002_add_credentials_to_coordinador_table', 9),
(13, '0000_00_00_000000_create_base_schema', 10),
(14, '2026_04_29_000003_create_configuracion_sistema_table', 10),
(15, '2026_05_05_000001_add_at_to_ase_tipo_asesor', 11),
(16, '2026_05_05_000002_add_observaciones_to_atencion_table', 12),
(17, '2026_05_11_140342_add_capacitado_victimas_to_asesor_table', 13),
(18, '2026_05_11_142718_add_genero_to_asesor_table', 14),
(19, '2026_05_11_143007_update_existing_asesores_photos', 15),
(20, '2026_05_13_084010_add_sede_to_asesor_table', 16),
(21, '2026_05_13_091229_add_veces_llamado_to_atencion_table', 17),
(22, '2026_05_13_091614_add_iniciada_to_atencion_table', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pausas_asesor`
--

CREATE TABLE `pausas_asesor` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ASESOR_ase_id` int(10) UNSIGNED NOT NULL,
  `hora_inicio` datetime NOT NULL,
  `hora_fin` datetime DEFAULT NULL,
  `duracion` int(10) UNSIGNED DEFAULT NULL COMMENT 'Duración en minutos',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pausas_asesor`
--

INSERT INTO `pausas_asesor` (`id`, `ASESOR_ase_id`, `hora_inicio`, `hora_fin`, `duracion`, `created_at`, `updated_at`) VALUES
(1, 2, '2026-05-12 11:00:19', '2026-05-12 11:01:00', 0, '2026-05-12 16:00:19', '2026-05-12 16:01:00'),
(2, 2, '2026-05-12 11:01:04', '2026-05-12 11:02:45', 1, '2026-05-12 16:01:04', '2026-05-12 16:02:45'),
(3, 2, '2026-05-13 08:02:36', '2026-05-13 08:02:39', 0, '2026-05-13 13:02:36', '2026-05-13 13:02:39'),
(4, 2, '2026-05-13 08:02:43', '2026-05-13 08:07:24', 4, '2026-05-13 13:02:43', '2026-05-13 13:07:24'),
(5, 2, '2026-05-13 08:32:15', '2026-05-13 08:32:18', 0, '2026-05-13 13:32:15', '2026-05-13 13:32:18'),
(6, 13, '2026-05-13 09:01:18', '2026-05-13 09:14:22', 13, '2026-05-13 14:01:18', '2026-05-13 14:14:22'),
(7, 13, '2026-05-13 10:41:48', '2026-05-13 10:43:11', 1, '2026-05-13 15:41:48', '2026-05-13 15:43:11'),
(8, 2, '2026-05-15 09:28:28', '2026-05-15 09:28:33', 0, '2026-05-15 14:28:28', '2026-05-15 14:28:33');

--
-- Disparadores `pausas_asesor`
--
DELIMITER $$
CREATE TRIGGER `trg_calc_duracion_receso` BEFORE UPDATE ON `pausas_asesor` FOR EACH ROW BEGIN IF NEW.hora_fin IS NOT NULL
  AND OLD.hora_fin IS NULL THEN
SET NEW.duracion = TIMESTAMPDIFF(MINUTE, NEW.hora_inicio, NEW.hora_fin);
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_evitar_doble_receso` BEFORE INSERT ON `pausas_asesor` FOR EACH ROW BEGIN
DECLARE pausas_abiertas INT;
SELECT COUNT(*) INTO pausas_abiertas
FROM pausas_asesor
WHERE ASESOR_ase_id = NEW.ASESOR_ase_id
  AND hora_fin IS NULL;
IF pausas_abiertas > 0 THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: El asesor ya tiene un receso activo en curso.';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `pers_doc` bigint(20) UNSIGNED NOT NULL,
  `pers_tipodoc` varchar(45) DEFAULT NULL,
  `pers_nombres` varchar(100) DEFAULT NULL,
  `pers_apellidos` varchar(100) DEFAULT NULL,
  `pers_telefono` bigint(10) DEFAULT NULL,
  `pers_fecha_nac` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`pers_doc`, `pers_tipodoc`, `pers_nombres`, `pers_apellidos`, `pers_telefono`, `pers_fecha_nac`) VALUES
(0, 'CC', 'Usuario', 'Kiosco', 8888888888, NULL),
(123, 'CC', 'Test', 'User', NULL, NULL),
(186342, 'CE', 'Usuario', 'Kiosco', 3228574190, NULL),
(205741, 'CC', 'Usuario', 'Kiosco', 3205417580, NULL),
(208547, 'CE', 'Usuario', 'Kiosco', 3521470956, NULL),
(208657, 'CC', 'Usuario', 'Kiosco', 3903507210, NULL),
(250859, 'CC', 'Usuario', 'Kiosco', 3603904155, NULL),
(555555, 'TI', 'Usuario', 'Kiosco', 355284800, NULL),
(624538, 'CC', 'Usuario', 'Kiosco', 3203604472, NULL),
(627458, 'CC', 'Usuario', 'Kiosco', 3213244157, NULL),
(775588, 'CC', 'Usuario', 'Kiosco', 5555666688, NULL),
(2507540, 'CC', 'Usuario', 'Kiosco', 3603207510, NULL),
(7777777, 'CC', 'pepito', 'Kiosco', 0, NULL),
(8051082, 'CC', 'Usuario', 'Kiosco', 3103207240, NULL),
(8888888, 'CC', 'Usuario', 'Kiosco', 5555555, NULL),
(10001000, 'CC', 'Carlos Coord', 'Administrador', 3001234567, NULL),
(10203040, 'CC', 'Ciudadano', 'Prueba', NULL, NULL),
(10534567, 'CC', 'sofia', 'chaustre', 3229767299, NULL),
(10925863, 'CC', 'Usuario', 'Kiosco', 3200000000, NULL),
(11111111, 'CC', 'lorena', 'perez', 1111111111, '1990-01-01 00:00:00'),
(11111114, 'CC', 'Usuario', 'Kiosco', 3603208521, NULL),
(11477552, 'CC', 'Usuario', 'Kiosco', 2574123987, NULL),
(12345678, 'CC', 'mauricio', 'Puentes', 3014523890, '1990-01-01 00:00:00'),
(12365478, 'CC', 'Usuario', 'Kiosco', 3333208888, NULL),
(12458706, 'CC', 'Usuario', 'Kiosco', 3652440628, NULL),
(13352217, 'CC', 'Usuario', 'Kiosco', 3015472380, NULL),
(14709632, 'CC', 'Usuario', 'Kiosco', 7455500312, NULL),
(20002000, 'CC', 'Ana Asesor', 'Servicio', 3109876543, NULL),
(20567120, 'CC', 'Usuario', 'Kiosco', 361320457, NULL),
(21478563, 'CC', 'Usuario', 'Kiosco', 8525555580, NULL),
(22115500, 'CC', 'Usuario', 'Kiosco', 3333333225, NULL),
(22208741, 'CC', 'Usuario', 'Kiosco', 3209631452, NULL),
(22211777, 'CC', 'Usuario', 'Kiosco', 2555536699, NULL),
(22214560, 'CC', 'Usuario', 'Kiosco', 7852453221, NULL),
(22222132, 'CC', 'Usuario', 'Kiosco', 444552, NULL),
(22222222, 'CC', 'alvaro', 'garcia', 3200085365, '1990-01-01 00:00:00'),
(22222258, 'CC', 'Usuario', 'Kiosco', 3208521456, NULL),
(22222550, 'CC', 'Usuario', 'Kiosco', 1456320856, NULL),
(22224400, 'CC', 'Usuario', 'Kiosco', 3684125580, NULL),
(22233908, 'CC', 'Usuario', 'Kiosco', 2580085258, NULL),
(22255803, 'CC', 'Usuario', 'Kiosco', 85214776, NULL),
(22580852, 'CC', 'Usuario', 'Kiosco', 6666688800, NULL),
(23658907, 'CC', 'Usuario', 'Kiosco', 3698520436, NULL),
(25075361, 'CC', 'Usuario', 'Kiosco', 3229614722, NULL),
(25888852, 'CC', 'Usuario', 'Kiosco', 523698425, NULL),
(28888888, 'CC', 'Usuario', 'Kiosco', 3200082408, NULL),
(30000003, 'CC', 'camila', 'vera', NULL, NULL),
(30645210, 'CC', 'Usuario', 'Kiosco', 3229741523, NULL),
(33221150, 'CC', 'Usuario', 'Kiosco', 3555588800, NULL),
(44448887, 'CC', 'Usuario', 'Kiosco', 3300441126, NULL),
(46312540, 'CC', 'Usuario', 'Kiosco', 3228054712, NULL),
(48025630, 'CC', 'Usuario', 'Kiosco', 3103504127, NULL),
(55555555, 'CC', 'Usuario', 'Kiosco', 5555555555, NULL),
(60253100, 'CC', 'sara', 'capacho', 3006410764, NULL),
(60321456, 'CC', 'Usuario', 'Kiosco', 3229615723, NULL),
(60356258, 'CE', 'Usuario', 'Kiosco', 3603207512, NULL),
(87654321, 'CC', 'Andres', 'General', NULL, '1990-01-01 00:00:00'),
(99908123, 'CC', 'Usuario', 'Kiosco', 1474147085, NULL),
(99999998, 'CC', 'Coordinador', 'APE SENA', NULL, NULL),
(111111111, 'CC', 'Usuario', 'Kiosco', 888888, NULL),
(111111180, 'CC', 'Usuario', 'Kiosco', 3333333330, NULL),
(114474444, 'CC', 'Usuario', 'Kiosco', 7414741477, NULL),
(120365584, 'CC', 'Usuario', 'Kiosco', 3222222222, NULL),
(123456789, 'CC', 'Test', 'User', 3000000000, NULL),
(147096325, 'CC', 'Usuario', 'Kiosco', 3222071463, NULL),
(147895320, 'CC', 'Usuario', 'Kiosco', 380350724, NULL),
(175809632, 'CC', 'Usuario', 'Kiosco', 3006410764, NULL),
(211145236, 'CC', 'Usuario', 'Kiosco', 2251111144, NULL),
(222111144, 'CC', 'Usuario', 'Kiosco', 2222225555, NULL),
(222220088, 'CC', 'Usuario', 'Kiosco', 3333333333, NULL),
(222223369, 'CC', 'Usuario', 'Kiosco', 855369498, NULL),
(222448855, 'CC', 'Usuario', 'Kiosco', 2222111133, NULL),
(222555444, 'CC', 'Usuario', 'Kiosco', 2221111444, NULL),
(245887136, 'CC', 'Usuario', 'Kiosco', 5800085889, NULL),
(300000000, 'NIT', 'Usuario', 'Kiosco', 3208443, NULL),
(333366699, 'CC', 'Usuario', 'Kiosco', 5555666556, NULL),
(333441122, 'CC', 'Usuario', 'Kiosco', 3806912548, NULL),
(333658809, 'CC', 'Usuario', 'Kiosco', 444555, NULL),
(444444444, 'CC', 'Usuario', 'Kiosco', 320587410, NULL),
(474123658, 'CC', 'Usuario', 'Kiosco', 9332541055, NULL),
(517896325, 'CC', 'Usuario', 'Kiosco', 3218890196, NULL),
(602334546, 'CC', 'Andres', 'Vargas', 3105418423, NULL),
(666666666, 'CC', 'Usuario', 'Kiosco', 3204874699, NULL),
(777777777, 'CE', 'Usuario', 'Kiosco', 360265417, NULL),
(1000000001, 'CC', 'Coordinador', 'Principal SENA', 3000000000, NULL),
(1005026715, 'CC', 'santiago', 'bayona', 3258479999, NULL),
(1062576432, 'CC', 'Usuario', 'Kiosco', 322715489, NULL),
(1092529985, 'CC', 'Usuario', 'Kiosco', 3269715423, NULL),
(1111111111, 'CC', 'Usuario', 'Kiosco', 3204195455, NULL),
(2222222222, 'CC', 'Usuario', 'Kiosco', 2222222222, NULL),
(2222222241, 'CC', 'Usuario', 'Kiosco', 3698520148, NULL),
(2224441178, 'CC', 'Usuario', 'Kiosco', 8885522399, NULL),
(5555555555, 'CC', 'Usuario', 'Kiosco', 3251470000, NULL),
(9000000001, 'CC', 'Coordinador', 'SENA APE', 3000000001, NULL),
(10125725412, 'CC', 'Usuario', 'Kiosco', 350321470, NULL),
(11111111111, 'CC', 'Usuario', 'Kiosco', 88888877, NULL),
(22222222222, 'CC', 'Usuario', 'Kiosco', 3502586384, NULL),
(77777777777, 'TI', 'Usuario', 'Kiosco', 8888888888, NULL),
(99999999999, 'CC', 'Usuario', 'Kiosco', 7777777777, NULL),
(111111111111, 'CC', 'Usuario', 'Kiosco', 0, NULL),
(128888800000, 'CC', 'Usuario', 'Kiosco', 1426354780, NULL),
(145225880000, 'CC', 'Usuario', 'Kiosco', 1745800000, NULL),
(150000000000, 'CC', 'Usuario', 'Kiosco', 1600000000, NULL),
(222222222222, 'CC', 'Usuario', 'Kiosco', 3333333333, NULL),
(555555555555, 'CC', 'Usuario', 'Kiosco', 3503207251, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1plfX3LCHEBNFJUWhArc0X70BGSmlR7btQtX2lgc', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVGdYcTR0aWMxbENqUkZXSDU4elN4SzJENUFjOTM4ckJVT1VqWW52RSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTQ6Imh0dHA6Ly9sb2NhbGhvc3QvUHJveWVjdG8tZGlnaXR1cm5vLW1haW4vcHVibGljL2FzZXNvciI7czo1OiJyb3V0ZSI7czoxMjoiYXNlc29yLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778686777),
('58Rjm4J3edttzWrjnqQsdH3et68CYacY4lYmZVcr', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibXdiTW1Ld1FsM3h4N3ZiZkZNZjYyc2JvcVRDcFJTTjBlNzFMelFBMCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7czoxMjoia2lvc2NvLmluZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1777582142);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitante`
--

CREATE TABLE `solicitante` (
  `sol_id` int(11) NOT NULL,
  `sol_tipo` varchar(45) DEFAULT NULL,
  `PERSONA_pers_doc` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitante`
--

INSERT INTO `solicitante` (`sol_id`, `sol_tipo`, `PERSONA_pers_doc`) VALUES
(1, 'Externo', 1092529985),
(2, 'Externo', 2222222222),
(3, 'Externo', 55555555),
(4, 'Externo', 8888888),
(5, 'Externo', 666666666),
(6, 'General', 123),
(7, 'Externo', 7777777),
(8, 'Externo', 1062576432),
(9, 'Externo', 123456789),
(10, 'Externo', 555555),
(11, NULL, 300000000),
(12, 'Externo', 120365584),
(13, 'Externo', 111111111111),
(14, 'Externo', 0),
(15, 'Externo', 444444444),
(16, 'Externo', 99999999999),
(17, 'Externo', 111111111),
(18, 'Externo', 10125725412),
(19, 'Externo', 60321456),
(20, 'Externo', 20567120),
(21, 'Externo', 11111111111),
(22, 'Externo', 777777777),
(23, 'Externo', 77777777777),
(24, 'Externo', 147895320),
(25, 'Prioritario', 186342),
(26, 'Empresario', 205741),
(27, 'Prioritario', 2507540),
(28, 'General', 208657),
(29, 'Prioritario', 8051082),
(30, 'Victima', 208547),
(31, 'Prioritario', 28888888),
(32, 'General', 222222222222),
(33, 'Victima', 22222222222),
(34, 'Prioritario', 22222222),
(35, 'Prioritario', 555555555555),
(36, NULL, 10203040),
(37, 'Victima', 60356258),
(38, 'Prioritario', 627458),
(39, 'General', 624538),
(40, 'Victima', 250859),
(41, 'Prioritario', 1005026715),
(42, 'General', 145225880000),
(43, 'General', 150000000000),
(44, 'Prioritario', 128888800000),
(45, 'Victima', 5555555555),
(46, 'General', 175809632),
(47, 'Empresario', 517896325),
(48, 'Prioritario', 11111111),
(49, 'Prioritario', 25075361),
(50, 'Prioritario', 1111111111),
(51, 'Victima', 211145236),
(52, 'General', 48025630),
(53, 'Prioritario', 30645210),
(54, 'General', 46312540),
(55, 'Prioritario', 13352217),
(56, 'Prioritario', 12458706),
(57, 'Prioritario', 245887136),
(58, 'Victima', 474123658),
(59, 'Prioritario', 22255803),
(60, 'Victima', 22214560),
(61, 'Empresario', 22233908),
(62, 'Victima', 333658809),
(63, 'Victima', 222448855),
(64, 'Victima', 11477552),
(65, 'Victima', 333366699),
(66, 'Victima', 2224441178),
(67, 'Prioritario', 22208741),
(68, 'Victima', 222111144),
(69, 'Prioritario', 23658907),
(70, 'Prioritario', 222220088),
(71, 'Prioritario', 222555444),
(72, 'Victima', 22211777),
(73, 'Prioritario', 2222222241),
(74, 'Prioritario', 22580852),
(75, 'Prioritario', 114474444),
(76, 'Empresario', 25888852),
(77, 'Prioritario', 222223369),
(78, 'Victima', 21478563),
(79, 'Prioritario', 11111114),
(80, 'Prioritario', 22222258),
(81, 'Victima', 10925863),
(82, 'Empresario', 333441122),
(83, 'Prioritario', 111111180),
(84, 'General', 147096325),
(85, 'Prioritario', 99908123),
(86, 'Victima', 33221150),
(87, 'Empresario', 22222132),
(88, 'Empresario', 14709632),
(89, 'Empresario', 44448887),
(90, 'Victima', 22222550),
(91, 'Prioritario', 12365478),
(92, 'Prioritario', 22224400),
(93, 'Prioritario', 22115500),
(94, 'Victima', 775588);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `tur_id` int(11) NOT NULL,
  `tur_estado` enum('Espera','Atendiendo','Finalizado','Ausente') NOT NULL DEFAULT 'Espera',
  `tur_hora_fecha` datetime DEFAULT NULL,
  `tur_hora_llamado` datetime DEFAULT NULL COMMENT 'Timestamp cuando el asesor llama al turno (CU-02)',
  `tur_numero` varchar(45) DEFAULT NULL,
  `tur_tipo` enum('General','Prioritario','Victimas') NOT NULL,
  `tur_perfil` enum('General','Víctima','Prioritario','Empresario') NOT NULL DEFAULT 'General',
  `tur_tipo_atencion` enum('Normal','Especial') NOT NULL DEFAULT 'Normal',
  `tur_servicio` enum('Orientación','Formación','Emprendimiento') NOT NULL DEFAULT 'Orientación',
  `tur_telefono` varchar(20) DEFAULT NULL,
  `SOLICITANTE_sol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turno`
--

INSERT INTO `turno` (`tur_id`, `tur_estado`, `tur_hora_fecha`, `tur_hora_llamado`, `tur_numero`, `tur_tipo`, `tur_perfil`, `tur_tipo_atencion`, `tur_servicio`, `tur_telefono`, `SOLICITANTE_sol_id`) VALUES
(7, 'Finalizado', '2026-05-04 22:33:40', '2026-05-04 22:33:52', 'V-001', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 45),
(8, 'Finalizado', '2026-05-05 15:43:37', '2026-05-05 16:18:09', 'G-001', 'General', 'General', 'Especial', 'Orientación', NULL, 46),
(9, 'Finalizado', '2026-05-06 13:57:57', '2026-05-06 14:32:03', 'E-001', 'Prioritario', 'Empresario', 'Especial', 'Formación', NULL, 47),
(10, 'Finalizado', '2026-05-06 14:03:09', '2026-05-06 14:03:34', 'P-001', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 48),
(11, 'Ausente', '2026-05-06 14:42:42', '2026-05-06 14:42:48', 'P-002', 'Prioritario', 'Prioritario', 'Normal', 'Formación', NULL, 1),
(12, 'Finalizado', '2026-05-06 14:59:47', '2026-05-06 15:08:14', 'P-003', 'Prioritario', 'Prioritario', 'Especial', 'Orientación', NULL, 3),
(13, 'Finalizado', '2026-05-07 14:44:06', '2026-05-07 14:44:29', 'P-001', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 49),
(14, 'Finalizado', '2026-05-07 16:42:20', '2026-05-07 16:42:41', 'P-002', 'Prioritario', 'Prioritario', 'Especial', 'Orientación', NULL, 50),
(15, 'Finalizado', '2026-05-07 16:46:11', '2026-05-07 16:47:34', 'P-003', 'Prioritario', 'Prioritario', 'Especial', 'Orientación', NULL, 2),
(16, 'Ausente', '2026-05-11 13:40:00', '2026-05-11 13:40:19', 'V-001', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 34),
(17, 'Ausente', '2026-05-11 15:23:08', '2026-05-11 15:23:14', 'V-002', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 51),
(18, 'Finalizado', '2026-05-11 20:58:55', '2026-05-11 20:59:23', 'G-001', 'General', 'General', 'Normal', 'Orientación', NULL, 52),
(19, 'Finalizado', '2026-05-11 21:55:41', '2026-05-11 21:55:53', 'P-001', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 53),
(20, 'Finalizado', '2026-05-11 21:59:46', '2026-05-11 18:10:12', 'G-002', 'General', 'General', 'Normal', 'Orientación', NULL, 54),
(21, 'Ausente', '2026-05-11 22:02:30', '2026-05-11 22:13:40', 'P-002', 'Prioritario', 'Prioritario', 'Normal', 'Formación', NULL, 55),
(22, 'Ausente', '2026-05-11 22:06:08', '2026-05-11 17:27:56', 'P-003', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 56),
(23, 'Finalizado', '2026-05-11 22:06:45', '2026-05-11 18:09:43', 'P-004', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 57),
(24, 'Finalizado', '2026-05-11 22:08:27', '2026-05-11 22:10:30', 'V-003', 'Victimas', 'Víctima', 'Especial', 'Orientación', NULL, 58),
(25, 'Finalizado', '2026-05-11 22:10:07', '2026-05-11 18:10:04', 'P-005', 'Prioritario', 'Prioritario', 'Especial', 'Formación', NULL, 59),
(26, 'Ausente', '2026-05-11 22:19:36', '2026-05-11 17:27:40', 'V-004', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 60),
(27, 'Ausente', '2026-05-11 22:21:29', '2026-05-11 17:27:50', 'E-001', 'Prioritario', 'Empresario', 'Normal', 'Orientación', NULL, 61),
(28, 'Finalizado', '2026-05-11 17:29:04', '2026-05-11 17:39:07', 'V-005', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 62),
(29, 'Finalizado', '2026-05-11 17:37:09', '2026-05-11 17:43:05', 'V-006', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 63),
(30, 'Finalizado', '2026-05-11 17:38:08', '2026-05-11 18:07:49', 'V-007', 'Victimas', 'Víctima', 'Normal', 'Formación', NULL, 64),
(31, 'Finalizado', '2026-05-11 17:40:46', '2026-05-11 18:08:06', 'V-008', 'Victimas', 'Víctima', 'Especial', 'Formación', NULL, 65),
(32, 'Ausente', '2026-05-11 18:06:24', '2026-05-11 18:08:34', 'V-009', 'Victimas', 'Víctima', 'Especial', 'Orientación', NULL, 66),
(33, 'Ausente', '2026-05-12 10:49:10', '2026-05-12 10:49:25', 'P-001', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 67),
(34, 'Finalizado', '2026-05-12 10:53:21', '2026-05-12 10:53:33', 'V-001', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 68),
(35, 'Finalizado', '2026-05-12 11:03:37', '2026-05-12 11:03:44', 'P-002', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 69),
(36, 'Ausente', '2026-05-13 07:54:03', '2026-05-13 07:56:56', 'P-001', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 70),
(37, 'Ausente', '2026-05-13 08:08:31', '2026-05-13 08:08:56', 'P-002', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 71),
(38, 'Ausente', '2026-05-13 08:13:29', '2026-05-13 08:13:46', 'V-001', 'Victimas', 'Víctima', 'Especial', 'Orientación', NULL, 72),
(39, 'Ausente', '2026-05-13 08:45:28', '2026-05-13 08:45:53', 'P-003', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 73),
(40, 'Ausente', '2026-05-13 08:51:39', '2026-05-13 08:52:03', 'P-004', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 74),
(41, 'Ausente', '2026-05-13 08:53:44', '2026-05-13 08:53:50', 'P-005', 'Prioritario', 'Prioritario', 'Especial', 'Formación', NULL, 75),
(42, 'Ausente', '2026-05-13 08:55:45', '2026-05-13 08:55:59', 'E-001', 'Prioritario', 'Empresario', 'Especial', 'Orientación', NULL, 76),
(43, 'Ausente', '2026-05-13 09:14:49', '2026-05-13 09:15:08', 'P-006', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 77),
(44, 'Ausente', '2026-05-13 09:41:39', '2026-05-13 09:41:54', 'V-002', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 78),
(45, 'Ausente', '2026-05-13 09:46:57', '2026-05-13 09:47:26', 'P-007', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 79),
(46, 'Ausente', '2026-05-13 10:31:34', '2026-05-13 10:31:51', 'P-008', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 80),
(47, 'Ausente', '2026-05-13 10:32:46', '2026-05-13 10:38:28', 'V-003', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 81),
(48, 'Ausente', '2026-05-13 10:33:49', '2026-05-13 10:39:44', 'E-002', 'Prioritario', 'Empresario', 'Normal', 'Orientación', NULL, 82),
(49, 'Finalizado', '2026-05-13 10:34:58', '2026-05-13 10:40:11', 'P-009', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 83),
(50, 'Ausente', '2026-05-13 10:51:18', '2026-05-13 11:08:07', 'G-001', 'General', 'General', 'Normal', 'Orientación', NULL, 84),
(51, 'Atendiendo', '2026-05-13 10:51:46', '2026-05-13 11:12:38', 'P-010', 'Prioritario', 'Prioritario', 'Especial', 'Formación', NULL, 85),
(52, 'Espera', '2026-05-13 10:52:47', NULL, 'V-004', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 86),
(53, 'Finalizado', '2026-05-13 11:05:11', '2026-05-13 11:06:55', 'E-003', 'Prioritario', 'Empresario', 'Normal', 'Orientación', NULL, 87),
(54, 'Ausente', '2026-05-13 11:05:47', '2026-05-13 11:07:31', 'E-004', 'Prioritario', 'Empresario', 'Especial', 'Orientación', NULL, 88),
(55, 'Finalizado', '2026-05-13 11:06:17', '2026-05-13 11:07:46', 'E-005', 'Prioritario', 'Empresario', 'Normal', 'Emprendimiento', NULL, 89),
(56, 'Finalizado', '2026-05-15 09:29:27', '2026-05-15 09:29:41', 'V-001', 'Victimas', 'Víctima', 'Normal', 'Orientación', NULL, 90),
(57, 'Atendiendo', '2026-05-15 09:33:16', '2026-05-15 09:34:19', 'P-001', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 91),
(58, 'Ausente', '2026-05-15 09:35:24', '2026-05-15 10:29:01', 'P-002', 'Prioritario', 'Prioritario', 'Normal', 'Formación', NULL, 92),
(59, 'Ausente', '2026-05-15 10:28:18', '2026-05-15 10:30:31', 'P-003', 'Prioritario', 'Prioritario', 'Normal', 'Orientación', NULL, 93),
(60, 'Ausente', '2026-05-15 10:32:59', '2026-05-15 10:43:26', 'V-002', 'Victimas', 'Víctima', 'Especial', 'Orientación', NULL, 94);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_estado_actual_asesores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_estado_actual_asesores` (
`modulo` int(11)
,`asesor` varchar(201)
,`estado` varchar(10)
,`minutos_en_receso_actual` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_resumen_pausas_hoy`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_resumen_pausas_hoy` (
`modulo` int(11)
,`asesor` varchar(201)
,`total_pausas` bigint(21)
,`minutos_totales` decimal(32,0)
,`ultimo_receso` datetime
);

-- --------------------------------------------------------

--
-- Estructura para la vista `view_estado_actual_asesores`
--
DROP TABLE IF EXISTS `view_estado_actual_asesores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_estado_actual_asesores`  AS SELECT `a`.`ase_id` AS `modulo`, concat(`p`.`pers_nombres`,' ',`p`.`pers_apellidos`) AS `asesor`, CASE WHEN exists(select 1 from `pausas_asesor` where `pausas_asesor`.`ASESOR_ase_id` = `a`.`ase_id` AND `pausas_asesor`.`hora_fin` is null limit 1) THEN 'EN RECESO' WHEN exists(select 1 from `atencion` where `atencion`.`ASESOR_ase_id` = `a`.`ase_id` AND `atencion`.`atnc_hora_fin` is null limit 1) THEN 'ATENDIENDO' ELSE 'DISPONIBLE' END AS `estado`, (select timestampdiff(MINUTE,`pausas_asesor`.`hora_inicio`,current_timestamp()) from `pausas_asesor` where `pausas_asesor`.`ASESOR_ase_id` = `a`.`ase_id` and `pausas_asesor`.`hora_fin` is null limit 1) AS `minutos_en_receso_actual` FROM (`asesor` `a` join `persona` `p` on(`a`.`PERSONA_pers_doc` = `p`.`pers_doc`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_resumen_pausas_hoy`
--
DROP TABLE IF EXISTS `view_resumen_pausas_hoy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_resumen_pausas_hoy`  AS SELECT `a`.`ase_id` AS `modulo`, concat(`p`.`pers_nombres`,' ',`p`.`pers_apellidos`) AS `asesor`, count(`pa`.`id`) AS `total_pausas`, sum(coalesce(`pa`.`duracion`,0)) AS `minutos_totales`, max(`pa`.`hora_inicio`) AS `ultimo_receso` FROM ((`asesor` `a` join `persona` `p` on(`a`.`PERSONA_pers_doc` = `p`.`pers_doc`)) left join `pausas_asesor` `pa` on(`a`.`ase_id` = `pa`.`ASESOR_ase_id` and cast(`pa`.`hora_inicio` as date) = curdate())) GROUP BY `a`.`ase_id`, `p`.`pers_nombres`, `p`.`pers_apellidos` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD PRIMARY KEY (`ase_id`),
  ADD KEY `PERSONA_pers_doc` (`PERSONA_pers_doc`);

--
-- Indices de la tabla `atencion`
--
ALTER TABLE `atencion`
  ADD PRIMARY KEY (`atnc_id`),
  ADD KEY `ASESOR_ase_id` (`ASESOR_ase_id`),
  ADD KEY `TURNO_tur_id` (`TURNO_tur_id`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `configuracion_sistema`
--
ALTER TABLE `configuracion_sistema`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `configuracion_sistema_clave_unique` (`clave`);

--
-- Indices de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD PRIMARY KEY (`coor_id`),
  ADD KEY `PERSONA_pers_doc` (`PERSONA_pers_doc`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `pausas_asesor`
--
ALTER TABLE `pausas_asesor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`pers_doc`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `solicitante`
--
ALTER TABLE `solicitante`
  ADD PRIMARY KEY (`sol_id`),
  ADD KEY `PERSONA_pers_doc` (`PERSONA_pers_doc`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`tur_id`),
  ADD KEY `SOLICITANTE_sol_id` (`SOLICITANTE_sol_id`),
  ADD KEY `turno_tur_perfil_index` (`tur_perfil`),
  ADD KEY `turno_tur_estado_index` (`tur_estado`),
  ADD KEY `turno_tur_hora_fecha_index` (`tur_hora_fecha`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asesor`
--
ALTER TABLE `asesor`
  MODIFY `ase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `atencion`
--
ALTER TABLE `atencion`
  MODIFY `atnc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `configuracion_sistema`
--
ALTER TABLE `configuracion_sistema`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  MODIFY `coor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `pausas_asesor`
--
ALTER TABLE `pausas_asesor`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `solicitante`
--
ALTER TABLE `solicitante`
  MODIFY `sol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `tur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD CONSTRAINT `asesor_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`);

--
-- Filtros para la tabla `atencion`
--
ALTER TABLE `atencion`
  ADD CONSTRAINT `atencion_ibfk_1` FOREIGN KEY (`ASESOR_ase_id`) REFERENCES `asesor` (`ase_id`),
  ADD CONSTRAINT `atencion_ibfk_2` FOREIGN KEY (`TURNO_tur_id`) REFERENCES `turno` (`tur_id`);

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`);

--
-- Filtros para la tabla `solicitante`
--
ALTER TABLE `solicitante`
  ADD CONSTRAINT `solicitante_ibfk_1` FOREIGN KEY (`PERSONA_pers_doc`) REFERENCES `persona` (`pers_doc`);

--
-- Filtros para la tabla `turno`
--
ALTER TABLE `turno`
  ADD CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`SOLICITANTE_sol_id`) REFERENCES `solicitante` (`sol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
