@AbapCatalog.sqlViewName: 'ZV_TRAV_CANO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface - travel'
@Metadata.allowExtensions: true
define root view z_i_travel_cano
  as select from ztb_travel_cano as Travel
  composition [0..*] of z_i_booking_cano as _Booking
  association [0..1] to /DMO/I_Agency    as _Agency   on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer  as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency       as _Currency on $projection.currency_code = _Currency.Currency

{
  key travel_id       as TravelId,
      agency_id       as AgencyId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode: 'currency_code'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'currency_code'
      total_price     as TotalPrice,
      @Semantics.currencyCode: true
      currency_code,
      description     as Description,
      overall_status  as OverallStatus,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _Booking,
      _Agency,
      _Customer,
      _Currency
}
