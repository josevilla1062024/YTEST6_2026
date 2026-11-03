@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de búsqueda'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity YCDS_CITY_VH_26JV
  as select from YCDS_CITY_ASSOC_26JV
{
      @UI.hidden: true
  key CustomerId,
      @ObjectModel.text.element: ['CityText']
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
  key City,

      @Search.defaultSearchElement: true
      @Search.ranking: #LOW
      @Search.fuzzinessThreshold: 0.8
      _CityText.City as CityText
}
