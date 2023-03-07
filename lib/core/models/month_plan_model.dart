class MothPlanModel
{
  List<MothData>? data;
  String? message;
  int? code;

  MothPlanModel({this.data, this.message, this.code});

  MothPlanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MothData>[];
      json['data'].forEach((v) {
        data!.add(new MothData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class MothData {
  int? id;
  String? date;
  List<Plans>? plans;
  String? createdAt;
  String? updatedAt;

  MothData({this.id, this.date, this.plans, this.createdAt, this.updatedAt});

  MothData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Plans {
  int? id;
  String? title;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  Plans(
      {this.id,
        this.title,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}