@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Filtered Associations'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_C_CONNECTION_2_26JV
  as select from /DMO/I_Connection_R

{
    key AirlineID,
    key ConnectionID,

////        _Airline._Currency._Text.CurrencyName

//        _Airline._Currency._Text[ Language = 'E' ].CurrencyName

        _Airline._Currency._Text[ 1: Language = 'E' ].CurrencyName
  }
where
      AirlineID    = 'AA'
  and ConnectionID = '0017'
  
