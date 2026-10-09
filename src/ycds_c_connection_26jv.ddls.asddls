@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wrong and Correc tUse of to many associations'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_C_CONNECTION_26JV as select from /DMO/I_Connection_R

{
    key AirlineID,
    key ConnectionID,

//        _Flight.OccupiedSeats
                sum(_Flight.OccupiedSeats) as TotalOccupiedSeats

  }
where
      AirlineID    = 'LH'   // Only one connection
  and ConnectionID = '0400' // fulfills this condition

  group by
    AirlineID,
    ConnectionID




//Ejemplo 1
//{
//key AirlineID,
//key ConnectionID,
//
// _Airline.CurrencyCode,
// _Flight.PlaneType,
//
//DepartureAirport,
//DestinationAirport
//
//}
//where
//AirlineID = 'LH'          // Only one connection
//and ConnectionID = '0400' // fulfills this filter
//
//
// and _Airline.CurrencyCode = 'EUR'
// and _Flight.PlaneType = '747-400'

