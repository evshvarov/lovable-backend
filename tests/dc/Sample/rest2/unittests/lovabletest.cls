Class dc.Sample.rest2.unittests.lovabletest Extends %UnitTest.TestCase [ ProcedureBlock ]
{

Property CreatedIds As %ListOfDataTypes;

Method SetUp() As %Status
{
    set ..CreatedIds = ""
    do ..InitRestContext()
    quit $$$OK
}

Method TearDown() As %Status
{
    set i = 1
    for {
        set id = $List(..CreatedIds, i)
        quit:(id = "")
        set sc = ##class(dc.Sample.Person).%DeleteId(id)
        set i = i + 1
    }
    quit $$$OK
}

Method TestGetAllPersons() As %Status
{
    do ..InitRestContext()
    set name = ..NewTestName()
    set id = ..CreatePersonFixture(name)
    do ..AddCreatedId(id)

    set result = ##class(dc.Sample.rest2.impl).GetAllPersons()
    do $$$AssertTrue(result.%Size() > 0)

    set found = 0
    for i = 1:1:result.%Size() {
        if result.%Get(i).Name = name {
            set found = 1
            quit
        }
    }
    do $$$AssertTrue(found = 1)
    quit $$$OK
}

Method TestCreatePerson() As %Status
{
    do ..InitRestContext()
    set name = ..NewTestName()
    set stream = ..BuildPersonStream(name)

    set result = ##class(dc.Sample.rest2.impl).CreatePerson(stream)
    set id = ..FindPersonIdByName(name)
    do $$$AssertNotEquals("", id)
    do ..AddCreatedId(id)
    do $$$AssertTrue($IsObject(result))
    quit $$$OK
}

Method TestGetPersonById() As %Status
{
    do ..InitRestContext()
    set name = ..NewTestName()
    set id = ..CreatePersonFixture(name)
    do ..AddCreatedId(id)

    set person = ##class(dc.Sample.rest2.impl).GetPersonById(id)
    do $$$AssertEquals(name, person.Name)
    quit $$$OK
}

Method TestUpdatePersonById() As %Status
{
    do ..InitRestContext()
    set name = ..NewTestName()
    set id = ..CreatePersonFixture(name)
    do ..AddCreatedId(id)

    set newName = ..NewTestName()
    set stream = ..BuildPersonStream(newName)

    do ##class(dc.Sample.rest2.impl).UpdatePersonById(id, stream)
    set person = ##class(dc.Sample.Person).%OpenId(id)
    do $$$AssertEquals(newName, person.Name)
    quit $$$OK
}

Method TestDeletePersonById() As %Status
{
    do ..InitRestContext()
    set name = ..NewTestName()
    set id = ..CreatePersonFixture(name)
    do ..AddCreatedId(id)

    do ##class(dc.Sample.rest2.impl).DeletePersonById(id)
    set person = ##class(dc.Sample.Person).%OpenId(id)
    do $$$AssertEquals("", person)
    quit $$$OK
}

Method TestGetSpec() As %Status
{
    do ..InitRestContext()
    set spec = ##class(dc.Sample.rest2.impl).GetSpec()
    do $$$AssertEquals("Person API", spec.info.title)
    do $$$AssertTrue(spec.servers.%Size() > 0)
    //do $$$AssertTrue($Find(spec.servers.%Get(0).url, "/crud2") > 0)
    quit $$$OK
}

Method InitRestContext()
{
    if '$data(%request) {
        set %request = ##class(%CSP.Request).%New()
    }
    if '$data(%response) {
        set %response = ##class(%CSP.Response).%New()
    }
    //set %request.Secure = 0
    //set %request.Application = "/crud2"
    set %request.CgiEnvs("SERVER_NAME") = "localhost"
    set %request.CgiEnvs("SERVER_PORT") = "52773"
}

Method NewTestName() As %String
{
    quit "lovable-test-"_$System.Util.CreateGUID()
}

Method BuildPersonStream(name As %String, title As %String = "Engineer", company As %String = "Acme", phone As %String = "555-0100", dob As %String = "1980-01-01") As %Stream.Object
{
    set dyn = {}.%New()
    set dyn.Name = name
    set dyn.Title = title
    set dyn.Company = company
    set dyn.Phone = phone
    set dyn.DOB = dob

    set json = dyn.%ToJSON()
    set stream = ##class(%Stream.GlobalCharacter).%New()
    do stream.Write(json)
    do stream.Rewind()
    quit stream
}

Method CreatePersonFixture(name As %String) As %String
{
    set person = ##class(dc.Sample.Person).%New()
    set person.Name = name
    set person.Title = "Engineer"
    set person.Company = "Acme"
    set person.Phone = "555-0100"
    set person.DOB = $ZDATEH("1980-01-01", 3)

    set sc = person.%Save()
    if $$$ISERR(sc) {
        quit ""
    }
    quit person.%Id()
}

Method FindPersonIdByName(name As %String) As %String
{
    set id = ""
    set rset = ##class(dc.Sample.Person).ExtentFunc()
    while rset.%Next() {
        set person = ##class(dc.Sample.Person).%OpenId(rset.ID)
        if person.Name = name {
            set id = rset.ID
            quit
        }
    }
    quit id
}

Method AddCreatedId(id As %String)
{
    if id'="" {
        set ..CreatedIds = $ListBuild(..CreatedIds, id)
    }
}

}
