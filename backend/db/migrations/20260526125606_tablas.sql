-- migrate:up

PRAGMA foreign_keys = ON;

CREATE TABLE sexs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(20)
);

CREATE TABLE nationalities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    demonym VARCHAR(100)
);

CREATE TABLE device_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50)
);

CREATE TABLE publishers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    logo TEXT
);

CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100)
);

CREATE TABLE authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name VARCHAR(255),
    birth_date DATE,
    picture TEXT
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(40),
    password VARCHAR(90),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255),
    reset_key VARCHAR(50),
    status BOOLEAN,
    activation_key VARCHAR(50),
    birth_date DATE,
    profile_picture TEXT,
    sex_id INTEGER,
    nationality_id INTEGER,

    FOREIGN KEY (sex_id) REFERENCES sexs(id),
    FOREIGN KEY (nationality_id) REFERENCES nationalities(id)
);

CREATE TABLE devices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    brand VARCHAR(100),
    device_type_id INTEGER,
    user_id INTEGER,

    FOREIGN KEY (device_type_id) REFERENCES device_types(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255),
    isbn VARCHAR(20),
    pages INTEGER,
    publication_year INTEGER,
    edition_year INTEGER,
    synopsis VARCHAR(300),
    cover_image VARCHAR(100),
    pdf_url VARCHAR(100),
    publisher_id INTEGER,

    FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

CREATE TABLE reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rating SMALLINT,
    comment TEXT,
    review_date TIMESTAMP,
    user_id INTEGER,
    book_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE books_genres (
    book_id INTEGER,
    genre_id INTEGER,

    PRIMARY KEY (book_id, genre_id),

    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE books_authors (
    book_id INTEGER,
    author_id INTEGER,

    PRIMARY KEY (book_id, author_id),

    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- migrate:down

DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS books_genres;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS devices;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS device_types;
DROP TABLE IF EXISTS nationalities;
DROP TABLE IF EXISTS sexs;