CREATE SCHEMA IF NOT EXISTS `SAES` DEFAULT CHARACTER SET utf8 ;
USE `SAES` ;

-- -----------------------------------------------------
-- Table `SAES`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Paterno` VARCHAR(50) NOT NULL,
  `Materno` VARCHAR(50) NOT NULL,
  `Mail` VARCHAR(50) NOT NULL,
  `Contra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Alumno` (
  `Boleta` VARCHAR(10) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Boleta`),
  INDEX `fk_Alumno_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Alumno_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `SAES`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Profesor` (
  `RFC` VARCHAR(13) NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  `Paterno` VARCHAR(50) NOT NULL,
  `Materno` VARCHAR(50) NOT NULL,
  `Numempleado` VARCHAR(10) NOT NULL,
  `Mail` VARCHAR(50) NOT NULL,
  `Contra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RFC`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Academico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Academico` (
  `RFC` VARCHAR(13) NOT NULL,
  `Numempleado` VARCHAR(10) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`RFC`),
  INDEX `fk_Academico_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Academico_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `SAES`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Gestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Gestion` (
  `RFC` VARCHAR(13) NOT NULL,
  `Numempleado` VARCHAR(10) NOT NULL,
  `Nivel` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`RFC`),
  INDEX `fk_Gestion_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Gestion_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `SAES`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Area_Materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Area_Materias` (
  `idArea_Materias` INT NOT NULL,
  `Nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idArea_Materias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Materias` (
  `idMaterias` VARCHAR(4) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Creditos` FLOAT NOT NULL,
  `Nivel` INT NOT NULL,
  `Cupo` INT NOT NULL,
  `Area_Materias_idArea_Materias` INT NOT NULL,
  `Materia_anterior` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`idMaterias`),
  INDEX `fk_Materias_Area_Materias_idx` (`Area_Materias_idArea_Materias` ASC),
  INDEX `fk_Materias_Materias1_idx` (`Materia_anterior` ASC),
  CONSTRAINT `fk_Materias_Area_Materias`
    FOREIGN KEY (`Area_Materias_idArea_Materias`)
    REFERENCES `SAES`.`Area_Materias` (`idArea_Materias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Materias_Materias1`
    FOREIGN KEY (`Materia_anterior`)
    REFERENCES `SAES`.`Materias` (`idMaterias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Horas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Horas` (
  `idHorario` INT NOT NULL,
  `Dia` VARCHAR(45) NOT NULL,
  `Hora` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idHorario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Grupo` (
  `idGrupo` INT NOT NULL,
  `Turno` VARCHAR(45) NOT NULL,
  `Nivel` INT NOT NULL,
  `Numero` INT NOT NULL,
  PRIMARY KEY (`idGrupo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Tipo_Horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Tipo_Horario` (
  `idTipo_Horario` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`idTipo_Horario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Clase` (
  `idClase` INT NOT NULL AUTO_INCREMENT,
  `Grupo_idGrupo` INT NOT NULL,
  `Materias_idMaterias` VARCHAR(4) NOT NULL,
  `Profesor_RFC` VARCHAR(13) NOT NULL,
  `Tipo_Horario_idTipo_Horario` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`idClase`),
  INDEX `fk_Clase_Grupo1_idx` (`Grupo_idGrupo` ASC),
  INDEX `fk_Clase_Materias1_idx` (`Materias_idMaterias` ASC),
  INDEX `fk_Clase_Profesor1_idx` (`Profesor_RFC` ASC),
  INDEX `fk_Clase_Tipo_Horario1_idx` (`Tipo_Horario_idTipo_Horario` ASC),
  CONSTRAINT `fk_Clase_Grupo1`
    FOREIGN KEY (`Grupo_idGrupo`)
    REFERENCES `SAES`.`Grupo` (`idGrupo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clase_Materias1`
    FOREIGN KEY (`Materias_idMaterias`)
    REFERENCES `SAES`.`Materias` (`idMaterias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clase_Profesor1`
    FOREIGN KEY (`Profesor_RFC`)
    REFERENCES `SAES`.`Profesor` (`RFC`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clase_Tipo_Horario1`
    FOREIGN KEY (`Tipo_Horario_idTipo_Horario`)
    REFERENCES `SAES`.`Tipo_Horario` (`idTipo_Horario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Tipo_Horario_has_Horas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Tipo_Horario_has_Horas` (
  `Tipo_Horario_idTipo_Horario` VARCHAR(2) NOT NULL,
  `Horas_idHorario` INT NOT NULL,
  PRIMARY KEY (`Tipo_Horario_idTipo_Horario`, `Horas_idHorario`),
  INDEX `fk_Tipo_Horario_has_Horas_Horas1_idx` (`Horas_idHorario` ASC),
  INDEX `fk_Tipo_Horario_has_Horas_Tipo_Horario1_idx` (`Tipo_Horario_idTipo_Horario` ASC),
  CONSTRAINT `fk_Tipo_Horario_has_Horas_Tipo_Horario1`
    FOREIGN KEY (`Tipo_Horario_idTipo_Horario`)
    REFERENCES `SAES`.`Tipo_Horario` (`idTipo_Horario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tipo_Horario_has_Horas_Horas1`
    FOREIGN KEY (`Horas_idHorario`)
    REFERENCES `SAES`.`Horas` (`idHorario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Alumno_has_Clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Alumno_has_Clase` (
  `Alumno_Boleta` VARCHAR(10) NOT NULL,
  `Clase_idClase` INT NOT NULL,
  PRIMARY KEY (`Alumno_Boleta`, `Clase_idClase`),
  INDEX `fk_Alumno_has_Clase_Clase1_idx` (`Clase_idClase` ASC),
  INDEX `fk_Alumno_has_Clase_Alumno1_idx` (`Alumno_Boleta` ASC),
  CONSTRAINT `fk_Alumno_has_Clase_Alumno1`
    FOREIGN KEY (`Alumno_Boleta`)
    REFERENCES `SAES`.`Alumno` (`Boleta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Alumno_has_Clase_Clase1`
    FOREIGN KEY (`Clase_idClase`)
    REFERENCES `SAES`.`Clase` (`idClase`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Forma_Evaluacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Forma_Evaluacion` (
  `idForma_Evaluacion` INT NOT NULL,
  `Forma_Evaluacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idForma_Evaluacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Kardex`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Kardex` (
  `Alumno_Boleta` VARCHAR(10) NOT NULL,
  `Materias_idMaterias` VARCHAR(4) NOT NULL,
  `Periodo` VARCHAR(45) NOT NULL,
  `Calificacion` INT NOT NULL,
  `Forma_Evaluacion_idForma_Evaluacion` INT NOT NULL,
  PRIMARY KEY (`Alumno_Boleta`, `Materias_idMaterias`),
  INDEX `fk_Alumno_has_Materias_Materias1_idx` (`Materias_idMaterias` ASC),
  INDEX `fk_Alumno_has_Materias_Alumno1_idx` (`Alumno_Boleta` ASC),
  INDEX `fk_Kardex_Forma_Evaluacion1_idx` (`Forma_Evaluacion_idForma_Evaluacion` ASC),
  CONSTRAINT `fk_Alumno_has_Materias_Alumno1`
    FOREIGN KEY (`Alumno_Boleta`)
    REFERENCES `SAES`.`Alumno` (`Boleta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Alumno_has_Materias_Materias1`
    FOREIGN KEY (`Materias_idMaterias`)
    REFERENCES `SAES`.`Materias` (`idMaterias`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Kardex_Forma_Evaluacion1`
    FOREIGN KEY (`Forma_Evaluacion_idForma_Evaluacion`)
    REFERENCES `SAES`.`Forma_Evaluacion` (`idForma_Evaluacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAES`.`Cita_reinscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAES`.`Cita_reinscripcion` (
  `idCita_reinscripcion` INT NOT NULL,
  `FechaInicio` DATETIME NOT NULL,
  `FechaFin` DATETIME NOT NULL,
  `Alumno_Boleta` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idCita_reinscripcion`),
  INDEX `fk_Cita_reinscripcion_Alumno1_idx` (`Alumno_Boleta` ASC),
  CONSTRAINT `fk_Cita_reinscripcion_Alumno1`
    FOREIGN KEY (`Alumno_Boleta`)
    REFERENCES `SAES`.`Alumno` (`Boleta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;