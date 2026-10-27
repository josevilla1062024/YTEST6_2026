@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Unit Conversion'
@Metadata.ignorePropagatedAnnotations: true
define view entity YUNIT_CONVERSION_26JV
  as select from /dmo/fsa_root_a
{
  key id              as Id,
      string_property as StringProperty,
      uom,
      @Semantics.quantity.unitOfMeasure: 'UOM'
      unit_conversion(
      quantity => field_with_quantity,
      source_unit => abap.unit'A',
      target_unit => abap.unit'W',
      error_handling => 'SET_TO_NULL'
      )               as FIELD_WITH_QUANTITY_KG_USER
}
