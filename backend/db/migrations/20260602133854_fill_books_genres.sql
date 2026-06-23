-- migrate:up

INSERT INTO books_genres (book_id, genre_id) VALUES 
-- Cien años de soledad (Libro 1) es Novela (1) y Fantasía/Realismo Mágico (3)
(1, 1),
(1, 3),

-- Ficciones (Libro 2) es Novela/Ficción (1) y Misterio (6)
(2, 1),
(2, 6),

-- Rayuela (Libro 3) es Novela (1) y Drama (9)
(3, 1),
(3, 9),

-- La metamorfosis (Libro 4) es Novela (1) y Fantasía/Terror (4)
(4, 1),
(4, 4),

-- Crimen y castigo (Libro 5) es Novela (1) y Thriller/Psicológico (7)
(5, 1),
(5, 7),

-- Orgullo y prejuicio (Libro 6) es Novela (1) y Romance (5)
(6, 1),
(6, 5),

-- Tokio blues (Libro 7) es Novela (1) y Drama (9)
(7, 1),
(7, 9),

-- La casa de los espíritus (Libro 8) es Novela (1) y Fantasía (3)
(8, 1),
(8, 3),

-- La ciudad y los perros (Libro 9) es Novela (1) y Drama (9)
(9, 1),
(9, 9),

-- Al faro (Libro 10) es Novela (1) y Drama (9)
(10, 1),
(10, 9);

-- migrate:down

DELETE FROM books_genres;