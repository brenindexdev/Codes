-- MySQL Workbench Forward Engineering

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema crica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema crica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `crica`  ;
USE `crica` ;

-- -----------------------------------------------------
-- Table `crica`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`alunos` (
  `prontuario_alu` VARCHAR(9) NOT NULL,
  `nome_alu` VARCHAR(45) NOT NULL,
  `nascimento_alu` DATETIME NULL DEFAULT NULL,
  `cpf_alu` VARCHAR(14) NULL DEFAULT NULL,
  `fone_alu` VARCHAR(14) NULL DEFAULT NULL,
  `email_alu` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`prontuario_alu`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`Cursos` (
  `codigo_curso` INT NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(45) NOT NULL,
  `ch_curso` INT NULL,
  PRIMARY KEY (`codigo_curso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`disciplinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`disciplinas` (
  `codigo_dis` VARCHAR(6) NOT NULL,
  `nome_dis` VARCHAR(45) NOT NULL,
  `curso_dis` VARCHAR(45) NULL DEFAULT NULL,
  `serie_dis` INT NULL DEFAULT NULL,
  `ch_dis` INT NULL DEFAULT NULL,
  `Cursos_codigo_curso` INT NOT NULL,
  `ano_dis` INT NULL,
  PRIMARY KEY (`codigo_dis`),
  CONSTRAINT `fk_disciplinas_Cursos1`
    FOREIGN KEY (`Cursos_codigo_curso`)
    REFERENCES `crica`.`Cursos` (`codigo_curso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`boletim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`boletim` (
  `prontuario_alu` VARCHAR(9) NOT NULL,
  `codigo_dis` VARCHAR(6) NOT NULL,
  `ano_bol` INT NULL DEFAULT NULL,
  `nota1_bol` FLOAT NULL DEFAULT NULL,
  `nota2_bol` FLOAT NULL DEFAULT NULL,
  `media_bol` FLOAT NULL DEFAULT NULL,
  `faltas_bol` INT NULL DEFAULT NULL,
  `situacao_bol` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`prontuario_alu`, `codigo_dis`),
  CONSTRAINT `fk_Alunos_has_Disciplinas_Alunos`
    FOREIGN KEY (`prontuario_alu`)
    REFERENCES `crica`.`alunos` (`prontuario_alu`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Alunos_has_Disciplinas_Disciplinas1`
    FOREIGN KEY (`codigo_dis`)
    REFERENCES `crica`.`disciplinas` (`codigo_dis`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`professores` (
  `codigo_prof` INT NOT NULL AUTO_INCREMENT,
  `nome_prof` VARCHAR(45) NOT NULL,
  `nascimento_prof` DATETIME NULL DEFAULT NULL,
  `cpf_prof` VARCHAR(14) NULL DEFAULT NULL,
  `fone_prof` VARCHAR(14) NULL DEFAULT NULL,
  `email_prof` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo_prof`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`turmas` (
  `codigo_dis` VARCHAR(6) NOT NULL,
  `codigo_prof` INT NOT NULL,
  `ano_tur` INT NULL DEFAULT NULL,
  PRIMARY KEY (`codigo_dis`, `codigo_prof`),
  CONSTRAINT `fk_Disciplinas_has_Professores_Disciplinas1`
    FOREIGN KEY (`codigo_dis`)
    REFERENCES `crica`.`disciplinas` (`codigo_dis`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Disciplinas_has_Professores_Professores1`
    FOREIGN KEY (`codigo_prof`)
    REFERENCES `crica`.`professores` (`codigo_prof`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`Horarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`Horarios` (
  `codigo_hora` INT NOT NULL,
  `inicio_hora` DATETIME NULL,
  `fim_hora` DATETIME NULL,
  `periodo_hora` VARCHAR(15) NULL,
  PRIMARY KEY (`codigo_hora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`Grade_horaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`Grade_horaria` (
  `codigo_dis` VARCHAR(6) NOT NULL,
  `codigo_hora` INT NOT NULL,
  `ano_grade` INT NULL,
  PRIMARY KEY (`codigo_dis`, `codigo_hora`),
  CONSTRAINT `fk_disciplinas_has_Horarios_disciplinas1`
    FOREIGN KEY (`codigo_dis`)
    REFERENCES `crica`.`disciplinas` (`codigo_dis`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_disciplinas_has_Horarios_Horarios1`
    FOREIGN KEY (`codigo_hora`)
    REFERENCES `crica`.`Horarios` (`codigo_hora`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`Salas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`Salas` (
  `codigo_sala` VARCHAR(3) NOT NULL,
  `nome_sala` VARCHAR(45) NOT NULL,
  `capacidade_sala` INT NULL,
  PRIMARY KEY (`codigo_sala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crica`.`Mapa_salas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `crica`.`Mapa_salas` (
  `codigo_sala` VARCHAR(3) NOT NULL,
  `codigo_dis` VARCHAR(6) NOT NULL,
  `ano_mapa` INT NULL,
  `dia_mapa` VARCHAR(15) NULL,
  PRIMARY KEY (`codigo_sala`, `codigo_dis`),
  CONSTRAINT `fk_Salas_has_disciplinas_Salas1`
    FOREIGN KEY (`codigo_sala`)
    REFERENCES `crica`.`Salas` (`codigo_sala`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Salas_has_disciplinas_disciplinas1`
    FOREIGN KEY (`codigo_dis`)
    REFERENCES `crica`.`disciplinas` (`codigo_dis`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE USER 'breno'@'localhost' IDENTIFIED BY 'senha';

GRANT ALL PRIVILEGES ON * . * TO 'breno'@'localhost' ;

