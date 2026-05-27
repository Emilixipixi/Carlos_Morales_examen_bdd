CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dias_estimados INTEGER NOT NULL CHECK (dias_estimados > 0)
);



CREATE TABLE tecnologias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria VARCHAR(30) NOT NULL
);



CREATE TABLE proyectos_tecnologias (
    id_proyecto INTEGER NOT NULL,
    id_tecnologia INTEGER NOT NULL,
    PRIMARY KEY (id_proyecto, id_tecnologia),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id),
    FOREIGN KEY (id_tecnologia) REFERENCES tecnologias(id)
);



INSERT INTO proyectos (nombre, dias_estimados) VALUES ('Sistema Bancario', 45);
INSERT INTO proyectos (nombre, dias_estimados) VALUES ('App de Redes Sociales', 90);
INSERT INTO proyectos (nombre, dias_estimados) VALUES ('Dashboard Analytics', 30);

INSERT INTO tecnologias (nombre, categoria) VALUES ('Java', 'Backend');
INSERT INTO tecnologias (nombre, categoria) VALUES ('Spring Boot', 'Backend');
INSERT INTO tecnologias (nombre, categoria) VALUES ('React', 'Frontend');
INSERT INTO tecnologias (nombre, categoria) VALUES ('PostgreSQL', 'Base de Datos');
INSERT INTO tecnologias (nombre, categoria) VALUES ('Docker', 'DevOps');

INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (1, 1);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (1, 2);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (1, 4);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (2, 3);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (2, 1);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (2, 4);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (3, 3);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (3, 4);
INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES (3, 5);





-- 1. Tecnologías por Proyecto (filtrando por nombre del proyecto)
SELECT t.nombre, t.categoria
FROM tecnologias t
INNER JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
INNER JOIN proyectos p ON pt.id_proyecto = p.id
WHERE p.nombre = 'Sistema Bancario';

-- 2. Proyectos por Tecnología (filtrando por id de tecnología)
SELECT p.nombre, p.dias_estimados
FROM proyectos p
INNER JOIN proyectos_tecnologias pt ON p.id = pt.id_proyecto
INNER JOIN tecnologias t ON pt.id_tecnologia = t.id
WHERE t.id = 1;

-- 3. Reporte de Uso Tecnológico (GROUP BY y COUNT)
SELECT t.nombre, COUNT(pt.id_proyecto) AS cantidad_proyectos
FROM tecnologias t
LEFT JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
GROUP BY t.id, t.nombre
ORDER BY cantidad_proyectos DESC;