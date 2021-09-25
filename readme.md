# Dark Souls Dataset

Data set for the [Darksouls Explorer Backend](https://github.com/Bernardo-MG/darksouls-explorer-dataset-backend).

Most of the data was extracted with the [Dark Souls Wiki Scrapper](https://github.com/Bernardo-MG/darksouls-wiki-scrapper), from the [Dark Souls Wiki](https://darksouls.fandom.com/).

## Features

- Cypher scripts to load into Neo4j

## Usage

Just copy all the files into Neo4j's import folder and run these scripts:

- darksouls_1/import.cypher
- darksouls_1/postprocess.cypher

### Docker image

Alternatively, a Docker compose file is included.

```
docker-compose -f docker/docker-compose.yml up
```

Afterwards the database will be accessible locally for the user neo4j/secret.

## Collaborate

Any kind of help with the project will be well received, and there are two main ways to give such help:

- Reporting errors and asking for extensions through the issues management
- or forking the repository and extending the project

### Issues management

Issues are managed at the GitHub [project issues tracker][issues], where any Github user may report bugs or ask for new features.

### Getting the code

If you wish to fork or modify the code, visit the [GitHub project page][scm], where the latest versions are always kept. Check the 'master' branch for the latest release, and the 'develop' for the current, and stable, development version.

## License

The project has been released under the [MIT License][license].

[issues]: https://github.com/Bernardo-MG/darksouls-explorer-dataset/issues
[license]: https://www.opensource.org/licenses/mit-license.php
[scm]: https://github.com/Bernardo-MG/darksouls-explorer-dataset
