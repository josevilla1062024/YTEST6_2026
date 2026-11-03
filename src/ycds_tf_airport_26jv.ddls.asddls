@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - CDS with table Functions'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_TF_AIRPORT_26JV
  with parameters
    pClient : abap.clnt,
    pCity   : /dmo/city
  as select from /dmo/customer                                 as Customer
    inner join   YTF_AIRPORTS_26JV( pCity: $parameters.pCity ) as _ClientTest on _ClientTest.city = Customer.city
{
  key _ClientTest.airport_id as AirportId,
      _ClientTest.name       as Name,
      Customer.city          as City,
      Customer.first_name    as CustomerName,
      _ClientTest.country    as Country
}
