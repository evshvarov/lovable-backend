/// Dispatch class defined by RESTSpec in dc.Sample.rest2.spec
Class dc.Sample.rest2.disp Extends %CSP.REST [ GeneratedBy = dc.Sample.rest2.spec.cls, ProcedureBlock ]
{

/// The class containing the RESTSpec which generated this class
Parameter SpecificationClass = "dc.Sample.rest2.spec";

/// Ignore any writes done directly by the REST method.
Parameter IgnoreWrites = 1;

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <!-- Get all persons -->
  <Route Url="/persons" Method="get" Call="GetAllPersons" />
  <!-- Create a new person -->
  <Route Url="/persons" Method="post" Call="CreatePerson" />
  <!-- Get person by id -->
  <Route Url="/persons/:id" Method="get" Call="GetPersonById" />
  <!-- Update person by id -->
  <Route Url="/persons/:id" Method="put" Call="UpdatePersonById" />
  <!-- Delete person by id -->
  <Route Url="/persons/:id" Method="delete" Call="DeletePersonById" />
  <!-- Get OpenAPI specification -->
  <Route Url="/_spec" Method="get" Call="GetSpec" />
</Routes>
}

/// Get all persons
ClassMethod GetAllPersons() As %Status
{
    Try {
        Set response=##class(dc.Sample.rest2.impl).GetAllPersons()
        Do ##class(dc.Sample.rest2.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(dc.Sample.rest2.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

/// Create a new person
ClassMethod CreatePerson() As %Status
{
    Try {
        If $isobject(%request.Content) Set pperson=%request.Content
        Set response=##class(dc.Sample.rest2.impl).CreatePerson(.pperson)
        Do ##class(dc.Sample.rest2.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(dc.Sample.rest2.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

/// Get person by id
ClassMethod GetPersonById(pid As %String) As %Status
{
    Try {
        Set response=##class(dc.Sample.rest2.impl).GetPersonById(pid)
        Do ##class(dc.Sample.rest2.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(dc.Sample.rest2.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

/// Update person by id
ClassMethod UpdatePersonById(pid As %String) As %Status
{
    Try {
        If $isobject(%request.Content) Set pperson=%request.Content
        Set response=##class(dc.Sample.rest2.impl).UpdatePersonById(pid,.pperson)
        Do ##class(dc.Sample.rest2.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(dc.Sample.rest2.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

/// Delete person by id
ClassMethod DeletePersonById(pid As %String) As %Status
{
    Try {
        Set response=##class(dc.Sample.rest2.impl).DeletePersonById(pid)
        Do ##class(dc.Sample.rest2.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(dc.Sample.rest2.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

/// Get OpenAPI specification
ClassMethod GetSpec() As %Status
{
    Try {
        Set response=##class(dc.Sample.rest2.impl).GetSpec()
        Do ##class(dc.Sample.rest2.impl).%WriteResponse(response)
    } Catch (ex) {
        Try {
            Do ##class(dc.Sample.rest2.impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        } Catch {
            Do ##class(%REST.Impl).%ReportRESTError(..#HTTP500INTERNALSERVERERROR,ex.AsStatus(),$parameter("dc.Sample.rest2.impl","ExposeServerExceptions"))
        }
    }
    Quit $$$OK
}

}
