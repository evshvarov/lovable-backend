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

/// Get all properties
ClassMethod GetAllProperties() As %Stream.Object
{
    set rset = ##class(dc.Sample.RealEstate).ExtentFunc()
    if rset.%SQLCODE<0 {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", rset.%Message)
        return ""
    }
    set dynArray = [].%New()
    while rset.%Next() {
        set propertyObj = ##class(dc.Sample.RealEstate).%OpenId(rset.ID)
        if propertyObj'="" {
            set dynObj = ..BuildRealEstateResponse(propertyObj)
            //do ##class(dc.Sample.Person).%OpenId(rset.ID).%JSONExportToString(.myPerson)
            do dynArray.%Push(dynObj)
        }
    }
    return dynArray
}

/// Create a new property<br/>
/// The method arguments hold values for:<br/>
///     property<br/>
ClassMethod CreateProperty(property As %Stream.Object) As %Stream.Object
{
    set dynObj = ..ReadRealEstateBody(property)
    if dynObj = "" {
        d ..%SetStatusCode(400)
        d ..%SetHeader("X-Error", "Invalid JSON")
        return ""
    }
    set ownerId = ""
    if dynObj.%IsDefined("OwnerId") {
        set ownerId = dynObj.OwnerId
    }
    if ownerId = "" {
        d ..%SetStatusCode(400)
        d ..%SetHeader("X-Error", "OwnerId required")
        return ""
    }
    set ownerObj = ##class(dc.Sample.Person).%OpenId(ownerId)
    if ownerObj = "" {
        d ..%SetStatusCode(404)
        d ..%SetHeader("X-Error", "Person not found")
        return ""
    }

    set propertyObj = ##class(dc.Sample.RealEstate).%New()
    set propertyObj.Owner = ownerObj
    if dynObj.%IsDefined("Name") {
        set propertyObj.Name = dynObj.Name
    }
    if dynObj.%IsDefined("Address") {
        set propertyObj.Address = dynObj.Address
    }
    if dynObj.%IsDefined("Notes") {
        set propertyObj.Notes = dynObj.Notes
    }
    set status = propertyObj.%Save()
    if $$$ISERR(status) {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }
    d ..%SetStatusCode(201)
    return ..BuildRealEstateResponse(propertyObj)
}

/// Get property by id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod GetPropertyById(id As %String) As %Stream.Object
{
    set propertyObj = ##class(dc.Sample.RealEstate).%OpenId(id)
    if propertyObj = "" {
        d ..%SetStatusCode(404)
        return ""
    }
    return ..BuildRealEstateResponse(propertyObj)
}

/// Update property by id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     property<br/>
ClassMethod UpdatePropertyById(id As %String, property As %Stream.Object) As %Stream.Object
{
    set propertyObj = ##class(dc.Sample.RealEstate).%OpenId(id)
    if propertyObj = "" {
        d ..%SetStatusCode(404)
        d ..%SetHeader("X-Error", "Property not found")
        return ""
    }
    set dynObj = ..ReadRealEstateBody(property)
    if dynObj = "" {
        d ..%SetStatusCode(400)
        d ..%SetHeader("X-Error", "Invalid JSON")
        return ""
    }
    if dynObj.%IsDefined("OwnerId") {
        set ownerId = dynObj.OwnerId
        if ownerId'="" {
            set ownerObj = ##class(dc.Sample.Person).%OpenId(ownerId)
            if ownerObj = "" {
                d ..%SetStatusCode(404)
                d ..%SetHeader("X-Error", "Person not found")
                return ""
            }
            set propertyObj.Owner = ownerObj
        }
    }
    if dynObj.%IsDefined("Name") {
        set propertyObj.Name = dynObj.Name
    }
    if dynObj.%IsDefined("Address") {
        set propertyObj.Address = dynObj.Address
    }
    if dynObj.%IsDefined("Notes") {
        set propertyObj.Notes = dynObj.Notes
    }
    set status = propertyObj.%Save()
    if $$$ISERR(status) {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }
    d ..%SetStatusCode(200)
    return ..BuildRealEstateResponse(propertyObj)
}

/// Delete property by id<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod DeletePropertyById(id As %String) As %Stream.Object
{
    set sc=##class(dc.Sample.RealEstate).%DeleteId(id)
    if $$$ISERR(sc) {
        d ..%SetStatusCode(404)
        return ""
    }
    d ..%SetStatusCode(204)
    return {}
}

/// List properties for a person<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
ClassMethod GetPersonProperties(id As %String) As %Stream.Object
{
    set personObj = ##class(dc.Sample.Person).%OpenId(id)
    if personObj = "" {
        d ..%SetStatusCode(404)
        d ..%SetHeader("X-Error", "Person not found")
        return ""
    }
    set rset = ##class(dc.Sample.RealEstate).ExtentFunc()
    if rset.%SQLCODE<0 {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", rset.%Message)
        return ""
    }
    set dynArray = [].%New()
    while rset.%Next() {
        set propertyObj = ##class(dc.Sample.RealEstate).%OpenId(rset.ID)
        if propertyObj'="",propertyObj.Owner'="" {
            if propertyObj.Owner.%Id() = id {
                set dynObj = ..BuildRealEstateResponse(propertyObj)
                do dynArray.%Push(dynObj)
            }
        }
    }
    return dynArray
}

/// Add property to a person<br/>
/// The method arguments hold values for:<br/>
///     id<br/>
///     property<br/>
ClassMethod AddPropertyToPerson(id As %String, property As %Stream.Object) As %Stream.Object
{
    set personObj = ##class(dc.Sample.Person).%OpenId(id)
    if personObj = "" {
        d ..%SetStatusCode(404)
        d ..%SetHeader("X-Error", "Person not found")
        return ""
    }
    set dynObj = ..ReadRealEstateBody(property)
    if dynObj = "" {
        d ..%SetStatusCode(400)
        d ..%SetHeader("X-Error", "Invalid JSON")
        return ""
    }
    set propertyObj = ##class(dc.Sample.RealEstate).%New()
    set propertyObj.Owner = personObj
    if dynObj.%IsDefined("Name") {
        set propertyObj.Name = dynObj.Name
    }
    if dynObj.%IsDefined("Address") {
        set propertyObj.Address = dynObj.Address
    }
    if dynObj.%IsDefined("Notes") {
        set propertyObj.Notes = dynObj.Notes
    }
    set status = propertyObj.%Save()
    if $$$ISERR(status) {
        d ..%SetStatusCode(500)
        d ..%SetHeader("X-Error", status.%Message())
        return status
    }
    d ..%SetStatusCode(201)
    return ..BuildRealEstateResponse(propertyObj)
}

ClassMethod ReadRealEstateBody(property As %Stream.Object) As %DynamicObject
{
    if '$IsObject(property) {
        quit ""
    }
    do property.Rewind()
    set json = ""
    while 'property.AtEnd {
        set json = json _ property.Read(32000)
    }
    if json = "" {
        quit ""
    }
    set dynObj = {}.%FromJSON(json)
    if '$IsObject(dynObj) {
        quit ""
    }
    quit dynObj
}

ClassMethod BuildRealEstateResponse(propertyObj As dc.Sample.RealEstate) As %DynamicObject
{
    set dynObj = {}.%New()
    set dynObj.id = propertyObj.%Id()
    if propertyObj.Owner'="" {
        set dynObj.OwnerId = propertyObj.Owner.%Id()
    }
    set dynObj.Name = propertyObj.Name
    set dynObj.Address = propertyObj.Address
    set dynObj.Notes = propertyObj.Notes
    quit dynObj
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
