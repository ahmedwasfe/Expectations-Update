class Payment {
  GatewayOrderRequest? gatewayOrderRequest;
  double? amount;
  String? transactionNo;
  String? orderStatus;
  Null? paymentErrors;
  String? url;
  String? checkUrl;
  bool? success;
  bool? digitalOrder;
  Null? foreignCurrencyRate;

  Payment(
      {this.gatewayOrderRequest,
        this.amount,
        this.transactionNo,
        this.orderStatus,
        this.paymentErrors,
        this.url,
        this.checkUrl,
        this.success,
        this.digitalOrder,
        this.foreignCurrencyRate});

  Payment.fromJson(Map<String, dynamic> json) {
    gatewayOrderRequest = json['gatewayOrderRequest'] != null
        ? new GatewayOrderRequest.fromJson(json['gatewayOrderRequest'])
        : null;
    amount = json['amount'];
    transactionNo = json['transactionNo'];
    orderStatus = json['orderStatus'];
    paymentErrors = json['paymentErrors'];
    url = json['url'];
    checkUrl = json['checkUrl'];
    success = json['success'];
    digitalOrder = json['digitalOrder'];
    foreignCurrencyRate = json['foreignCurrencyRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gatewayOrderRequest != null) {
      data['gatewayOrderRequest'] = this.gatewayOrderRequest!.toJson();
    }
    data['amount'] = this.amount;
    data['transactionNo'] = this.transactionNo;
    data['orderStatus'] = this.orderStatus;
    data['paymentErrors'] = this.paymentErrors;
    data['url'] = this.url;
    data['checkUrl'] = this.checkUrl;
    data['success'] = this.success;
    data['digitalOrder'] = this.digitalOrder;
    data['foreignCurrencyRate'] = this.foreignCurrencyRate;
    return data;
  }
}

class GatewayOrderRequest {
  double? amount;
  String? orderNumber;
  String? callBackUrl;
  String? clientEmail;
  String? clientName;
  String? clientMobile;
  String? note;
  Null? cancelUrl;
  List<Products>? products;
  Null? currency;

  GatewayOrderRequest(
      {this.amount,
        this.orderNumber,
        this.callBackUrl,
        this.clientEmail,
        this.clientName,
        this.clientMobile,
        this.note,
        this.cancelUrl,
        this.products,
        this.currency});

  GatewayOrderRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    orderNumber = json['orderNumber'];
    callBackUrl = json['callBackUrl'];
    clientEmail = json['clientEmail'];
    clientName = json['clientName'];
    clientMobile = json['clientMobile'];
    note = json['note'];
    cancelUrl = json['cancelUrl'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['orderNumber'] = this.orderNumber;
    data['callBackUrl'] = this.callBackUrl;
    data['clientEmail'] = this.clientEmail;
    data['clientName'] = this.clientName;
    data['clientMobile'] = this.clientMobile;
    data['note'] = this.note;
    data['cancelUrl'] = this.cancelUrl;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['currency'] = this.currency;
    return data;
  }
}

class Products {
  String? title;
  double? price;
  int? qty;
  Null? description;
  bool? isDigital;
  String? imageSrc;
  Null? specificVat;
  double? productCost;

  Products(
      {this.title,
        this.price,
        this.qty,
        this.description,
        this.isDigital,
        this.imageSrc,
        this.specificVat,
        this.productCost});

  Products.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    qty = json['qty'];
    description = json['description'];
    isDigital = json['isDigital'];
    imageSrc = json['imageSrc'];
    specificVat = json['specificVat'];
    productCost = json['productCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['description'] = this.description;
    data['isDigital'] = this.isDigital;
    data['imageSrc'] = this.imageSrc;
    data['specificVat'] = this.specificVat;
    data['productCost'] = this.productCost;
    return data;
  }
}