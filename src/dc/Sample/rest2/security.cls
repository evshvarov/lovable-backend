Class dc.Sample.rest2.security Extends %RegisteredObject
{

ClassMethod SetupSecurity() As %Status
{
    Set tSC = $$$OK
    d ..IntroduceRoleLovable()
    d ..AddRole()
    d ..AddCORS()
    d ..IntroduceRoleDBUSER()
    d ..AddDBUserRoleToUser()
    Quit tSC
}

ClassMethod IntroduceRoleLovable() As %Status
{
    &SQL(CREATE ROLE lovable)
    If SQLCODE '= 0 {
        Quit $$$ERROR($$$GeneralError, "Error creating role: "_SQLCODE)
    }
    &SQL(GRANT SELECT,INSERT,UPDATE,DELETE on dc_sample.person to lovable)
    If SQLCODE '= 0 {
        Quit $$$ERROR($$$GeneralError, "Error granting privileges: "_SQLCODE)
    }
    Quit $$$OK
}

ClassMethod IntroduceRoleDBUSER() As %Status
{
    &SQL(CREATE ROLE DB_USER_Read)
    If SQLCODE '= 0 {
        Quit $$$ERROR($$$GeneralError, "Error creating role: "_SQLCODE)
    }

    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"
    set properties("Resources")="%DB_USER:R"
 
    Set sc = ##class(Security.Roles).Modify("DB_USER_Read",.properties)
    If $$$ISERR(sc) {
        Quit $$$ERROR($$$GeneralError, "Error modifying role: "_sc)
    }
    return sc
}

ClassMethod AddDBUserRoleToUser(user = "CSPSystem", role = "DB_USER_Read") As %Status
{
    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"

    set status=##class(Security.Users).Get(user, .MyUserProps)
    set $p(MyUserProps("Roles"),",",*)=role
    set status=##class(Security.Users).Modify(user,.MyUserProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "Roles for the user "_user_" were successfully modified."
    }
    Quit status
}

ClassMethod AddRole(appname = "/crud2", approle = "lovable") As %Status
{
    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"

    set status=##class(Security.Applications).Get(appname, .MyAppProps)
    set MyAppProps("MatchRoles")=MyAppProps("MatchRoles")_":"_approle

    set status=##class(Security.Applications).Modify(appname,.MyAppProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "Roles were successfully modified."
    }
    Quit status
}

ClassMethod AddCORS(appname = "/crud2") As %Status
{
    // Change to the %SYS namespace.
    new $NAMESPACE
    set $NAMESPACE="%SYS"

    set status=##class(Security.Applications).Get(appname, .MyAppProps)
    set MyAppProps("CorsAllowlist")="*"
    set MyAppProps("CorsCredentialsAllowed")=1
    set MyAppProps("CorsHeadersList")="Content-Type,Authorization,X-Requested-With,Accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers"
    set status=##class(Security.Applications).Modify(appname,.MyAppProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "CORS methods were successfully added to."_appname
    }
    Quit status
}

}
