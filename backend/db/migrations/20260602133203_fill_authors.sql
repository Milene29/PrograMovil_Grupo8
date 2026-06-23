-- migrate:up

INSERT INTO authors (id, full_name, birth_date, picture) VALUES 
(1, 'Gabriel García Márquez', '1927-03-06', 'https://example.com/images/gabriel_garcia_marquez.jpg'),
(2, 'Isabel Allende', '1942-08-02', 'https://example.com/images/isabel_allende.jpg'),
(3, 'Jorge Luis Borges', '1899-08-24', 'https://example.com/images/jorge_luis_borges.jpg'),
(4, 'Julio Cortázar', '1914-08-26', 'https://example.com/images/julio_cortazar.jpg'),
(5, 'Mario Vargas Llosa', '1936-03-28', 'https://example.com/images/mario_vargas_llosa.jpg'),
(6, 'Virginia Woolf', '1882-01-25', 'https://example.com/images/virginia_woolf.jpg'),
(7, 'Franz Kafka', '1883-07-03', 'https://example.com/images/franz_kafka.jpg'),
(8, 'Fyodor Dostoevsky', '1821-11-11', 'https://example.com/images/fyodor_dostoevsky.jpg'),
(9, 'Jane Austen', '1775-12-16', 'https://example.com/images/jane_austen.jpg'),
(10, 'Haruki Murakami', '1949-01-12', 'https://example.com/images/haruki_murakami.jpg');

-- migrate:down

DELETE FROM authors;