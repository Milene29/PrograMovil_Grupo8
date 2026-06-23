-- migrate:up

INSERT INTO genres (id, name) VALUES (1, 'Novela');
INSERT INTO genres (id, name) VALUES (2, 'Ciencia Ficción');
INSERT INTO genres (id, name) VALUES (3, 'Fantasía');
INSERT INTO genres (id, name) VALUES (4, 'Terror');
INSERT INTO genres (id, name) VALUES (5, 'Romance');
INSERT INTO genres (id, name) VALUES (6, 'Misterio');
INSERT INTO genres (id, name) VALUES (7, 'Thriller');
INSERT INTO genres (id, name) VALUES (8, 'Poesía');
INSERT INTO genres (id, name) VALUES (9, 'Drama');
INSERT INTO genres (id, name) VALUES (10, 'Aventura');

-- migrate:down

DELETE FROM genres;