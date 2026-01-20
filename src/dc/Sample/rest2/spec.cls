Class dc.Sample.rest2.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger":"2.0",
  "info":{
    "title":"Person API",
    "version":"1.0.0"
  },
  "basePath": "/crud2",
  "paths":{
    "/persons":{
      "get":{
        "summary":"Get all persons",
        "operationId":"GetAllPersons",
        "responses":{
          "200":{
            "description":"A list of persons",
            "schema":{
              "type":"array",
              "items":{
                "$ref":"#/definitions/Person"
              }
            }
          }
        }
      },
      "post":{
        "summary":"Create a new person",
        "operationId":"CreatePerson",
        "parameters":[
          {
            "in":"body",
            "name":"person",
            "schema":{
              "$ref":"#/definitions/PersonCreate"
            }
          }
        ],
        "responses":{
          "201":{
            "description":"Person created",
            "schema":{
              "$ref":"#/definitions/Person"
            }
          }
        }
      }
    },
    "/persons/{id}":{
      "get":{
        "summary":"Get person by id",
        "operationId":"GetPersonById",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"Person details",
            "schema":{
              "$ref":"#/definitions/Person"
            }
          },
          "404":{
            "description":"Person not found"
          }
        }
      },
      "put":{
        "summary":"Update person by id",
        "operationId":"UpdatePersonById",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          },
          {
            "in":"body",
            "name":"person",
            "schema":{
              "$ref":"#/definitions/PersonUpdate"
            }
          }
        ],
        "responses":{
          "200":{
            "description":"Person updated",
            "schema":{
              "$ref":"#/definitions/Person"
            }
          },
          "404":{
            "description":"Person not found"
          }
        }
      },
      "delete":{
        "summary":"Delete person by id",
        "operationId":"DeletePersonById",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          }
        ],
        "responses":{
          "204":{
            "description":"Person deleted"
          },
          "404":{
            "description":"Person not found"
          }
        }
      }
    },
    "/persons/{id}/properties":{
      "get":{
        "summary":"List properties for a person",
        "operationId":"GetPersonProperties",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"A list of properties",
            "schema":{
              "type":"array",
              "items":{
                "$ref":"#/definitions/RealEstate"
              }
            }
          },
          "404":{
            "description":"Person not found"
          }
        }
      },
      "post":{
        "summary":"Add property to a person",
        "operationId":"AddPropertyToPerson",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          },
          {
            "in":"body",
            "name":"property",
            "schema":{
              "$ref":"#/definitions/RealEstateCreate"
            }
          }
        ],
        "responses":{
          "201":{
            "description":"Property created",
            "schema":{
              "$ref":"#/definitions/RealEstate"
            }
          },
          "404":{
            "description":"Person not found"
          }
        }
      }
    },
    "/properties":{
      "get":{
        "summary":"Get all properties",
        "operationId":"GetAllProperties",
        "responses":{
          "200":{
            "description":"A list of properties",
            "schema":{
              "type":"array",
              "items":{
                "$ref":"#/definitions/RealEstate"
              }
            }
          }
        }
      },
      "post":{
        "summary":"Create a new property",
        "operationId":"CreateProperty",
        "parameters":[
          {
            "in":"body",
            "name":"property",
            "schema":{
              "$ref":"#/definitions/RealEstateCreate"
            }
          }
        ],
        "responses":{
          "201":{
            "description":"Property created",
            "schema":{
              "$ref":"#/definitions/RealEstate"
            }
          }
        }
      }
    },
    "/properties/{id}":{
      "get":{
        "summary":"Get property by id",
        "operationId":"GetPropertyById",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          }
        ],
        "responses":{
          "200":{
            "description":"Property details",
            "schema":{
              "$ref":"#/definitions/RealEstate"
            }
          },
          "404":{
            "description":"Property not found"
          }
        }
      },
      "put":{
        "summary":"Update property by id",
        "operationId":"UpdatePropertyById",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          },
          {
            "in":"body",
            "name":"property",
            "schema":{
              "$ref":"#/definitions/RealEstateUpdate"
            }
          }
        ],
        "responses":{
          "200":{
            "description":"Property updated",
            "schema":{
              "$ref":"#/definitions/RealEstate"
            }
          },
          "404":{
            "description":"Property not found"
          }
        }
      },
      "delete":{
        "summary":"Delete property by id",
        "operationId":"DeletePropertyById",
        "parameters":[
          {
            "name":"id",
            "in":"path",
            "required":true,
            "type":"string"
          }
        ],
        "responses":{
          "204":{
            "description":"Property deleted"
          },
          "404":{
            "description":"Property not found"
          }
        }
      }
    },
    "/_spec":{
      "get":{
        "summary":"Get OpenAPI specification",
        "operationId":"GetSpec",
        "responses":{
          "200":{
            "description":"OpenAPI specification",
            "schema":{
              "type":"object"
            }
          }
        }
      }
    }
  },
  "definitions":{
    "Person":{
      "type":"object",
      "properties":{
        "id":{
          "type":"string",
          "description":"Unique identifier (PUBLICROWID)"
        },
        "Company":{
          "type":"string",
          "maxLength":50
        },
        "DOB":{
          "type":"string",
          "format":"date"
        },
        "Name":{
          "type":"string"
        },
        "Phone":{
          "type":"string"
        },
        "Title":{
          "type":"string",
          "maxLength":50
        }
      }
    },
    "PersonCreate":{
      "type":"object",
      "required":[
        "Name"
      ],
      "properties":{
        "Company":{
          "type":"string",
          "maxLength":50
        },
        "DOB":{
          "type":"string",
          "format":"date"
        },
        "Name":{
          "type":"string"
        },
        "Phone":{
          "type":"string"
        },
        "Title":{
          "type":"string",
          "maxLength":50
        }
      }
    },
    "PersonUpdate":{
      "type":"object",
      "properties":{
        "Company":{
          "type":"string",
          "maxLength":50
        },
        "DOB":{
          "type":"string",
          "format":"date"
        },
        "Name":{
          "type":"string"
        },
        "Phone":{
          "type":"string"
        },
        "Title":{
          "type":"string",
          "maxLength":50
        }
      }
    },
    "RealEstate":{
      "type":"object",
      "properties":{
        "id":{
          "type":"string",
          "description":"Unique identifier (PUBLICROWID)"
        },
        "OwnerId":{
          "type":"string",
          "description":"Person id"
        },
        "Name":{
          "type":"string",
          "maxLength":200
        },
        "Address":{
          "type":"string",
          "maxLength":500
        },
        "Notes":{
          "type":"string",
          "maxLength":2000
        }
      }
    },
    "RealEstateCreate":{
      "type":"object",
      "required":[
        "OwnerId",
        "Name"
      ],
      "properties":{
        "OwnerId":{
          "type":"string",
          "description":"Person id"
        },
        "Name":{
          "type":"string",
          "maxLength":200
        },
        "Address":{
          "type":"string",
          "maxLength":500
        },
        "Notes":{
          "type":"string",
          "maxLength":2000
        }
      }
    },
    "RealEstateUpdate":{
      "type":"object",
      "properties":{
        "OwnerId":{
          "type":"string",
          "description":"Person id"
        },
        "Name":{
          "type":"string",
          "maxLength":200
        },
        "Address":{
          "type":"string",
          "maxLength":500
        },
        "Notes":{
          "type":"string",
          "maxLength":2000
        }
      }
    }
  }
}
}

}
