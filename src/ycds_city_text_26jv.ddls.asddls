@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - View CDS with texts associations'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #TEXT 
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, 
                                      #CDS_MODELING_DATA_SOURCE, 
                                      #CDS_MODELING_ASSOCIATION_TARGET] 
@Search.searchable: true 
@VDM.viewType: #BASIC 
define view entity YCDS_CITY_TEXT_26JV
  as select from ycity_texts_26jv
association [1..1] to YCDS_CITY_ASSOC_26JV as _CityText on _CityText.City = $projection.City   
{
        key ycity_texts_26jv.airport_id as AirportId
        , 
        @Search.defaultSearchElement: true 
        @ObjectModel.text.association: '_CityText' 
        ycity_texts_26jv.city as City, 
        _CityText 
  }
