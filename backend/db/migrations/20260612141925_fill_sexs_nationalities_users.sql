-- migrate:up

-- SEXS
INSERT INTO sexs (id, name) VALUES
(1, 'Masculino'),
(2, 'Femenino');

-- NATIONALITIES
INSERT INTO nationalities (id, demonym) VALUES
(1, 'Peruano'),
(2, 'Argentino'),
(3, 'Chileno'),
(4, 'Colombiano'),
(5, 'Mexicano'),
(6, 'Ecuatoriano'),
(7, 'Boliviano'),
(8, 'Uruguayo'),
(9, 'Paraguayo'),
(10, 'Venezolano');

-- USERS
INSERT INTO users (id, username, password, first_name, last_name, email, reset_key, status, activation_key, birth_date, profile_picture, sex_id, nationality_id) VALUES (1, 'jlopez', '123456', 'Juan', 'Lopez', 'juan.lopez@example.com', NULL, 1, NULL, '1995-04-12', 'img/users/user1.jpg', 1, 1);

INSERT INTO users (id, username, password, first_name, last_name, email, reset_key, status, activation_key, birth_date, profile_picture, sex_id, nationality_id) VALUES (2, 'mgarcia', '123456', 'Maria', 'Garcia', 'maria.garcia@example.com', NULL, 1, NULL, '1998-09-21', 'img/users/user2.jpg', 2, 4);

INSERT INTO users (id, username, password, first_name, last_name, email, reset_key, status, activation_key, birth_date, profile_picture, sex_id, nationality_id) VALUES (3, 'cperez', '123456', 'Carlos', 'Perez', 'carlos.perez@example.com', NULL, 1, NULL, '1992-01-15', 'img/users/user3.jpg', 1, 2);

INSERT INTO users (id, username, password, first_name, last_name, email, reset_key, status, activation_key, birth_date, profile_picture, sex_id, nationality_id) VALUES (4, 'arodriguez', '123456', 'Ana', 'Rodriguez', 'ana.rodriguez@example.com', NULL, 1, NULL, '2000-06-30', 'img/users/user4.jpg', 2, 5);

INSERT INTO users (id, username, password, first_name, last_name, email, reset_key, status, activation_key, birth_date, profile_picture, sex_id, nationality_id) VALUES (5, 'lgomez', '123456', 'Luis', 'Gomez', 'luis.gomez@example.com', NULL, 1, NULL, '1997-11-08', 'img/users/user5.jpg', 1, 3);

-- migrate:down

DELETE FROM users;
DELETE FROM nationalities;
DELETE FROM sexs;
