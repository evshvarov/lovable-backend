Class dc.Sample.RealEstate Extends (%Persistent, %JSON.Adaptor)
{

/// Owner of the real estate unit
Property Owner As dc.Sample.Person [ Required ];

/// Friendly label (e.g. "Unit 12B")
Property Name As %VarString(MAXLEN = 200);

/// Street address or location descriptor
Property Address As %VarString(MAXLEN = 500);

/// Optional notes about the property
Property Notes As %VarString(MAXLEN = 2000);

Storage Default
{
<Data name="RealEstateDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Owner</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Address</Value>
</Value>
<Value name="5">
<Value>Notes</Value>
</Value>
</Data>
<DataLocation>^dc.Sample.RealEstateD</DataLocation>
<DefaultData>RealEstateDefaultData</DefaultData>
<IdLocation>^dc.Sample.RealEstateD</IdLocation>
<IndexLocation>^dc.Sample.RealEstateI</IndexLocation>
<StreamLocation>^dc.Sample.RealEstateS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
