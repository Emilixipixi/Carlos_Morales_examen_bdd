PARTE 4: RELACIONES MUCHOS A MUCHOS (N:N)

1. ¿Qué es una relación Muchos a Muchos?
Básicamente significa que las dos cosas que estamos juntando pueden tener varios elementos del otro lado.

El ejemplo de la captura:

Un Proyecto de software puede usar Muchas Tecnologías (por ejemplo, el Sistema Bancario usa Java, Spring Boot y Postgres).

Una Tecnología puede estar metida en Muchos Proyectos (Java se usa en el Sistema Bancario y también en una App de Redes Sociales).

2. ¿Por qué necesitamos una "Tabla Intermedia"?
Al principio pensé que podía meter una columna llamada tecnologia_id dentro de la tabla de proyectos, pero eso está mal. No puedes meter tres tecnologías en una sola celda. Si lo intentas, tendrías que repetir el proyecto varias veces y la base de datos se vuelve un desastre.

La solución correcta es crear una tabla intermedia (que funciona como un puente).

Dejamos la tabla proyectos limpia.

Dejamos la tabla tecnologias limpia.

Creamos proyectos_tecnologias que solo junta los IDs de ambos lados.

3. Las Tablas en Código SQL
Para que esto funcione en pgAdmin, creé las dos tablas normales y la tabla puente:

-- Tabla 1: Los Proyectos
CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dias_estimados INTEGER NOT NULL
);

-- Tabla 2: Las Tecnologías
CREATE TABLE tecnologias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria VARCHAR(30) NOT NULL
);

-- Tabla 3: La tabla puente (Intermedia)
CREATE TABLE proyectos_tecnologias (
    id_proyecto INTEGER NOT NULL,
    id_tecnologia INTEGER NOT NULL,
    PRIMARY KEY (id_proyecto, id_tecnologia),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id),
    FOREIGN KEY (id_tecnologia) REFERENCES tecnologias(id)
);

La línea PRIMARY KEY (id_proyecto, id_tecnologia) es una llave primaria compuesta. Sirve para que no puedas registrar por error dos veces que el "Proyecto 1" usa "Java". Si lo intentas, el sistema te da error y te frena. Las FOREIGN KEY cuidan que no inventes IDs que no existen.


4. Las Consultas (JOINs) explicadas fácil
Para sacar la información mezclada de las tres tablas, se usan los JOIN. Aquí puse las tres que nos piden:

Consulta 1: ¿Qué tecnologías usa un proyecto?
Aquí empezamos buscando el nombre del proyecto y viajamos por la tabla intermedia para jalar los nombres de sus tecnologías.

SELECT t.nombre, t.categoria
FROM tecnologias t
INNER JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
INNER JOIN proyectos p ON pt.id_proyecto = p.id
WHERE p.nombre = 'Sistema Bancario';

Consulta 2: ¿En qué proyectos se usa una tecnología?
Es al revés. Busco por el ID de la tecnología (por ejemplo, el 1 que es Java) y me dice en qué proyectos está funcionando.

SELECT p.nombre, p.dias_estimados
FROM proyectos p
INNER JOIN proyectos_tecnologias pt ON p.id = pt.id_proyecto
INNER JOIN tecnologias t ON pt.id_tecnologia = t.id
WHERE t.id = 1;


Consulta 3: Reporte total (¿Cuántos proyectos usan cada tecnología?)
Aquí uso un LEFT JOIN y un COUNT.


SELECT t.nombre, COUNT(pt.id_proyecto) AS total
FROM tecnologias t
LEFT JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
GROUP BY t.id, t.nombre
ORDER BY total DESC;


Uso LEFT JOIN porque si una tecnología es nueva y nadie la está usando todavía, quiero que salga en la lista con un cero. Si usara INNER JOIN, las tecnologías que no tienen proyectos desaparecerían del reporte.


Conclusion de lo que me llevo
Hacer esto evita que los datos se dupliquen y hace que todo sea ordenado. Si mañana me piden cambiar el nombre de "PostgreSQL" a "Postgres", solo lo cambio en un unico lugar (en la tabla tecnologias) y automaticamente se arregla en todos los proyectos vinculados.