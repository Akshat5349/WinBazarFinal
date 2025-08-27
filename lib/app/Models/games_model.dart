class GamesModel {
  List<Games>? games;
  bool? success;
  String? message;

  GamesModel({this.games, this.success, this.message});

  GamesModel.fromJson(Map<String, dynamic> json) {
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Games {
  String? sId;
  String? marketName;
  String? marketType;
  String? openTime;
  String? closeTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Results>? results;

  Games(
      {this.sId,
      this.marketName,
      this.marketType,
      this.openTime,
      this.closeTime,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.results});

  Games.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    marketName = json['market_name'];
    marketType = json['market_type'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['market_name'] = this.marketName;
    data['market_type'] = this.marketType;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? sId;
  int? resultNumber;
  String? createdAt;
  String? updatedAt;
  String? gameTypeId;
  String? marketId;
  String? date;
  int? iV;
  ClosePana? closePana;
  ClosePana? openPana;

  Results(
      {this.sId,
      this.resultNumber,
      this.createdAt,
      this.updatedAt,
      this.gameTypeId,
      this.marketId,
      this.date,
      this.iV,
      this.closePana,
      this.openPana});

  Results.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    resultNumber = json['result_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gameTypeId = json['game_type_id'];
    marketId = json['market_id'];
    date = json['date'];
    iV = json['__v'];
    closePana = json['close_pana'] != null
        ? new ClosePana.fromJson(json['close_pana'])
        : null;
    openPana = json['open_pana'] != null
        ? new ClosePana.fromJson(json['open_pana'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['result_number'] = this.resultNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['game_type_id'] = this.gameTypeId;
    data['market_id'] = this.marketId;
    data['date'] = this.date;
    data['__v'] = this.iV;
    if (this.closePana != null) {
      data['close_pana'] = this.closePana!.toJson();
    }
    if (this.openPana != null) {
      data['open_pana'] = this.openPana!.toJson();
    }
    return data;
  }
}

class ClosePana {
  String? resultNumber;
  String? digit;
  String? textValue;
  String? declareDate;
  int? declareDateTimestamp;
  int? isResultDeclared;

  ClosePana(
      {this.resultNumber,
      this.digit,
      this.textValue,
      this.declareDate,
      this.declareDateTimestamp,
      this.isResultDeclared});

  ClosePana.fromJson(Map<String, dynamic> json) {
    resultNumber = json['result_number'];
    digit = json['digit'];
    textValue = json['text_value'];
    declareDate = json['declare_date'];
    declareDateTimestamp = json['declare_date_timestamp'];
    isResultDeclared = json['is_result_declared'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result_number'] = this.resultNumber;
    data['digit'] = this.digit;
    data['text_value'] = this.textValue;
    data['declare_date'] = this.declareDate;
    data['declare_date_timestamp'] = this.declareDateTimestamp;
    data['is_result_declared'] = this.isResultDeclared;
    return data;
  }
}
