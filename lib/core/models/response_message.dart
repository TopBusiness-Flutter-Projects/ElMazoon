class StatusResponseModel{
  late int code =0;
  late dynamic message="";

  StatusResponseModel();
  StatusResponseModel.fromJson(Map<String,dynamic> json){
    code = json['code'] ?? 0 as int;
    message = json ['message'] ?? "" as String;
  }

}