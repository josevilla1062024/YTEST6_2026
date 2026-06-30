@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vista articulos arte'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity YCDS_ART_001_26JV
  as select from ytab_arts_26jv
{
  key id_art as IdArt,
      descr  as Descr,
      desc2  as Desc2,
      color  as Color,
      piezas as Piezas,
      stock  as Stock,
      url    as Url,
      // 0 neutral grey
      // 1 negative red
      // 2 critical yellow
      // 3 positive green
      case
      when stock = 0 then 0
      when stock between 1 and 10 then 1
      when stock between 10 and 99 then 2
      when stock >= 100 then 3
      else 0
      end    as status
}
