Class dc.Sample.rest2.spec Extends %REST.Spec [ ProcedureBlock ]
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

ClassMethod OnPreDispatch(pUrl As %String, pMethod As %String, ByRef pContinue As %Boolean) As %Status
{
	do %response.SetHeader("Access-Control-Allow-Origin", "*")
	do %response.SetHeader("Allow-Access-Control-Credentials", 1)
	do %response.SetHeader("Access-Control-Allow-Headers", "X-Requested-With")
	do %response.SetHeader("X-Requested-With", "XMLHttpRequestXMLHttpRequest")
	do %response.SetHeader("Access-Control-Allow-Headers","Content-Type, Authorization, Accept-Language, X-Requested-With, session")

	set debug =  %request.Get("debug")
	if (debug = "1") {
		zwrite %request
	}
	quit $$$OK
}

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
    }
  }
}
}

}
