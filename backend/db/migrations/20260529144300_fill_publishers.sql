-- migrate:up

INSERT INTO publishers (id, name, logo) 
VALUES (1, 'Penguin Random House', 'https://example.com/logos/penguin.png');

INSERT INTO publishers (id, name, logo) 
VALUES (2, 'HarperCollins', '/assets/img/logos/harpercollins.jpg');

INSERT INTO publishers (id, name, logo) 
VALUES (3, 'Planeta', 'https://example.com/logos/planeta.svg');

INSERT INTO publishers (id, name, logo) 
VALUES (4, 'Anagrama', NULL);

INSERT INTO publishers (id, name, logo) 
VALUES (5, 'Alianza Editorial', '/static/uploads/alianza.png');

-- migrate:down

DELETE FROM publishers;