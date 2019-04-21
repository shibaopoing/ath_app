class UserInfo{
  num id;
  String userCode;
  String userName;
  String userPwd;
  String userPhone;
  String userEmail;
  String faceImage;
  UserInfo(this.id,this.userName,this.userCode,this.userPwd,this.userPhone,this.userEmail);

  UserInfo.fromJson(Map<String, dynamic> json)
      : id=json['id'] as num,
        userName = json['userName'],
        userCode = json['userCode'],
        userPwd = json['userPwd'],
        userPhone=json['userPhone'],
        userEmail = json['userEmail'];

  Map<String, dynamic> toJson() =>
      {
        'id':id ,
        'userName': userName,
        'userCode':userCode,
        'userPwd':userPwd,
        'userPhone':userPhone,
        'userEmail': userEmail,
      };
}