@AbapCatalog.sqlViewName: 'ZV_BOOK_CANO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface - Booking Supplement'
define view z_i_booksuppl_cano
  as select from ztb_booksuppl_cn as BookingSupplement
  association        to parent z_i_booking_cano as _Booking        on  $projection.TravelId  = _Booking.TravelId
                                                                   and $projection.BookingId = _Booking.BookingId
  association [1..1] to z_i_travel_cano         as _Travel         on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Supplement       as _Product        on  $projection.SupplementId = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText   as _SupplementText on  $projection.SupplementId = _SupplementText.SupplementID
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode : 'Currency'
      price                 as Price,
      @Semantics.currencyCode: true
      currency              as Currency,
      @Semantics.systemDateTime.lastChangedAt: true
      _Travel.LastChangedAt,
      _Booking,
      _Travel,
      _Product,
      _SupplementText
}
