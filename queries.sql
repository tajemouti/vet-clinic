/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE escape_attempts < 3 AND neutered = true;
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu') ;
SELECT (name, escape_attempts) from animals WHERE weight_kg > 10.50;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.40 AND 17.30;