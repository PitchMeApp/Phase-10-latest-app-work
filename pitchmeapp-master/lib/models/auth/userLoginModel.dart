class UserLoginModel {
  String? message;
  String? token;
  User? user;

  UserLoginModel({this.message, this.token, this.user});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? username;
  String? email;
  String? password;
  String? profilePic;
  int? emailVerify;
  int? flag;
  String? createdAt;
  int? loginType;
  dynamic bot;
  dynamic hometutorial;
  dynamic salespitchtutorial;
  dynamic addsalespitchtutoria;
  dynamic dealtutorial;
  dynamic profiletutorial;

  User({
    this.sId,
    this.username,
    this.email,
    this.password,
    this.profilePic,
    this.emailVerify,
    this.flag,
    this.loginType,
    this.bot,
    this.createdAt,
    this.addsalespitchtutoria,
    this.dealtutorial,
    this.hometutorial,
    this.profiletutorial,
    this.salespitchtutorial,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    profilePic = json['profile_pic'];
    emailVerify = json['email_verify'];
    flag = json['flag'];
    createdAt = json['createdAt'];
    loginType = json['log_type'];
    hometutorial =
        (json['hometutorial'] == null) ? false : json['hometutorial'];
    salespitchtutorial = (json['salespitchtutorial'] == null)
        ? false
        : json['salespitchtutorial'];
    addsalespitchtutoria = (json['addsalespitchtutoria'] == null)
        ? false
        : json['addsalespitchtutoria'];
    dealtutorial =
        (json['dealtutorial'] == null) ? false : json['dealtutorial'];
    profiletutorial =
        (json['profiletutorial'] == null) ? false : json['profiletutorial'];
    bot = (json['bot'] == null) ? null : json['bot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['email_verify'] = this.emailVerify;
    data['flag'] = this.flag;
    data['createdAt'] = this.createdAt;
    data['log_type'] = this.loginType;
    data['bot'] = this.bot;
    data['hometutorial'] = this.hometutorial;
    data['salespitchtutorial'] = this.salespitchtutorial;
    data['addsalespitchtutoria'] = this.addsalespitchtutoria;
    data['dealtutorial'] = this.dealtutorial;
    data['profiletutorial'] = this.profiletutorial;
    return data;
  }
}
