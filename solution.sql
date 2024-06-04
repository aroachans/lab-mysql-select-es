-- Desafío 1 - ¿Quién ha publicado qué y dónde?En este desafío escribirás una consulta SELECT de MySQL que una varias tablas para descubrir qué títulos ha publicado cada autor en qué editoriales
SELECT a.au_id AS "Author ID", 
       b.au_lname AS "Last Name", 
       b.au_fname AS "First Name", 
       c.title AS "Title", 
       d.pub_name AS "Publisher"
FROM titleauthor a
INNER JOIN authors b ON a.au_id = b.au_id
INNER JOIN titles c ON a.title_id = c.title_id
INNER JOIN publishers d ON c.pub_id = d.pub_id
ORDER BY a.au_id

-- Desafío 2 - ¿Quién ha publicado cuántos y dónde? Partiendo de tu solución en el Desafío 1, consulta cuántos títulos ha publicado cada autor en cada editorial. Tu salida debería parecerse a esto:
SELECT a.au_id AS "Author ID", 
       b.au_lname AS "Last Name", 
       b.au_fname AS "First Name", 
       d.pub_name AS "Publisher",
       COUNT(c.title) AS "Title Count"
FROM titleauthor a
INNER JOIN authors b ON a.au_id = b.au_id
INNER JOIN titles c ON a.title_id = c.title_id
INNER JOIN publishers d ON c.pub_id = d.pub_id
GROUP BY a.au_id, b.au_lname, b.au_fname, d.pub_name
ORDER BY COUNT(c.title) DESC;

-- Desafío 3 - Autores Más Vendidos: ¿Quiénes son los 3 principales autores que han vendido el mayor número de títulos? 
SELECT b.au_id AS "Author ID",
       b.au_lname AS "Last Name",
       b.au_fname AS "First Name",
       SUM(c.ytd_sales) AS "Total Sales"
FROM titleauthor a
INNER JOIN authors b ON a.au_id = b.au_id
INNER JOIN titles c ON a.title_id = c.title_id
GROUP BY b.au_id, b.au_lname, b.au_fname
ORDER BY SUM(c.ytd_sales) DESC
LIMIT 3;

-- Desafío 4 - Ranking de Autores Más Vendidos Ahora modifica tu solución en el Desafío 3 para que la salida muestre a todos los 23 autores en lugar de solo los 3 principales
SELECT b.au_id AS "Author ID",
       b.au_lname AS "Last Name",
       b.au_fname AS "First Name",
       COALESCE(SUM(c.ytd_sales), 0) AS "Total Sales"
FROM authors b
LEFT JOIN titleauthor a ON b.au_id = a.au_id
LEFT JOIN titles c ON a.title_id = c.title_id
GROUP BY b.au_id, b.au_lname, b.au_fname
ORDER BY "Total Sales" DESC;


