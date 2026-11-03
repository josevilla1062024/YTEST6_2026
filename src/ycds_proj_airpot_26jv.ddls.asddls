@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Projection View Airport'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define root view entity YCDS_PROJ_AIRPOT_26JV
  as projection on YCDS_ROOT_AIRPOT_26JV
{
key AirportId,
      Name,
      @ObjectModel.text.element: [ 'City' ]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{
        entity: { name:    'YCDS_CITY_VH_26JV',
                  element: 'City' },
        useForValidation: true
      }]
      City,
      Country,
      /* Associations */
      _Text._CityText.AirportId as AirportText
}
