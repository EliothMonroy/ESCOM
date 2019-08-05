-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema NetBlim
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NetBlim
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NetBlim` DEFAULT CHARACTER SET utf8 ;
USE `NetBlim` ;

-- -----------------------------------------------------
-- Table `NetBlim`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `estado` TINYINT(1) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `contra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Login` (
  `idLogin` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idLogin`),
  INDEX `fk_Login_Usuario_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Login_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `NetBlim`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Plan` (
  `idPlan` INT NOT NULL AUTO_INCREMENT,
  `max_dispo` INT NOT NULL,
  `costo` FLOAT NOT NULL,
  `metodo_pago` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlan`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Cliente` (
  `Usuario_idUsuario` INT NOT NULL,
  `saldo` FLOAT NOT NULL,
  `activos` INT NOT NULL,
  `Plan_idPlan` INT NOT NULL,
  INDEX `fk_Cliente_Plan1_idx` (`Plan_idPlan` ASC),
  PRIMARY KEY (`Usuario_idUsuario`),
  CONSTRAINT `fk_Cliente_Plan1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `NetBlim`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `NetBlim`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Trabajador` (
  `Usuario_idUsuario` INT NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `tipo` INT NOT NULL,
  INDEX `fk_Trabajador_Usuario1_idx` (`Usuario_idUsuario` ASC),
  PRIMARY KEY (`Usuario_idUsuario`),
  CONSTRAINT `fk_Trabajador_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `NetBlim`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Ganancia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Ganancia` (
  `idGanancia` INT NOT NULL AUTO_INCREMENT,
  `monto` FLOAT NOT NULL,
  `fecha` DATE NOT NULL,
  `Plan_idPlan` INT NOT NULL,
  PRIMARY KEY (`idGanancia`),
  INDEX `fk_Ganancia_Plan1_idx` (`Plan_idPlan` ASC),
  CONSTRAINT `fk_Ganancia_Plan1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `NetBlim`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Trabajador_has_Ganancia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Trabajador_has_Ganancia` (
  `Ganancia_idGanancia` INT NOT NULL,
  `Trabajador_Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`Ganancia_idGanancia`, `Trabajador_Usuario_idUsuario`),
  INDEX `fk_Trabajador_has_Ganancia_Ganancia1_idx` (`Ganancia_idGanancia` ASC),
  INDEX `fk_Trabajador_has_Ganancia_Trabajador1_idx` (`Trabajador_Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Trabajador_has_Ganancia_Ganancia1`
    FOREIGN KEY (`Ganancia_idGanancia`)
    REFERENCES `NetBlim`.`Ganancia` (`idGanancia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabajador_has_Ganancia_Trabajador1`
    FOREIGN KEY (`Trabajador_Usuario_idUsuario`)
    REFERENCES `NetBlim`.`Trabajador` (`Usuario_idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Genero` (
  `idGenero` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Clasificación`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Clasificación` (
  `idClasificación` INT NOT NULL AUTO_INCREMENT,
  `ctr_parental` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idClasificación`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Peli_serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Peli_serie` (
  `idPeli_serie` INT NOT NULL AUTO_INCREMENT,
  `valoracion` FLOAT NOT NULL DEFAULT 5.0,
  `nombre` VARCHAR(60) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `estado` TINYINT(1) NOT NULL,
  `anio` VARCHAR(4) NOT NULL,
  `url_imagen` VARCHAR(120) NOT NULL,
  `Descripcion` VARCHAR(500) NOT NULL,
  `Genero_idGenero` INT NOT NULL,
  `Clasificación_idClasificación` INT NOT NULL,
  `Trabajador_Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPeli_serie`),
  INDEX `fk_Peli_serie_Genero1_idx` (`Genero_idGenero` ASC),
  INDEX `fk_Peli_serie_Clasificación1_idx` (`Clasificación_idClasificación` ASC),
  INDEX `fk_Peli_serie_Trabajador1_idx` (`Trabajador_Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Peli_serie_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `NetBlim`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peli_serie_Clasificación1`
    FOREIGN KEY (`Clasificación_idClasificación`)
    REFERENCES `NetBlim`.`Clasificación` (`idClasificación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peli_serie_Trabajador1`
    FOREIGN KEY (`Trabajador_Usuario_idUsuario`)
    REFERENCES `NetBlim`.`Trabajador` (`Usuario_idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Dire_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Dire_actor` (
  `idDire_actor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo` INT NOT NULL,
  PRIMARY KEY (`idDire_actor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Perfil` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `url_imagen` VARCHAR(120) NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `ctr_parental` TINYINT(1) NOT NULL,
  `Cliente_Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPerfil`),
  INDEX `fk_Perfil_Cliente1_idx` (`Cliente_Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Perfil_Cliente1`
    FOREIGN KEY (`Cliente_Usuario_idUsuario`)
    REFERENCES `NetBlim`.`Cliente` (`Usuario_idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Peli_serie_has_Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Peli_serie_has_Perfil` (
  `Perfil_idPerfil` INT NOT NULL,
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`Perfil_idPerfil`, `Peli_serie_idPeli_serie`),
  INDEX `fk_Peli-serie_has_Perfil_Perfil1_idx` (`Perfil_idPerfil` ASC),
  INDEX `fk_Peli_serie_has_Perfil_Peli_serie1_idx` (`Peli_serie_idPeli_serie` ASC),
  CONSTRAINT `fk_Peli-serie_has_Perfil_Perfil1`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `NetBlim`.`Perfil` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peli_serie_has_Perfil_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Actividad` (
  `idActividad` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `Perfil_idPerfil` INT NOT NULL,
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`idActividad`),
  INDEX `fk_Actividad_Perfil1_idx` (`Perfil_idPerfil` ASC),
  INDEX `fk_Actividad_Peli_serie1_idx` (`Peli_serie_idPeli_serie` ASC),
  CONSTRAINT `fk_Actividad_Perfil1`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `NetBlim`.`Perfil` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Idioma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Idioma` (
  `idIdioma` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIdioma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Subtitulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Subtitulo` (
  `idSubtitulo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSubtitulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Pelicula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Pelicula` (
  `duracion` INT NOT NULL,
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`Peli_serie_idPeli_serie`),
  CONSTRAINT `fk_Pelicula_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Serie` (
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`Peli_serie_idPeli_serie`),
  INDEX `fk_Serie_Peli_serie1_idx` (`Peli_serie_idPeli_serie` ASC),
  CONSTRAINT `fk_Serie_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Temporada` (
  `idTemporada` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `Serie_Peli_serie_idPeli_serie` INT NOT NULL,
  `Serie_Peli_serie_idPeli_serie1` INT NOT NULL,
  PRIMARY KEY (`idTemporada`),
  INDEX `fk_Temporada_Serie1_idx` (`Serie_Peli_serie_idPeli_serie1` ASC),
  CONSTRAINT `fk_Temporada_Serie1`
    FOREIGN KEY (`Serie_Peli_serie_idPeli_serie1`)
    REFERENCES `NetBlim`.`Serie` (`Peli_serie_idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Capitulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Capitulo` (
  `idCapitulo` INT NOT NULL,
  `duracion` INT NOT NULL,
  `Capitulo_idCapitulo` INT NOT NULL,
  `sinopsis` VARCHAR(500) NOT NULL,
  `Temporada_idTemporada` INT NOT NULL,
  PRIMARY KEY (`idCapitulo`, `Capitulo_idCapitulo`),
  INDEX `fk_Capitulo_Capitulo1_idx` (`Capitulo_idCapitulo` ASC),
  INDEX `fk_Capitulo_Temporada1_idx` (`Temporada_idTemporada` ASC),
  CONSTRAINT `fk_Capitulo_Capitulo1`
    FOREIGN KEY (`Capitulo_idCapitulo`)
    REFERENCES `NetBlim`.`Capitulo` (`idCapitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Capitulo_Temporada1`
    FOREIGN KEY (`Temporada_idTemporada`)
    REFERENCES `NetBlim`.`Temporada` (`idTemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Subtitulo_has_Peli_serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Subtitulo_has_Peli_serie` (
  `Subtitulo_idSubtitulo` INT NOT NULL,
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`Subtitulo_idSubtitulo`, `Peli_serie_idPeli_serie`),
  INDEX `fk_Subtitulo_has_Peli_serie_Peli_serie1_idx` (`Peli_serie_idPeli_serie` ASC),
  INDEX `fk_Subtitulo_has_Peli_serie_Subtitulo1_idx` (`Subtitulo_idSubtitulo` ASC),
  CONSTRAINT `fk_Subtitulo_has_Peli_serie_Subtitulo1`
    FOREIGN KEY (`Subtitulo_idSubtitulo`)
    REFERENCES `NetBlim`.`Subtitulo` (`idSubtitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subtitulo_has_Peli_serie_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Idioma_has_Peli_serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Idioma_has_Peli_serie` (
  `Idioma_idIdioma` INT NOT NULL,
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`Idioma_idIdioma`, `Peli_serie_idPeli_serie`),
  INDEX `fk_Idioma_has_Peli_serie_Peli_serie1_idx` (`Peli_serie_idPeli_serie` ASC),
  INDEX `fk_Idioma_has_Peli_serie_Idioma1_idx` (`Idioma_idIdioma` ASC),
  CONSTRAINT `fk_Idioma_has_Peli_serie_Idioma1`
    FOREIGN KEY (`Idioma_idIdioma`)
    REFERENCES `NetBlim`.`Idioma` (`idIdioma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Idioma_has_Peli_serie_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NetBlim`.`Dire_actor_has_Peli_serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NetBlim`.`Dire_actor_has_Peli_serie` (
  `Dire_actor_idDire_actor` INT NOT NULL,
  `Peli_serie_idPeli_serie` INT NOT NULL,
  PRIMARY KEY (`Dire_actor_idDire_actor`, `Peli_serie_idPeli_serie`),
  INDEX `fk_Dire_actor_has_Peli_serie_Peli_serie1_idx` (`Peli_serie_idPeli_serie` ASC),
  INDEX `fk_Dire_actor_has_Peli_serie_Dire_actor1_idx` (`Dire_actor_idDire_actor` ASC),
  CONSTRAINT `fk_Dire_actor_has_Peli_serie_Dire_actor1`
    FOREIGN KEY (`Dire_actor_idDire_actor`)
    REFERENCES `NetBlim`.`Dire_actor` (`idDire_actor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dire_actor_has_Peli_serie_Peli_serie1`
    FOREIGN KEY (`Peli_serie_idPeli_serie`)
    REFERENCES `NetBlim`.`Peli_serie` (`idPeli_serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
