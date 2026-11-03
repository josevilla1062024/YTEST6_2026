@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl: { authorizationCheck: #CHECK }
@EndUserText.label: 'CDS - Auditing Aspect'
@Metadata.ignorePropagatedAnnotations: true
define view entity YCDS_AUDITING_ASPECT_2_26JV
  as select from ydt_com_inv_26jv
{
  key invoice_id    as InvoiceID,
      customer_name as CustomerName,
      @Semantics.amount.currencyCode: 'Currency'
      inv_amount    as InvAmount,
      currency      as Currency,
      department    as Department,
      created_by    as CreatedBy,
      create_date   as CreateDate
}
