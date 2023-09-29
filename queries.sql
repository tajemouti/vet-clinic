/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE escape_attempts < 3 AND neutered = true;
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu') ;
SELECT (name, escape_attempts) from animals WHERE weight_kg > 10.50;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.40 AND 17.30;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg),MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT a.name FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name FROM animals AS a
JOIN species AS s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name AS animal_name FROM owners AS o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name AS species_name, COUNT(a.id) AS animal_count FROM species AS s
LEFT JOIN animals AS a ON s.id = a.species_id
GROUP BY s.name;

SELECT a.name FROM animals AS a
INNER JOIN species AS s ON a.species_id = s.id
INNER JOIN owners AS o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name FROM animals AS a
INNER JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) AS animal_count FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id 
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

SELECT a.name FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS v2 ON v.vet_id = v2.id
WHERE v2.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) FROM visits AS v
JOIN vets AS v2 ON v.vet_id = v2.id
WHERE v2.name = 'Stephanie Mendez';

SELECT v.name, COALESCE(s.name, 'No Specialty') AS specialty FROM vets AS v
LEFT JOIN specializations AS sp ON v.id = sp.vet_id
LEFT JOIN species AS s ON sp.species_id = s.id;

SELECT a.name FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS v2 ON v.vet_id = v2.id
WHERE v2.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(*) AS visit_count FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT v2.name AS vet_name, a.name AS animal_name, v.visit_date FROM visits AS v
JOIN vets AS v2 ON v.vet_id = v2.id
JOIN animals AS a ON v.animal_id = a.id
ORDER BY v.visit_date
LIMIT 1;

SELECT a.name AS animal_name, v2.name AS vet_name, v.visit_date FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS v2 ON v.vet_id = v2.id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS mismatched_specialization FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS v2 ON v.vet_id = v2.id
LEFT JOIN specializations AS sp ON v2.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

SELECT s.name AS recommended_specialization, COUNT(*) AS visit_count FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN species AS s ON a.species_id = s.id
JOIN vets AS v2 ON v.vet_id = v2.id
WHERE v2.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;