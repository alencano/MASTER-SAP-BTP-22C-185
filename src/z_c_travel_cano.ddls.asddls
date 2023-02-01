@EndUserText.label: 'Consumption - Travel'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity z_c_travel_cano
  as projection on z_i_travel_cano
{
  key TravelId,
      @ObjectModel.text.element: ['AgencyName']
      AgencyId,
      _Agency.Name       as AgencyName,
      @ObjectModel.text.element: ['CustomerName']
      CustomerId         as CustomerID,
      _Customer.LastName as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode :'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode :'CurrencyCode'
      TotalPrice,
      @Semantics.currencyCode: true
      currency_code      as CurrencyCode,
      Description,
      OverallStatus      as TravelStatus,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child z_c_booking_cano,
      _Currency,
      _Customer
}
