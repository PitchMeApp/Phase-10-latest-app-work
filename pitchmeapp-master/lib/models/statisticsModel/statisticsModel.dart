class StatisticsModel {
  String? message;
  Result? result;

  StatisticsModel({this.message, this.result});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Investors? investors;
  Investors? business;
  Investors? raisedFunds;
  Investors? verifiedFunds;
  Investors? cities;
  Investors? countries;
  Continents? continents;
  Investors? businessIdea;
  Investors? facilitator;
  String? sId;
  int? iV;

  Result(
      {this.investors,
      this.business,
      this.raisedFunds,
      this.verifiedFunds,
      this.cities,
      this.countries,
      this.continents,
      this.businessIdea,
      this.facilitator,
      this.sId,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    investors = json['investors'] != null
        ? Investors.fromJson(json['investors'])
        : null;
    business =
        json['business'] != null ? Investors.fromJson(json['business']) : null;
    raisedFunds = json['raised_funds'] != null
        ? Investors.fromJson(json['raised_funds'])
        : null;
    verifiedFunds = json['verified_funds'] != null
        ? Investors.fromJson(json['verified_funds'])
        : null;
    cities = json['cities'] != null ? Investors.fromJson(json['cities']) : null;
    countries = json['countries'] != null
        ? Investors.fromJson(json['countries'])
        : null;
    continents = json['continents'] != null
        ? Continents.fromJson(json['continents'])
        : null;
    businessIdea = json['businessideas'] != null
        ? Investors.fromJson(json['businessideas'])
        : null;
    facilitator = json['facilitator'] != null
        ? Investors.fromJson(json['facilitator'])
        : null;
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.investors != null) {
      data['investors'] = this.investors!.toJson();
    }
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.raisedFunds != null) {
      data['raised_funds'] = this.raisedFunds!.toJson();
    }
    if (this.verifiedFunds != null) {
      data['verified_funds'] = this.verifiedFunds!.toJson();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.toJson();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.toJson();
    }
    if (this.continents != null) {
      data['continents'] = this.continents!.toJson();
    }
    if (this.businessIdea != null) {
      data['businessideas'] = this.businessIdea!.toJson();
    }
    if (this.facilitator != null) {
      data['facilitator'] = this.facilitator!.toJson();
    }
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

class Investors {
  int? number;
  int? dailyIncrease;

  Investors({this.number, this.dailyIncrease});

  Investors.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    dailyIncrease = json['daily_increase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    data['daily_increase'] = this.dailyIncrease;
    return data;
  }
}

class Continents {
  int? number;

  Continents({this.number});

  Continents.fromJson(Map<String, dynamic> json) {
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    return data;
  }
}
