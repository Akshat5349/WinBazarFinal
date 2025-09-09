class SettingModel {
  String? createdAt;
  String? sId;
  String? name;
  String? email;
  String? mobile;
  String? whatsapp;
  String? upiId;
  String? merchantId;
  String? minBettingRate;
  String? minWithdrwalRate;
  String? maxWithdrwalRate;
  String? minDepositRate;
  String? maxDepositRate;
  String? minimumTransfer;
  String? maximumTransfer;
  String? minimumBidAmount;
  String? maximumBidAmount;
  String? welcomeBonus;
  String? accountHolderName;
  String? accountNumber;
  String? ifscCode;
  String? appLink;
  String? msg;
  String? homeTitle1;
  String? homeTitle2;
  String? upiName;
  String? upiPaymentId;
  String? upiPaytmId;
  String? upiPhonepayId;
  String? upiGooglepayId;
  String? marketOpenTime;
  String? alertMessage;
  String? paymentBtnText;
  String? paymentScreenImg;
  String? withdrawBtnText;
  String? withdrawScreenMsg;
  String? paymentScreenMsg;
  String? popupMsg;
  String? popupHeading;
  String? movingText;
  bool? vpaEnabled;
  int? iV;

  SettingModel(
      {this.createdAt,
      this.sId,
      this.name,
      this.email,
      this.mobile,
      this.whatsapp,
      this.upiId,
      this.merchantId,
      this.minBettingRate,
      this.minWithdrwalRate,
      this.maxWithdrwalRate,
      this.minDepositRate,
      this.maxDepositRate,
      this.minimumTransfer,
      this.maximumTransfer,
      this.minimumBidAmount,
      this.maximumBidAmount,
      this.welcomeBonus,
      this.accountHolderName,
      this.accountNumber,
      this.ifscCode,
      this.appLink,
      this.msg,
      this.homeTitle1,
      this.homeTitle2,
      this.upiName,
      this.upiPaymentId,
      this.upiPaytmId,
      this.upiPhonepayId,
      this.upiGooglepayId,
      this.marketOpenTime,
      this.alertMessage,
      this.paymentBtnText,
      this.paymentScreenMsg,
      this.withdrawBtnText,
      this.withdrawScreenMsg,
      this.paymentScreenImg,
      this.popupMsg,
      this.popupHeading,
      this.movingText,
      this.vpaEnabled,
      this.iV});

  SettingModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'] != null ? json['created_at'] : '';
    sId = json['_id'] != null ? json['_id'] : '';
    name = json['name'] != null ? json['name'] : '';
    email = json['email'] != null ? json['email'] : '';
    mobile = json['mobile'] != null ? json['mobile'] : '';
    whatsapp = json['whatsapp'] != null ? json['whatsapp'] : '';
    upiId = json['upi_id'] != null ? json['upi_id'] : '';
    merchantId = json['merchant_id'] != null ? json['merchant_id'] : '';
    minBettingRate =
        json['min_betting_rate'] != null ? json['min_betting_rate'] : '';
    minWithdrwalRate =
        json['min_withdrwal_rate'] != null ? json['min_withdrwal_rate'] : "";
    maxWithdrwalRate =
        json['max_withdrwal_rate'] != null ? json['max_withdrwal_rate'] : '';
    minDepositRate =
        json['min_deposit_rate'] != null ? json['min_deposit_rate'] : '';
    maxDepositRate =
        json['max_deposit_rate'] != null ? json['max_deposit_rate'] : '';
    minimumTransfer =
        json['minimum_transfer'] != null ? json['minimum_transfer'] : '';
    maximumTransfer =
        json['maximum_transfer'] != null ? json['maximum_transfer'] : '';
    minimumBidAmount =
        json['minimum_bid_amount'] != null ? json['minimum_bid_amount'] : '';
    maximumBidAmount =
        json['maximum_bid_amount'] != null ? json['maximum_bid_amount'] : '';
    welcomeBonus = json['welcome_bonus'] != null ? json['welcome_bonus'] : '';
    accountHolderName =
        json['account_holder_name'] != null ? json['account_holder_name'] : '';
    accountNumber =
        json['account_number'] != null ? json['account_number'] : '';
    ifscCode = json['ifsc_code'] != null ? json['ifsc_code'] : '';
    appLink = json['app_link'] != null ? json['app_link'] : '';
    msg = json['msg'] != null ? json['msg'] : '';
    homeTitle1 = json['home_title_1'] != null ? json['home_title_1'] : '';
    homeTitle2 = json['home_title_2'] != null ? json['home_title_2'] : '';
    upiName = json['upi_name'] != null ? json['upi_name'] : '';
    upiPaymentId = json['upi_payment_id'] != null ? json['upi_payment_id'] : '';
    upiPaytmId = json['upi_paytm_id'] != null ? json['upi_paytm_id'] : '';
    upiPhonepayId =
        json['upi_phonepay_id'] != null ? json['upi_phonepay_id'] : '';
    upiGooglepayId =
        json['upi_googlepay_id'] != null ? json['upi_googlepay_id'] : "";
    marketOpenTime =
        json['market_open_time'] != null ? json['market_open_time'] : '';
    alertMessage = json['alert_message'] != null ? json['alert_message'] : '';
    paymentBtnText =
        json['paymentBtnText'] != null ? json['paymentBtnText'] : '';
    withdrawBtnText =
        json['withdrawBtnText'] != null ? json['withdrawBtnText'] : '';
    paymentScreenMsg =
        json['paymentPageMessage'] != null ? json['paymentPageMessage'] : '';
    withdrawScreenMsg =
        json['withdrawPageMessage'] != null ? json['withdrawPageMessage'] : '';
    paymentScreenImg =
        json['paymentPageImg'] != null ? json['paymentPageImg'] : '';
    iV = json['__v'] != null ? json['__v'] : '';
    popupMsg = json['popup_msg'] != null ? json['popup_msg'] : '';
    popupHeading = json['popup_heading'] != null ? json['popup_heading'] : '';
    movingText = json['moving_text'] != null ? json['moving_text'] : '';
    vpaEnabled = json['vpa_enabled'] != null ? json['vpa_enabled'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['whatsapp'] = this.whatsapp;
    data['upi_id'] = this.upiId;
    data['merchant_id'] = this.merchantId;
    data['min_betting_rate'] = this.minBettingRate;
    data['min_withdrwal_rate'] = this.minWithdrwalRate;
    data['max_withdrwal_rate'] = this.maxWithdrwalRate;
    data['min_deposit_rate'] = this.minDepositRate;
    data['max_deposit_rate'] = this.maxDepositRate;
    data['minimum_transfer'] = this.minimumTransfer;
    data['maximum_transfer'] = this.maximumTransfer;
    data['minimum_bid_amount'] = this.minimumBidAmount;
    data['maximum_bid_amount'] = this.maximumBidAmount;
    data['welcome_bonus'] = this.welcomeBonus;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['app_link'] = this.appLink;
    data['msg'] = this.msg;
    data['popup_msg'] = this.popupMsg;
    data['popup_heading'] = this.popupHeading;
    data['home_title_1'] = this.homeTitle1;
    data['home_title_2'] = this.homeTitle2;
    data['upi_name'] = this.upiName;
    data['upi_payment_id'] = this.upiPaymentId;
    data['upi_paytm_id'] = this.upiPaytmId;
    data['upi_phonepay_id'] = this.upiPhonepayId;
    data['upi_googlepay_id'] = this.upiGooglepayId;
    data['market_open_time'] = this.marketOpenTime;
    data['alert_message'] = this.alertMessage;
    data['paymentBtnText'] = paymentBtnText;
    data['paymentPageMessage'] = paymentScreenMsg;
    data['withdrawBtnText'] = withdrawBtnText;
    data['withdrawPageMessage'] = withdrawScreenMsg;
    data['paymentPageImg'] = paymentScreenImg;
    data['moving_text'] = this.movingText;
    data['vpa_enabled'] = this.vpaEnabled;
    data['__v'] = this.iV;
    return data;
  }
}
