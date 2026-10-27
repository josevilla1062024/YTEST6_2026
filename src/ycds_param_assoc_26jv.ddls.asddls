@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Associations with Parameters'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_PARAM_ASSOC_26JV
  with parameters
    pCarrierID : /dmo/carrier_id
  as select from /dmo/flight as Flight
  association [0..1] to /dmo/carrier as _Carrier on Flight.carrier_id = _Carrier.carrier_id
{
  key Flight.carrier_id    as CarrierId,
  key Flight.connection_id as ConnectionId,
  key Flight.flight_date   as FlightDate,
      _Carrier.name        as CarrierName
}
where
  Flight.carrier_id = $parameters.pCarrierID
