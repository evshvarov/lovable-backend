/// Business logic class defined by OpenAPI in dc.Sample.rest2.spec<br/>
/// Created Apr 23, 2025 08:57:44
Class dc.Sample.rest2.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Get all persons
ClassMethod GetAllPersons() As %Stream.Object
{
    set rset = ##class(dc.Sample.Person).ExtentFunc()
     if rset.%SQLCODE<0 {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", rset.%Message)
        return ""
    }
    set dynArray = [].%New()
    While rset.%Next() {
        do ##class(dc.Sample.Person).%OpenId(rset.ID).%JSONExportToString(.myPerson)
        Set dynObj = {}.%FromJSON(myPerson)
        do dynArray.%Push(dynObj)
    }
    return dynArray
}

/// Create a new person<br/>
/// The method arguments hold values for:<br/>
///     person<br/>
ClassMethod CreatePerson(person As %Stream.Object) As %Stream.Object
{
    set personObj = ##class(dc.Sample.Person).%New()
    set status = personObj.%JSONImport(person)
    if $$$ISERR(status) {
        d ..%SetStatusCode(400)
        d ..%SetHeader("Content-Type", "application/json")
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }


    set status = personObj.%Save()
    if $$$ISERR(status) {
        d ..%SetStatusCode(500)
        d ..%SetHeader("Content-Type", "application/json")
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }
    d ..%SetStatusCode(201)
    return person
}

/// Get person by id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod GetPersonById(id As %String) As %Stream.Object
{
    set person = ##class(dc.Sample.Person).%OpenId(id)
    if person = "" {
        d ..%SetStatusCode(404)
        return ""
    }

    Set sc=person.%JSONExportToString(.json), dynObj = {}.%FromJSON(json)
	return dynObj
}

/// Update person by id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     person<br/>
ClassMethod UpdatePersonById(id As %String, person As %Stream.Object) As %Stream.Object
{
    set personObj = ##class(dc.Sample.Person).%OpenId(id)
    if personObj = "" {
        d ..%SetStatusCode(404)
        d ..%SetHeader("X-Error", "Person not found")
        return ""
    }
    set status = personObj.%JSONImport(person)
    if $$$ISERR(status) {
        d ..%SetStatusCode(400)
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }
    set status = personObj.%Save()
    if $$$ISERR(status) {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }
    d ..%SetStatusCode(200)
    return person
}

/// Delete person by id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod DeletePersonById(id As %String) As %Stream.Object
{
    set sc=##class(dc.Sample.Person).%DeleteId(id)
    if $$$ISERR(sc) {
        d ..%SetStatusCode(404)

        return ""
    }
    d ..%SetStatusCode(204)
    return {}
}

/// Get OpenAPI specification
ClassMethod GetSpec() As %Stream.Object
{
    set specname=$p(..%ClassName(1),".impl")
    Set spec = {}.%FromJSON(##class(%Dictionary.CompiledXData).%OpenId(specname_".spec||OpenAPI").Data)
	Set url = $Select(%request.Secure:"https",1:"http") _ "://"_$Get(%request.CgiEnvs("SERVER_NAME")) _ ":" _ $Get(%request.CgiEnvs("SERVER_PORT")) _ %request.Application
	Set spec.servers = [{"url" : (url)}]
	Quit spec
}

}
