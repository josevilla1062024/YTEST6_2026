@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Root View City'
@Metadata.ignorePropagatedAnnotations: true
define root view entity YCDS_ROOT_AIRPOT_26JV
  as select from /dmo/airport
  association [1..1] to YCDS_CITY_ASSOC_26JV as _Text on _Text.City = $projection.City

{
  key airport_id as AirportId,
      name       as Name,
      city       as City,
      country    as Country,
      _Text
}
