@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Consumption Entity from root entity for RAP'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity YDD_C_CUSTOMER_TRAVEL_26JV
  provider contract transactional_query
  as projection on YDD_R_CUSTOMER_TRAVEL_26JV

{
  key     CustomerUuid,

          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          @Search.ranking: #HIGH
          @ObjectModel.text.element: [ 'CustomerName' ]
          CustomerId,

          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          @Search.ranking: #MEDIUM
          FlightDate,

          _Customer.LastName                                                            as CustomerName,
          _Customer._Country._Text[1: Language = $session.system_language ].CountryName as CustomerCountry,
          Description,

          @Semantics.amount.currencyCode: 'CurrencyCode'
          Price,

          @EndUserText.label: 'VAT Included'
          @Semantics.amount.currencyCode : 'CurrencyCode'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:YCL_VIRT_EMEM_SADL_PRICE_26JV'
          virtual PriceWithTax : /dmo/flight_price,

          CurrencyCode,
          OverallStatus,

          LocalCreatedBy,
          LocalCreatedAt,
          LocalLastChangedBy,
          @Semantics.systemDateTime.localInstanceLastChangedAt: true
          LocalLastChangedAt,
          @Semantics.systemDateTime.lastChangedAt: true
          LastChangedAt,

          /* Associations */
          _Customer

}
