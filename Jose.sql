-- phpMyAdmin SQL Dump

-- 
-- Base de datos: `club nautico`
-- 

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `amarre`
-- 

CREATE TABLE `amarre` (
  `numero` int(11) NOT NULL,
  `agua` float NOT NULL,
  `luz` float NOT NULL,
  `mantenimiento` varchar(50) NOT NULL,
  `propietario` varchar(15) NOT NULL,
  `fechacompra` date NOT NULL,
  `zonaamarre` varchar(3) NOT NULL,
  PRIMARY KEY  (`numero`),
  KEY `propietario` (`propietario`),
  KEY `zonaamarre` (`zonaamarre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Volcar la base de datos para la tabla `amarre`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `asignaciones`
-- 

CREATE TABLA `asignaciones` (
  `codempleado` varchar(50) NOT NULL,
  `letrazona` varchar(3) NOT NULL,
  `numbarcosasign` int(11) NOT NULL,
  PRIMARY KEY  (`codempleado`,`letrazona`),
  KEY `codempleado` (`codempleado`),
  KEY `letrazona` (`letrazona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Volcar la base de datos para la tabla `asignaciones`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `embarcacion`
-- 

CREATE TABLE `embarcacion` (
  `matricula` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `dimensiones` float NOT NULL,
  `propietario` varchar(15) NOT NULL,
  `numeroamarre` int(11) NOT NULL,
  `fechaamarre` date NOT NULL,
  PRIMARY KEY  (`matricula`),
  KEY `propietario` (`propietario`,`numeroamarre`),
  KEY `numeroamarre` (`numeroamarre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Volcar la base de datos para la tabla `embarcacion`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `empleados`
-- 

CREATE TABLE `empleados` (
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `especialidad` varchar(50) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Volcar la base de datos para la tabla `empleados`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `socio`
-- 

CREATE TABLE `socio` (
  `nombre` varchar(100) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` int(11) NOT NULL,
  `fechaingreso` date NOT NULL,
  PRIMARY KEY  (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Volcar la base de datos para la tabla `socio`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `zona`
-- 

CREATE TABLE `zona` (
  `letra` varchar(3) NOT NULL,
  `tipobarcos` varchar(10) NOT NULL,
  `numerobarcos` int(11) NOT NULL,
  `profundidad` float NOT NULL,
  `ancho` float NOT NULL,
  PRIMARY KEY  (`letra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Volcar la base de datos para la tabla `zona`
-- 


-- 
-- Filtros para las tablas descargadas (dump)
-- 

-- 
-- Filtros para la tabla `amarre`
-- 
ALTER TABLE `amarre`
  ADD CONSTRAINT `amarre_ibfk_1` FOREIGN KEI (`propietario`) REFERENCES `socio` (`dni`),
  ADD CONSTRAINT `amarre_ibfk_2` FOREIGN KEY (`zonaamarre`) REFERENCES `zona` (`letra`);

-- 
-- Filtros para la tabla `asignaciones`
-- 
ALTER TABLE `asignaciones`
  ADD CONSTRAINT `asignaciones_ibfk_2` FOREIGN KEY (`letrazona`) REFERENCES `zona` (`letra`),
  ADD CONSTRAINT `asignaciones_ibfk_1` FOREIGN KEY (`codempleado`) REFERENCES `empleados` (`codigo`);

-- 
-- Filtros para la tabla `embarcacion`
-- 
ALTER TABLE `embarcacion`
  ADD CONSTRAINT `embarcacion_ibfk_1` FOREIGN KEY (`propietario`) REFERENCES `socio` (`dni`),
  ADD CONSTRAINT `embarcacion_ibfk_2` FOREIGN KEY (`numeroamarre`) REFERENCES `amarre` (`numero`);
