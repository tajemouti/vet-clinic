/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD PRIMARY KEY (id),
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT species_fkey
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT owners_fkey
FOREIGN KEY (owner_id)
REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    CONSTRAINT vet_id_fkey
    FOREIGN KEY(vet_id)
    REFERENCES vets(id),
    CONSTRAINT species_id_fkey
    FOREIGN KEY(species_id)
    REFERENCES species(id)
);
