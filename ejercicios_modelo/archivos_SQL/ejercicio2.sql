
CREATE TABLE Servizo (
  Clave_Servizo CHAR(5),
  Nome_Servizo  VARCHAR(40),
  PRIMARY KEY (Clave_Servizo, Nome_Servizo)
);

CREATE TABLE Dependencia (
  Código_Dependencia CHAR(5),
  Nome_Dependencia   VARCHAR(40) NOT NULL,
  Función            VARCHAR(20),
  Localización       VARCHAR(20),
  Clave_Servizo      CHAR(5) NOT NULL,
  Nome_Servizo       VARCHAR(40) NOT NULL,
  PRIMARY KEY (Código_Dependencia),
  UNIQUE (Nome_Dependencia),
  FOREIGN KEY (Clave_Servizo, Nome_Servizo)
    REFERENCES Servizo (Clave_Servizo, Nome_Servizo)
    ON DELETE Cascade
    ON UPDATE Cascade
);

CREATE TABLE Cámara (
  Código_Dependencia CHAR(5),
  Categoría          VARCHAR(40) NOT NULL,
  Capacidade         INTEGER     NOT NULL,
  PRIMARY KEY (Código_Dependencia),
  FOREIGN KEY (Código_Dependencia)
    REFERENCES Dependencia (Código_Dependencia)
    ON DELETE Cascade
    ON UPDATE Cascade
);

CREATE TABLE Tripulación (
  Código_Tripulación CHAR(5) PRIMARY KEY,
  Nome_Tripulación   VARCHAR(40),
  Categoría          CHAR(20)    NOT NULL,
  Antigüidade        INTEGER     DEFAULT 0,
  Procedencia        CHAR(20),
  Adm                CHAR(20)    NOT NULL,
  Código_Dependencia CHAR(5) NOT NULL,
  Código_Cámara      CHAR(5) NOT NULL,
  FOREIGN KEY (Código_Cámara)
    REFERENCES Cámara (Código_Dependencia)
    ON UPDATE Cascade
    ON DELETE Cascade
);

ALTER TABLE Tripulación
  ADD FOREIGN KEY (Código_Dependencia)
    REFERENCES Dependencia (Código_Dependencia)
    ON UPDATE Cascade
    ON DELETE Cascade;

CREATE TABLE Planeta (
  Código_Planeta CHAR(5)          PRIMARY KEY,
  Nome_Planeta   VARCHAR(40) NOT NULL UNIQUE,
  Galaxia        CHAR(15)    NOT NULL,
  Coordenadas    CHAR(15)    NOT NULL,
  UNIQUE(Coordenadas)
 );

CREATE TABLE Visita (
  Código_Tripulación CHAR(5),
  Código_Planeta     CHAR(5),
  Data_Visita        DATE,
  Tempo              INTEGER      NOT NULL,
  PRIMARY KEY (Código_Tripulación, Código_Planeta, Data_Visita),
  FOREIGN KEY (Código_Tripulación)
    REFERENCES Tripulación (Código_Tripulación)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (Código_Planeta)
    REFERENCES Planeta (Código_Planeta)
    ON UPDATE CASCADE
    ON DELETE CASCADE 
);

CREATE TABLE Habita (
  Código_Planeta    CHAR(5),
  Nome_Raza         VARCHAR(40),
  Poboación_Parcial INTEGER     NOT NULL,
  PRIMARY KEY (Código_Planeta, Nome_Raza),
  FOREIGN KEY (Código_Planeta)
    REFERENCES Planeta (Código_Planeta)
    ON UPDATE Cascade
    ON DELETE Cascade
);

CREATE TABLE Raza (
  Nome_Raza       VARCHAR(40)  PRIMARY KEY,
  Altura          INTEGER      NOT NULL,  -- cm
  Anchura         INTEGER      NOT NULL,  -- cm
  Peso            INTEGER      NOT NULL,  -- g
  Poboación_Total INTEGER      NOT NULL
);

ALTER TABLE Habita
  ADD CONSTRAINT FK_Raza
    FOREIGN KEY (Nome_Raza)
      REFERENCES Raza (Nome_Raza)
      ON UPDATE CASCADE
      ON DELETE CASCADE;

ALTER TABLE Cámara
  ADD CONSTRAINT Capacidade_maior_de_cero
    CHECK (capacidade > 0);
