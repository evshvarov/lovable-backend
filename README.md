# lovable-backend
This is a an example of InterSystems spec first REST API Backend for Lovable.dev frontend.

## Installation with ZPM

zpm:USER>install rest-api-template

## Installation for development

Create your repository from template.

Clone/git pull the repo into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):

```
$ git clone git@github.com:evshvarov/lovable-backend.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d --build
```

or open the folder in VSCode and do the following:
![rest](https://user-images.githubusercontent.com/2781759/78183327-63569800-7470-11ea-8561-c3b547ce9001.gif)


## How to Work With it

The app installs /crud2 web app with REST API built with the Spec First approach vs the following [spec](https://github.com/evshvarov/lovable-backend/blob/master/data/spec2.json), which introduces
CRUD methods vs persistent class [Person](https://github.com/evshvarov/lovable-backend/blob/master/src/dc/Sample/Person.cls)

The REST API could be found [here](https://github.com/evshvarov/lovable-backend/tree/master/src/dc/Sample/rest2).

Open http://localhost:52773/swagger-ui/index.html to test the REST API
And put http://localhost:52773/crud2/_spec in an Explore field


### Adding test data
THe app initially starts with 10 random records.

You can add more with:

```
USER>do ##class(dc.Sample.Person).AddTestData(10)
```
This will create 10 random records in dc.Sample.Person class.


## Frontend

There is a frontend built with Lovable which could be found [here](https://person-palace-ui.lovable.app/).
It points to a deployed demo backend of this repo [here](https://lovable-backend.demo.community.intersystems.com/crud2/persons).

Here is the [source code](https://github.com/evshvarov/person-palace-ui)

You can prompt-to-UI with [Lovable](lovable.dev) your own UI vs the [spec](https://github.com/evshvarov/lovable-backend/blob/master/data/spec2.json) and point it to http://localhost:52733/crud2 or where you have the REST API deployed.


