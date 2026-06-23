-- migrate:up

INSERT INTO books (id, title, isbn, pages, publication_year, edition_year, synopsis, cover_image, pdf_url, publisher_id) VALUES 
(1, 'Cien años de soledad', '978-0307474728', 496, 1967, 2019, 'La épica historia de la familia Buendía en el legendario pueblo de Macondo.', 'https://example.com/covers/cien_anos.jpg', 'https://example.com/pdfs/cien_anos.pdf', 3),
(2, 'Ficciones', '978-5551203491', 176, 1944, 2011, 'Colección de cuentos que exploran laberintos, espejos, el infinito y bibliotecas imaginarias.', 'https://example.com/covers/ficciones.jpg', NULL, 1),
(3, 'Rayuela', '978-0307474735', 600, 1963, 2016, 'Una contranovela que narra la historia de Horacio Oliveira y su relación con la Maga en París.', 'https://example.com/covers/rayuela.jpg', 'https://example.com/pdfs/rayuela.pdf', 3),
(4, 'La metamorfosis', '978-1503280787', 96, 1915, 2020, 'Gregorio Samsa se despierta una mañana transformado en un monstruoso insecto.', 'https://example.com/covers/metamorfosis.jpg', NULL, 5),
(5, 'Crimen y castigo', '978-0140449136', 671, 1866, 2003, 'El drama psicológico de Raskólnikov y su dilema moral tras cometer un asesinato.', 'https://example.com/covers/crimen_castigo.jpg', 'https://example.com/pdfs/crimen.pdf', 2),
(6, 'Orgullo y prejuicio', '978-8420674209', 448, 1813, 2012, 'La turbulenta relación entre Elizabeth Bennet y el aristócrata Fitzwilliam Darcy.', 'https://example.com/covers/orgullo_prejuicio.jpg', NULL, 5),
(7, 'Tokio blues', '978-8420473536', 384, 1987, 2008, 'Una nostálgica historia sobre la pérdida, la sexualidad y el despertar de la juventud.', 'https://example.com/covers/tokio_blues.jpg', 'https://example.com/pdfs/tokio.pdf', 4),
(8, 'La casa de los espíritus', '978-0307474537', 448, 1982, 2015, 'La saga de la familia Trueba a través de cuatro generaciones de pasiones y misticismo.', 'https://example.com/covers/casa_espiritus.jpg', NULL, 1),
(9, 'La ciudad y los perros', '978-8420471839', 464, 1963, 2012, 'La cruda vida de los cadetes en el Colegio Militar Leoncio Prado de Lima.', 'https://example.com/covers/ciudad_perros.jpg', 'https://example.com/pdfs/ciudad.pdf', 3),
(10, 'Al faro', '978-8420651149', 240, 1927, 2010, 'Una profunda reflexión sobre el tiempo, el arte y las dinámicas de la familia Ramsay.', 'https://example.com/covers/al_faro.jpg', NULL, 5);

-- migrate:down

DELETE FROM books;