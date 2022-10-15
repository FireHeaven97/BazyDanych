-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`adres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`adres` (
  `id_adres` INT NOT NULL,
  `miejscowość` VARCHAR(40) NOT NULL,
  `kod_pocztowy` INT(5) NOT NULL,
  `ulica` VARCHAR(40) NOT NULL,
  `numer_domu` INT(6) NULL,
  `numer_lokalu` INT(6) NULL,
  PRIMARY KEY (`id_adres`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`uzytkownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`uzytkownik` (
  `id_uzytkownik` INT NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `hasło` VARCHAR(45) NOT NULL,
  `administrator` BINARY(1) NOT NULL,
  `dane_osobowe_id_dane_osobowe` INT NOT NULL,
  PRIMARY KEY (`id_uzytkownik`, `dane_osobowe_id_dane_osobowe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dane_osobowe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dane_osobowe` (
  `id_dane_osobowe` INT NOT NULL,
  `nazwa_firmy` VARCHAR(45) NULL,
  `nip` INT(9) NULL,
  `imię` VARCHAR(20) NOT NULL,
  `nazwisko` VARCHAR(30) NOT NULL,
  `nr_telefonu` VARCHAR(12) NULL,
  `e-mail` VARCHAR(30) NOT NULL,
  `uzytkownik_id_uzytkownik` INT NOT NULL,
  `uzytkownik_dane_osobowe_id_dane_osobowe` INT NOT NULL,
  PRIMARY KEY (`id_dane_osobowe`),
  INDEX `fk_dane_osobowe_uzytkownik1_idx` (`uzytkownik_id_uzytkownik` ASC, `uzytkownik_dane_osobowe_id_dane_osobowe` ASC) VISIBLE,
  CONSTRAINT `fk_dane_osobowe_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id_uzytkownik` , `uzytkownik_dane_osobowe_id_dane_osobowe`)
    REFERENCES `mydb`.`uzytkownik` (`id_uzytkownik` , `dane_osobowe_id_dane_osobowe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`płatność`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`płatność` (
  `id_rodzaj` INT NOT NULL,
  `rodzaj_płatności` VARCHAR(20) NOT NULL,
  `adres_strony_platniczej` VARCHAR(45) NULL,
  `kod_platnosci` INT(100) NULL,
  PRIMARY KEY (`id_rodzaj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`faktura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`faktura` (
  `id_faktura` INT NOT NULL,
  `data_sprzedaży` INT(8) NOT NULL,
  `rodzaj_płatności_1` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_faktura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transkacja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transkacja` (
  `id_transakcja` INT NOT NULL,
  `data_transakcji` INT(8) NOT NULL,
  `data_przyjęcia` INT(8) NULL,
  `data_realizacji` INT(8) NULL,
  `data_wpłaty` INT(8) NULL,
  `uzytkownik_id_uzytkownik` INT NOT NULL,
  `uzytkownik_dane_osobowe_id_dane_osobowe` INT NOT NULL,
  `faktura_id_faktura` INT NOT NULL,
  `płatność_id_rodzaj` INT NOT NULL,
  PRIMARY KEY (`id_transakcja`, `płatność_id_rodzaj`),
  INDEX `fk_transkacja_klient1_idx` (`uzytkownik_id_uzytkownik` ASC, `uzytkownik_dane_osobowe_id_dane_osobowe` ASC) VISIBLE,
  INDEX `fk_transkacja_faktura1_idx` (`faktura_id_faktura` ASC) VISIBLE,
  INDEX `fk_transkacja_płatność1_idx` (`płatność_id_rodzaj` ASC) VISIBLE,
  CONSTRAINT `fk_transkacja_klient1`
    FOREIGN KEY (`uzytkownik_id_uzytkownik` , `uzytkownik_dane_osobowe_id_dane_osobowe`)
    REFERENCES `mydb`.`uzytkownik` (`id_uzytkownik` , `dane_osobowe_id_dane_osobowe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transkacja_faktura1`
    FOREIGN KEY (`faktura_id_faktura`)
    REFERENCES `mydb`.`faktura` (`id_faktura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transkacja_płatność1`
    FOREIGN KEY (`płatność_id_rodzaj`)
    REFERENCES `mydb`.`płatność` (`id_rodzaj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`kategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kategoria` (
  `id_kategoria` INT NOT NULL,
  `nazwa` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_kategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vat` (
  `id_vat` INT NOT NULL,
  `stawka_vat` FLOAT(4) NOT NULL,
  PRIMARY KEY (`id_vat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produkt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produkt` (
  `id_produkt` INT NOT NULL,
  `nazwa` VARCHAR(20) NOT NULL,
  `liczba` INT(3) NOT NULL,
  `dział` VARCHAR(20) NOT NULL,
  `cena_netto` FLOAT(6) NOT NULL,
  `kategoria_id_kategoria` INT NOT NULL,
  `vat_id_vat` INT NOT NULL,
  PRIMARY KEY (`id_produkt`, `kategoria_id_kategoria`, `vat_id_vat`),
  INDEX `fk_produkt_kategoria1_idx` (`kategoria_id_kategoria` ASC) VISIBLE,
  INDEX `fk_produkt_vat1_idx` (`vat_id_vat` ASC) VISIBLE,
  CONSTRAINT `fk_produkt_kategoria1`
    FOREIGN KEY (`kategoria_id_kategoria`)
    REFERENCES `mydb`.`kategoria` (`id_kategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produkt_vat1`
    FOREIGN KEY (`vat_id_vat`)
    REFERENCES `mydb`.`vat` (`id_vat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`koszyk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`koszyk` (
  `id_koszyk` INT NOT NULL,
  PRIMARY KEY (`id_koszyk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`kurier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kurier` (
  `id_kurier` INT NOT NULL,
  `nazwa_kuriera` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_kurier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produkt_do_koszyka`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produkt_do_koszyka` (
  `produkt_id_produkt` INT NOT NULL,
  `produkt_vat_id_vat` INT NOT NULL,
  `produkt_kategoria_id_kategoria` INT NOT NULL,
  `koszyk_id_koszyk` INT NOT NULL,
  PRIMARY KEY (`produkt_id_produkt`, `produkt_vat_id_vat`, `produkt_kategoria_id_kategoria`, `koszyk_id_koszyk`),
  INDEX `fk_produkt_has_koszyk_koszyk1_idx` (`koszyk_id_koszyk` ASC) VISIBLE,
  INDEX `fk_produkt_has_koszyk_produkt1_idx` (`produkt_id_produkt` ASC, `produkt_vat_id_vat` ASC, `produkt_kategoria_id_kategoria` ASC) VISIBLE,
  CONSTRAINT `fk_produkt_has_koszyk_produkt1`
    FOREIGN KEY (`produkt_id_produkt`)
    REFERENCES `mydb`.`produkt` (`id_produkt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produkt_has_koszyk_koszyk1`
    FOREIGN KEY (`koszyk_id_koszyk`)
    REFERENCES `mydb`.`koszyk` (`id_koszyk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`kurier_zna_adresy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kurier_zna_adresy` (
  `adres_id_adres` INT NOT NULL,
  `kurier_id_kurier` INT NOT NULL,
  PRIMARY KEY (`adres_id_adres`, `kurier_id_kurier`),
  INDEX `fk_adres_has_kurier_kurier1_idx` (`kurier_id_kurier` ASC) VISIBLE,
  INDEX `fk_adres_has_kurier_adres1_idx` (`adres_id_adres` ASC) VISIBLE,
  CONSTRAINT `fk_adres_has_kurier_adres1`
    FOREIGN KEY (`adres_id_adres`)
    REFERENCES `mydb`.`adres` (`id_adres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adres_has_kurier_kurier1`
    FOREIGN KEY (`kurier_id_kurier`)
    REFERENCES `mydb`.`kurier` (`id_kurier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`egzemplarze`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`egzemplarze` (
  `transkacja_id_transakcja` INT NOT NULL,
  `produkt_id_produkt` INT NOT NULL,
  `cena_bierząca` INT(5) NULL,
  `kod_produktu` INT(10) NOT NULL,
  PRIMARY KEY (`transkacja_id_transakcja`, `produkt_id_produkt`),
  INDEX `fk_transkacja_has_produkt_produkt1_idx` (`produkt_id_produkt` ASC) VISIBLE,
  INDEX `fk_transkacja_has_produkt_transkacja1_idx` (`transkacja_id_transakcja` ASC) VISIBLE,
  CONSTRAINT `fk_transkacja_has_produkt_transkacja1`
    FOREIGN KEY (`transkacja_id_transakcja`)
    REFERENCES `mydb`.`transkacja` (`id_transakcja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transkacja_has_produkt_produkt1`
    FOREIGN KEY (`produkt_id_produkt`)
    REFERENCES `mydb`.`produkt` (`id_produkt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`adres_has_uzytkownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`adres_has_uzytkownik` (
  `adres_id_adres` INT NOT NULL,
  `uzytkownik_id_uzytkownik` INT NOT NULL,
  `uzytkownik_dane_osobowe_id_dane_osobowe` INT NOT NULL,
  PRIMARY KEY (`adres_id_adres`, `uzytkownik_id_uzytkownik`, `uzytkownik_dane_osobowe_id_dane_osobowe`),
  INDEX `fk_adres_has_uzytkownik_uzytkownik1_idx` (`uzytkownik_id_uzytkownik` ASC, `uzytkownik_dane_osobowe_id_dane_osobowe` ASC) VISIBLE,
  INDEX `fk_adres_has_uzytkownik_adres1_idx` (`adres_id_adres` ASC) VISIBLE,
  CONSTRAINT `fk_adres_has_uzytkownik_adres1`
    FOREIGN KEY (`adres_id_adres`)
    REFERENCES `mydb`.`adres` (`id_adres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adres_has_uzytkownik_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id_uzytkownik` , `uzytkownik_dane_osobowe_id_dane_osobowe`)
    REFERENCES `mydb`.`uzytkownik` (`id_uzytkownik` , `dane_osobowe_id_dane_osobowe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`klient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`klient` (`id_dane_osobowe` INT, `nazwa_firmy` INT, `nip` INT, `imię` INT, `nazwisko` INT, `nr_telefonu` INT, `e-mail` INT, `uzytkownik_id_uzytkownik` INT, `uzytkownik_dane_osobowe_id_dane_osobowe` INT, `id_uzytkownik` INT, `login` INT, `hasło` INT, `administrator` INT, `dane_osobowe_id_dane_osobowe` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`transakcja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transakcja` (`id_faktura` INT, `data_sprzedaży` INT, `rodzaj_płatności_1` INT, `id_rodzaj` INT, `rodzaj_płatności` INT, `adres_strony_platniczej` INT, `kod_platnosci` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`produkt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produkt` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`klient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`klient`;
USE `mydb`;
CREATE  OR REPLACE VIEW `klient` AS SELECT * 
FROM `dane_osobowe` CROSS JOIN `uzytkownik` `adres`;

-- -----------------------------------------------------
-- View `mydb`.`transakcja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`transakcja`;
USE `mydb`;
CREATE  OR REPLACE VIEW `transakcja` AS SELECT *
FROM `faktura` CROSS JOIN `płatność` `transakcja`;

-- -----------------------------------------------------
-- View `mydb`.`produkt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`produkt`;
USE `mydb`;
CREATE  OR REPLACE VIEW `produkt` AS SELECT *
FROM `produkt` CROSS JOIN `vat` `kategoria` `egzemplarze`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
