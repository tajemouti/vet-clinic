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

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    CONSTRAINT animal_fkey
    FOREIGN KEY(animal_id)
    REFERENCES animals(id),
    CONSTRAINT vet_fkey
    FOREIGN KEY(vet_id)
    REFERENCES vets(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE owners ALTER COLUMN age DROP NOT NULL;

CREATE INDEX idx_animal_id ON visits(animal_id);
CREATE INDEX idx_vet_id ON visits(vet_id);
CREATE INDEX idx_email ON owners(email);
