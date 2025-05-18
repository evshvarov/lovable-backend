Class dc.Sample.rest2.cors Extends %CSP.REST
{

ClassMethod OnHandleCorsRequest(url As %String) As %Status
{
    ;Do %response.SetHeader("Access-Control-Allow-Origin","*")
    ;do %response.SetHeader("Allow-Access-Control-Credentials", 1)
	do %response.SetHeader("Access-Control-Allow-Headers", "X-Requested-With")
	do %response.SetHeader("X-Requested-With", "XMLHttpRequestXMLHttpRequest")
	;do %response.SetHeader("Access-Control-Allow-Headers","Content-Type, Authorization, Accept-Language, X-Requested-With, session")
    do %response.SetHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
    q $$$OK
}

}
