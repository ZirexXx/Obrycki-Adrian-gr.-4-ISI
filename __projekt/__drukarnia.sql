CREATE TABLE Pracownik(id_pracownika INT AUTO_INCREMENT PRIMARY KEY, Imie VARCHAR(45) NOT NULL, Nazwisko VARCHAR(45) NOT NULL, Nr_telefonu VARCHAR(9), Miejsce_zamieszkania VARCHAR(45), PESEL VARCHAR(11));
CREATE TABLE Wyplata(id_wyplaty INT AUTO_INCREMENT PRIMARY KEY, pracownik INT, ileGodzin DOUBLE(7,2), stawka DOUBLE(7,2), zaplata DOUBLE(7,2), dataWyplaty DATE, FOREIGN KEY(pracownik) REFERENCES Pracownik(id_pracownika));
CREATE TABLE Klient(id_klienta INT AUTO_INCREMENT PRIMARY KEY, Nazwa VARCHAR(45) NOT NULL, Miejscowosc VARCHAR(45), czyFirma ENUM('tak','nie'), NIP VARCHAR(10));
CREATE TABLE Drukarka(id_drukarki INT AUTO_INCREMENT PRIMARY KEY, Marka VARCHAR(45) NOT NULL, Model VARCHAR(45) NOT NULL, wUzytku ENUM('tak','nie'));
CREATE TABLE Format(id_formatu INT AUTO_INCREMENT PRIMARY KEY, nazwa VARCHAR(45), ilosc_papieru DOUBLE(7,2));
CREATE TABLE Usluga(id_uslugi INT AUTO_INCREMENT PRIMARY KEY, nazwa VARCHAR(45), cena_bazowa DOUBLE(7,2));
CREATE TABLE Zamowienie(id_zamowienia INT AUTO_INCREMENT PRIMARY KEY, klient INT, drukarka INT, pracownik INT, status VARCHAR(45), FOREIGN KEY(klient) REFERENCES Klient(id_klienta), FOREIGN KEY(drukarka) REFERENCES Drukarka(id_drukarki), FOREIGN KEY(pracownik) REFERENCES Pracownik(id_pracownika));
CREATE TABLE Szczegoly_zamowienia(id_szczegolow INT AUTO_INCREMENT PRIMARY KEY, zamowienie INT, usluga INT, format INT, ilosc DOUBLE(7,2), cena DOUBLE(7,2), dataPrzyjecia DATE, dataZakonczenia DATE, status VARCHAR(45), FOREIGN KEY(zamowienie) REFERENCES Zamowienie(id_zamowienia), FOREIGN KEY(usluga) REFERENCES Usluga(id_uslugi), FOREIGN KEY(format) REFERENCES Format(id_formatu));

ALTER TABLE Zamowienie 
MODIFY COLUMN klient INT NOT NULL, 
MODIFY COLUMN drukarka INT NOT NULL,
MODIFY COLUMN pracownik INT NOT NULL;

ALTER TABLE Szczegoly_zamowienia 
MODIFY COLUMN usluga INT NULL, 
MODIFY COLUMN format INT NULL;

ALTER TABLE Wyplata 
MODIFY COLUMN pracownik INT NOT NULL;

ALTER TABLE Zamowienie
ADD COLUMN numer_zamowienia VARCHAR(45) AFTER pracownik;

DELIMITER $$
CREATE PROCEDURE wyplata_p(IN id int, godziny DOUBLE(7,2), ph DOUBLE(7,2))
BEGIN
INSERT INTO Wyplata VALUES(default, id, godziny, ph, godziny*ph, CURDATE());
END
$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION zarobki()
RETURNS INTEGER
BEGIN
DECLARE zarobek INT;
SELECT SUM(cena*ilosc) INTO @zarobek FROM Szczegoly_zamowienia;
RETURN @zarobek;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER nowe_zamowienie
AFTER INSERT ON Zamowienie
FOR EACH ROW
BEGIN
UPDATE Drukarka SET wUzytku='tak' WHERE id_drukarki=NEW.drukarka;
INSERT INTO Szczegoly_zamowienia(id_szczegolow,zamowienie,dataPrzyjecia,status) VALUES(default,NEW.id_zamowienia,CURDATE(),'niezrealizowane');
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER aktualizacja_zamowienia
AFTER UPDATE ON Zamowienie
FOR EACH ROW
BEGIN
IF NEW.status='zrealizowane'
THEN
UPDATE Drukarka SET wUzytku='nie' WHERE id_drukarki=OLD.drukarka;
UPDATE Szczegoly_zamowienia SET status='zrealizowane' WHERE zamowienie=OLD.id_zamowienia;
UPDATE Szczegoly_zamowienia SET dataZakonczenia=CURDATE() WHERE zamowienie=OLD.id_zamowienia;
END IF;
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER papier_ilosc
AFTER UPDATE ON Szczegoly_zamowienia
FOR EACH ROW
BEGIN
IF NEW.status='zrealizowane'
THEN
UPDATE Format SET ilosc_papieru=ilosc_papieru-OLD.ilosc WHERE id_formatu=OLD.format;
END IF;
END
$$
DELIMITER ;