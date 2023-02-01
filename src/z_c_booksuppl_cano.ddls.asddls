@EndUserText.label: 'Consumption - Booking Supplement'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity z_c_booksuppl_cano
  as projection on z_i_booksuppl_cano
{
  key TravelId                    as TravelID,
  key BookingId                   as BookingID,
  key BookingSupplementId         as BookingSupplementID,
      @ObjectModel.text.element:['SupplementDescription']
      SupplementId,
      _SupplementText.Description as SupplementDescription : localized,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      Price,
      @Semantics.currencyCode: true
      Currency                    as CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Travel  : redirected to z_c_travel_cano,
      _Booking : redirected to parent z_c_booking_cano,
      _Product,
      _SupplementText
}
