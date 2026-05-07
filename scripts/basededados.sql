-----------------------------------------------------
-- TABELA PERIODO
-----------------------------------------------------

CREATE TABLE tb_periodo (
    id_periodo NUMBER PRIMARY KEY,
    ano NUMBER(4) NOT NULL,
    mes NUMBER(2) NOT NULL,

    CONSTRAINT ck_mes
    CHECK (mes BETWEEN 1 AND 12),

    CONSTRAINT uk_periodo
    UNIQUE (ano, mes)
);

-----------------------------------------------------
-- TABELA HEMOCOMPONENTE
-----------------------------------------------------

CREATE TABLE tb_hemocomponente (
    id_hemocomponente NUMBER PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,

    CONSTRAINT uk_nome
    UNIQUE (nome)
);

-----------------------------------------------------
-- TABELA TRANSFUSAO
-----------------------------------------------------

CREATE TABLE tb_transfusao (
    id_transfusao NUMBER PRIMARY KEY,
    id_periodo NUMBER NOT NULL,
    id_hemocomponente NUMBER NOT NULL,
    quantidade NUMBER NOT NULL,

    CONSTRAINT fk_periodo
    FOREIGN KEY (id_periodo)
    REFERENCES tb_periodo(id_periodo),

    CONSTRAINT fk_hemocomponente
    FOREIGN KEY (id_hemocomponente)
    REFERENCES tb_hemocomponente(id_hemocomponente),

    CONSTRAINT ck_quantidade
    CHECK (quantidade >= 0)
);

-----------------------------------------------------
-- INSERTS PERIODO
-----------------------------------------------------

INSERT INTO tb_periodo VALUES (1, 2023, 1);
INSERT INTO tb_periodo VALUES (2, 2023, 2);
INSERT INTO tb_periodo VALUES (3, 2023, 3);

INSERT INTO tb_periodo VALUES (4, 2024, 1);
INSERT INTO tb_periodo VALUES (5, 2024, 2);

INSERT INTO tb_periodo VALUES (6, 2025, 1);

-----------------------------------------------------
-- INSERTS HEMOCOMPONENTES
-----------------------------------------------------

INSERT INTO tb_hemocomponente
VALUES (1, 'CONCENTRADO DE HEMÁCIAS');

INSERT INTO tb_hemocomponente
VALUES (2, 'PLASMA FRESCO CONGELADO');

INSERT INTO tb_hemocomponente
VALUES (3, 'CONCENTRADO DE PLAQUETAS');

INSERT INTO tb_hemocomponente
VALUES (4, 'CRIOPRECIPITADO');

-----------------------------------------------------
-- INSERTS TRANSFUSOES
-----------------------------------------------------

INSERT INTO tb_transfusao
VALUES (1, 1, 1, 25);

INSERT INTO tb_transfusao
VALUES (2, 1, 2, 10);

INSERT INTO tb_transfusao
VALUES (3, 2, 1, 18);

INSERT INTO tb_transfusao
VALUES (4, 2, 3, 12);

INSERT INTO tb_transfusao
VALUES (5, 3, 4, 7);

INSERT INTO tb_transfusao
VALUES (6, 4, 1, 30);

INSERT INTO tb_transfusao
VALUES (7, 4, 2, 15);

INSERT INTO tb_transfusao
VALUES (8, 5, 3, 20);

INSERT INTO tb_transfusao
VALUES (9, 6, 1, 28);

-----------------------------------------------------
-- CONSULTA GERAL
-----------------------------------------------------

SELECT
    p.ano,
    p.mes,
    h.nome AS hemocomponente,
    t.quantidade
FROM tb_transfusao t
INNER JOIN tb_periodo p
ON p.id_periodo = t.id_periodo
INNER JOIN tb_hemocomponente h
ON h.id_hemocomponente = t.id_hemocomponente
ORDER BY p.ano, p.mes;
