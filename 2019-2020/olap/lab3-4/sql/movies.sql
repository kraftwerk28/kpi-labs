CREATE TABLE IF NOT EXISTS movies (
  imdb_title_id VARCHAR(9),
  title VARCHAR(128),
  original_title VARCHAR(128),
  year INT,
  date_published TIMESTAMP,
  duration INT,
  avg_vote FLOAT,
  votes INT,
  reviews_from_users FLOAT,
  reviews_from_critics FLOAT,
  country_id INT,
  lang_id INT,
  director_id INT,
  company_id INT
);

CREATE TABLE IF NOT EXISTS countries (
  country_id SERIAL,
  country_name VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS languages (
  country_id SERIAL,
  country_name VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS directors (
    director_id INT,
    director_name VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS writers (
    writer_id INT,
    writer_name VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS writers_movies (
    movie_id VARCHAR(64)
        REFERENCES movies(imdb_title_id)
        ON DELETE CASCADE,
    writer_id INT
        REFERENCES writers(writer_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS companies (
    company_id INT,
    company_name VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS actors (
    actor_id INT,
    actor_name VARCHAR(64)
);

CREATE TABLE actors_movies (
    movie_id VARCHAR(64)
        REFERENCES movies(imdb_title_id)
        ON DELETE CASCADE,
    actor_id INT
        REFERENCES actors(actor_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS names (
    imdb_name_id 'nm0000100',
    name 'Rowan Atkinson',
    birth_name 'Rowan Sebastian Atkinson',
    height '181.0',
    bio `Rowan `,
    birth_details 'January 6, 1955 in Consett, County Durham, England, UK',
    birth_year '1955.0',
    date_of_birth '1955-01-06',
    place_of_birth 'Consett, County Durham, England, UK',
    death_details '',
    death_year '',
    date_of_death '',
    place_of_death '',
    reason_of_death '',
    spouses '1',
    divorces '1',
    spouses_with_children '1',
    children '2',
    primary_profession 'actor,writer,soundtrack'
);

CREATE TABLE IF NOT EXISTS names_movies (
    name_id VARCHAR(64),
    movie_id VARCHAR(64)
);

