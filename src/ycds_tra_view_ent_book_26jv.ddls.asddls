@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'CDS Transient View Entity'
@ObjectModel.modelingPattern: #ANALYTICAL_QUERY
@ObjectModel.supportedCapabilities: [#ANALYTICAL_QUERY]
define transient view entity YCDS_TRA_VIEW_ENT_BOOK_26JV
  provider contract analytical_query
  as projection on YCDS_AN_DATA_FLIGHT_26JV
{
          @AnalyticsDetails.query.axis: #FREE
          TravelId,          
          @AnalyticsDetails.query.axis: #ROWS
          BookingId,
          BookingDate,
          @AnalyticsDetails.query.axis: #COLUMNS
          CustomerId,
          CarrierId,
          ConnectionId,
          FlightDate,
          @ObjectModel.text.element: [ 'currcode' ]
          FlightPrice,
          CurrencyCode,
  virtual currcode : abap.cuky,
          /* Associations */
          _Flight
}
