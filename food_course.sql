
DROP TABLE IF EXISTS Foods;
CREATE TABLE Foods (
      name CHAR(8) NOT NULL,
      type CHAR(5),
      flavor    CHAR(6),
      PRIMARY KEY ( name )
);

INSERT INTO Foods VALUES('peach', 'fruit', 'sweet');
INSERT INTO Foods VALUES('tomato', 'fruit', 'savory');
INSERT INTO Foods VALUES('lemon', 'fruit', 'sour');
INSERT INTO Foods VALUES('lard', 'fat', 'bland');
INSERT INTO Foods VALUES('cheddar', 'fat', 'savory');

DROP TABLE IF EXISTS Courses;
CREATE TABLE Courses (
      course      CHAR(8) NOT NULL PRIMARY KEY,
      flavor      CHAR(6),
      sequence INTEGER
);

INSERT INTO Courses VALUES('salad', 'savory', 1);
INSERT INTO Courses VALUES('main', 'savory', 2);
INSERT INTO Courses VALUES('dessert', 'sweet', 3);

