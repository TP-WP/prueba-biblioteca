CREATE DATABASE biblioteca;

\ c biblioteca;

CREATE TABLE libro(
    isbn VARCHAR(15) PRIMARY KEY,
    titulo VARCHAR(50),
    paginas INT
);

CREATE TABLE autor(
    codigo INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento INT,
    fecha_muerte INT
);

CREATE TABLE autores(
    isbn_libro VARCHAR(50),
    codigo_autor INT,
    tipo_autor VARCHAR(12),
    PRIMARY KEY (isbn_libro, codigo_autor),
    FOREIGN KEY (isbn_libro) REFERENCES libro(isbn),
    FOREIGN KEY (codigo_autor) REFERENCES autor(codigo)
);

CREATE TABLE socio(
    rut VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(250),
    telefono NUMERIC
);

CREATE TABLE historial_prestamos(
    id SERIAL PRIMARY KEY,
    rut_socio VARCHAR(12),
    isbn_libro VARCHAR(15),
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (rut_socio) REFERENCES socio(rut),
    FOREIGN KEY (isbn_libro) REFERENCES libro(isbn)
);

-- Se llenan las tablas
INSERT INTO
    socio (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '1111111-1',
        'JUAN',
        'SOTO',
        'AVENIDA 1, SANTIAGO',
        911111111
    ),
    (
        '2222222-2',
        'ANA',
        'PEREZ',
        'PASAJE 2, SANTIAGO',
        922222222
    ),
    (
        '3333333-3',
        'SANDRA',
        'AGUILAR',
        'AVENIDA 2, SANTIAGO',
        933333333
    ),
    (
        '4444444-4',
        'ESTEBAN',
        'JEREZ',
        'AVENIDA 3, SANTIAGO',
        944444444
    ),
    (
        '5555555-5',
        'SILVANA',
        'MUNOZ',
        'PASAJE 3, SANTIAGO',
        955555555
    );

INSERT INTO
    libro
VALUES
    (
        '111-1111111-111',
        'CUENTOS DE TERROR',
        344
    ),
    (
        '222-2222222-22',
        'POESIAS CONTEMPORANEAS',
        167
    ),
    (
        '333-3333333-333',
        'HISTORIA DE ASIA',
        511
    ),
    (
        '444-4444444-444',
        'MANUAL DE MECANICA',
        298
    );

INSERT INTO
    autor(
        codigo,
        nombre,
        apellido,
        fecha_nacimiento,
        fecha_muerte
    )
VALUES
    (
        3,
        'JOSE',
        'SALGADO',
        1968,
        2020
    ),
    (
        4,
        'ANA',
        'SALGADO',
        1972,
        NULL
    ),
    (
        1,
        'ANDRES',
        'ULLOA',
        1982,
        NULL
    ),
    (
        2,
        'SERGIO',
        'MARDONES',
        1950,
        2012
    ),
    (
        5,
        'MARTIN',
        'PORTA',
        1976,
        NULL
    );

INSERT INTO
    autores(isbn_libro, codigo_autor, tipo_autor)
VALUES
    (
        '111-1111111-111',
        3,
        'PRINCIPAL'
    ),
    (
        '111-1111111-111',
        4,
        'COAUTOR'
    ),
    (
        '222-2222222-22',
        1,
        'PRINCIPAL'
    ),
    (
        '333-3333333-333',
        2,
        'PRINCIPAL'
    ),
    (
        '444-4444444-444',
        5,
        'PRINCIPAL'
    );

INSERT INTO
    historial_prestamos(
        rut_socio,
        isbn_libro,
        fecha_prestamo,
        fecha_devolucion
    )
VALUES
    (
        '1111111-1',
        '111-1111111-111',
        '2020-01-20',
        '2020-01-27'
    ),
    (
        '5555555-5',
        '222-2222222-22',
        '2020-01-20',
        '2020-01-30'
    ),
    (
        '3333333-3',
        '333-3333333-333',
        '2020-01-22',
        '2020-01-30'
    ),
    (
        '4444444-4',
        '444-4444444-444',
        '2020-01-23',
        '2020-01-30'
    ),
    (
        '2222222-2',
        '111-1111111-111',
        '2020-01-27',
        '2020-02-04'
    ),
    (
        '1111111-1',
        '444-4444444-444',
        '2020-01-31',
        '2020-02-12'
    ),
    (
        '3333333-3',
        '222-2222222-22',
        '2020-01-31',
        '2020-02-12'
    );

--3.a
SELECT
    titulo
FROM
    libro
WHERE
    paginas >= 300;

--3.b
SELECT
    nombre,
    apellido
FROM
    autor
WHERE
    fecha_nacimiento >= 1970;

--3.d
SELECT
    isbn_libro,
    COUNT(*)
FROM
    historial_prestamos
GROUP BY
    isbn_libro
LIMIT
    1;

--el libro mas solicitado es un empate entre cuentos de terror, poesia contemporanea y manual de mecanica
--aplicando limit 1 se seleccionaria el mas solicitado
--3.d
SELECT
    fecha_prestamo,
    fecha_devolucion,
    fecha_devolucion - fecha_prestamo AS diferencia,
    (fecha_devolucion - fecha_prestamo -7) * 100 AS monto
FROM
    historial_prestamos
WHERE
    (fecha_devolucion - fecha_prestamo) > 7;

--monto seria finalmente lo que deben pagar los usuarios