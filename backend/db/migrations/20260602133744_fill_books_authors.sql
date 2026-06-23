-- migrate:up

INSERT INTO books_authors (book_id, author_id) VALUES 
(1, 1),   -- Cien años de soledad ↔ Gabriel García Márquez
(2, 3),   -- Ficciones ↔ Jorge Luis Borges
(3, 4),   -- Rayuela ↔ Julio Cortázar
(4, 7),   -- La metamorfosis ↔ Franz Kafka
(5, 8),   -- Crimen y castigo ↔ Fyodor Dostoevsky
(6, 9),   -- Orgullo y prejuicio ↔ Jane Austen
(7, 10),  -- Tokio blues ↔ Haruki Murakami
(8, 2),   -- La casa de los espíritus ↔ Isabel Allende
(9, 5),   -- La ciudad y los perros ↔ Mario Vargas Llosa
(10, 6);  -- Al faro ↔ Virginia Woolf

-- migrate:down

DELETE FROM books_authors;