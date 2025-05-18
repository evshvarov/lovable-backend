Class dc.Sample.rest2.security Extends %RegisteredObject
{

ClassMethod SetupSecurity() As %Status
{
    Set tSC = $$$OK
    d ..IntroduceRoleLovable()
    d ..AddRole()
    ;d ..AddCORS()
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
    ;set MyAppProps("CorsAllowMethods")="GET,POST,PUT,DELETE,OPTIONS"
    #; set MyAppProps("CorsExposeHeaders")="Content-Type,Authorization,X-Requested-With,Accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers"
    #; set MyAppProps("CorsAllowCredentials")=1
    #; set MyAppProps("CorsMaxAge")=3600
    #; set MyAppProps("CorsAllowOrigin")="*"
    #; set MyAppProps("CorsAllowMethods")="GET,POST,PUT,DELETE,OPTIONS"
    #; set MyAppProps("CorsAllowHeaders")="Content-Type,Authorization,X-Requested-With,Accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers"
    #; set MyAppProps("CorsExposeHeaders")="Content-Type,Authorization,X-Requested-With,Accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers"
    set status=##class(Security.Applications).Modify(appname,.MyAppProps)

    // Announce success.
    if $$$ISOK(status) {
        write !, "Roles were successfully modified."
    }
    Quit status
}

}
