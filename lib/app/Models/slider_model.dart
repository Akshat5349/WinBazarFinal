class SliderModel {
  String? createdAt;
  String? sId;
  String? basename;
  int? iV;

  SliderModel({this.createdAt, this.sId, this.basename, this.iV});

  SliderModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    sId = json['_id'];
    basename = json['basename'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['_id'] = this.sId;
    data['basename'] = this.basename;
    data['__v'] = this.iV;
    return data;
  }
}
