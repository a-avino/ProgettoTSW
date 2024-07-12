DROP DATABASE IF EXISTS sushistar;
CREATE DATABASE sushistar;
USE sushistar;

CREATE TABLE Utente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Password VARCHAR(1000) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Ruolo VARCHAR(50) NOT NULL
);

CREATE TABLE Delivery (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    IndirizzoConsegna VARCHAR(255) NOT NULL
);

CREATE TABLE Takeaway (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    OrarioRitiro TIME NOT NULL
);

CREATE TABLE Ordine (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    DataOrdine DATE NOT NULL,
    TipoOrdine ENUM('Delivery', 'Takeaway') NOT NULL
);

CREATE TABLE Categoria (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descrizione TEXT
);

CREATE TABLE ProdottoCatalogo (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descrizione TEXT,
    Foto VARCHAR(255),
    PezziPorzione INT NOT NULL,
    Prezzo DECIMAL(10, 2) NOT NULL,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categoria(ID)
);

CREATE TABLE Tag (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

CREATE TABLE ProdottoOrdine (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Prezzo DECIMAL(10, 2) NOT NULL,
    Quantita INT NOT NULL,
    OrdineID INT,
    FOREIGN KEY (OrdineID) REFERENCES Ordine(ID)
);

CREATE TABLE CompostoDa (
    OrdineID INT,
    ProdottoOrdineID INT,
    PRIMARY KEY (OrdineID, ProdottoOrdineID),
    FOREIGN KEY (OrdineID) REFERENCES Ordine(ID),
    FOREIGN KEY (ProdottoOrdineID) REFERENCES ProdottoOrdine(ID)
);

CREATE TABLE Effettua (
    UtenteID INT,
    OrdineID INT,
    PRIMARY KEY (UtenteID, OrdineID),
    FOREIGN KEY (UtenteID) REFERENCES Utente(ID),
    FOREIGN KEY (OrdineID) REFERENCES Ordine(ID)
);

CREATE TABLE Appartiene (
    ProdottoCatalogoID INT,
    CategoriaID INT,
    PRIMARY KEY (ProdottoCatalogoID, CategoriaID),
    FOREIGN KEY (ProdottoCatalogoID) REFERENCES ProdottoCatalogo(ID) ON DELETE CASCADE ON update CASCADE,
    FOREIGN KEY (CategoriaID) REFERENCES Categoria(ID)
);

CREATE TABLE PossiedeTag (
    ProdottoCatalogoID INT,
    TagID INT,
    PRIMARY KEY (ProdottoCatalogoID, TagID),
    FOREIGN KEY (ProdottoCatalogoID) REFERENCES ProdottoCatalogo(ID) ON DELETE CASCADE ON update CASCADE,
    FOREIGN KEY (TagID) REFERENCES Tag(ID)
);

CREATE TABLE Consegnato (
    DeliveryID INT,
    OrdineID INT,
    PRIMARY KEY (DeliveryID, OrdineID),
    FOREIGN KEY (DeliveryID) REFERENCES Delivery(ID),
    FOREIGN KEY (OrdineID) REFERENCES Ordine(ID)
);

CREATE TABLE Preparazione (
    TakeawayID INT,
    OrdineID INT,
    PRIMARY KEY (TakeawayID, OrdineID),
    FOREIGN KEY (TakeawayID) REFERENCES Takeaway(ID),
    FOREIGN KEY (OrdineID) REFERENCES Ordine(ID)
);
