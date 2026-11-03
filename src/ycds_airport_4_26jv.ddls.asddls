@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS - Airport'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_AIRPORT_4_26JV
  as select from /dmo/airport
{
  key airport_id                           as AirportId,
      name                                 as Name,
      city                                 as City,
      country                              as Country,
      cast( '01' as yde_flight_type_26jv ) as FlightType
}
