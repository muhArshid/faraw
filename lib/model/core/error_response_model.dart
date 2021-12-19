class ErrorResponse {
  String? responseMessage;
  String? responseTitle;
  String? responseErrorDescription;

  ErrorResponse(
      {this.responseMessage,
      this.responseTitle,
      this.responseErrorDescription});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseTitle = json['responseTitle'];
    responseErrorDescription = json['responseErrorDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseTitle'] = this.responseTitle;
    data['responseErrorDescription'] = this.responseErrorDescription;
    return data;
  }
}
