-- 1. Resetar o banco de dados (Cuidado: apaga o anterior se existir)
DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;
\c universe

-- 2. Tabela GALAXY
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    distance_light_years INT NOT NULL,
    is_spiral BOOLEAN NOT NULL,
    has_black_hole BOOLEAN DEFAULT TRUE
);

-- 3. Tabela STAR
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
    temperature_kelvin INT NOT NULL,
    mass_solar_masses NUMERIC(10,2)
);

-- 4. Tabela PLANET
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    star_id INT REFERENCES star(star_id) NOT NULL,
    has_life BOOLEAN DEFAULT FALSE,
    orbital_period_days INT NOT NULL
);

-- 5. Tabela MOON
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    planet_id INT REFERENCES planet(planet_id) NOT NULL,
    is_spherical BOOLEAN DEFAULT TRUE,
    diameter_km INT NOT NULL
);

-- 6. Tabela Adicional: GALAXY_TYPE (Para cumprir a regra de 5 tabelas)
CREATE TABLE galaxy_type (
    galaxy_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL
);

-- 7. INSERÇÃO DE DADOS (Mínimos exigidos para passar nos testes)

-- Galáxias (Mínimo 6)
INSERT INTO galaxy (name, distance_light_years, is_spiral) VALUES 
('Milky Way', 0, true), ('Andromeda', 2537000, true), ('Triangulum', 3000000, true), 
('Sombrero', 29000000, true), ('Centaurus A', 13000000, false), ('Bode', 12000000, true);

-- Estrelas (Mínimo 6)
INSERT INTO star (name, galaxy_id, temperature_kelvin, mass_solar_masses) VALUES 
('Sun', 1, 5778, 1.0), ('Sirius', 1, 9940, 2.0), ('Proxima Centauri', 1, 3042, 0.12),
('Betelgeuse', 1, 3500, 11.6), ('Vega', 1, 9600, 2.1), ('Rigel', 1, 12100, 21.0);

-- Planetas (Mínimo 12)
INSERT INTO planet (name, star_id, has_life, orbital_period_days) VALUES 
('Earth', 1, true, 365), ('Mars', 1, false, 687), ('Jupiter', 1, false, 4333), 
('Venus', 1, false, 225), ('Mercury', 1, false, 88), ('Saturn', 1, false, 10759), 
('Uranus', 1, false, 30687), ('Neptune', 1, false, 60190), ('Kepler-186f', 3, true, 130), 
('Proxima b', 3, false, 11), ('Gliese 581g', 2, true, 37), ('Osiris', 4, false, 3);

-- Luas (Mínimo 20)
INSERT INTO moon (name, planet_id, diameter_km) VALUES 
('Moon', 1, 3474), ('Phobos', 2, 22), ('Deimos', 2, 12), ('Io', 3, 3642), 
('Europa', 3, 3121), ('Ganymede', 3, 5268), ('Callisto', 3, 4820), ('Titan', 6, 5150), 
('Enceladus', 6, 504), ('Mimas', 6, 396), ('Triton', 8, 2706), ('Charon', 7, 1212), 
('Oberon', 7, 1522), ('Titania', 7, 1577), ('Umbriel', 7, 1169), ('Ariel', 7, 1157),
('Proteus', 8, 420), ('Nereid', 8, 340), ('Larissa', 8, 194), ('Despina', 8, 150);

-- Tipos de Galáxia (Mínimo 3)
INSERT INTO galaxy_type (name, description) VALUES 
('Spiral', 'Disk-shaped with spiral arms'), 
('Elliptical', 'Smooth and featureless'), 
('Irregular', 'No distinct shape');
