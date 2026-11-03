@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Projection with virtualization on Flight Discount'
@Metadata.ignorePropagatedAnnotations: true
define root view entity YCDS_PROJ_VIRTUAL_DISC_26JV
  provider contract transactional_query
  as projection on YCDS_VIRTUAL_DISCOUNT_26JV
{
key CarrierId,
  key ConnectionId,
  key FlightDate,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      price,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied,
  
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @EndUserText.label: 'Price with Discount'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:YCL_VIRTUAL_DISCOUNT_26JV'
      virtual RealPrice : abap.curr(16,2)
  }
