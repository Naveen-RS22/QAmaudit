import 'dart:convert';

class GetUserDepartmentListModel {
  bool? isSuccess;
  String? message;
  Data? data;

  GetUserDepartmentListModel({this.isSuccess, this.message, this.data});

  GetUserDepartmentListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Departments>? departments;
  List<Users>? users;
  List<UnitMasters>? unitMasters;

  Data({this.departments, this.users, this.unitMasters});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(Departments.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    if (json['unitMasters'] != null) {
      unitMasters = <UnitMasters>[];
      json['unitMasters'].forEach((v) {
        unitMasters!.add(UnitMasters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (departments != null) {
      data['departments'] = departments!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (unitMasters != null) {
      data['unitMasters'] = unitMasters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departments {
  int? departmentID;
  String? entityCode;
  String? departmentCode;
  String? departmentName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Departments(
      {this.departmentID,
      this.entityCode,
      this.departmentCode,
      this.departmentName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Departments.fromJson(Map<String, dynamic> json) {
    departmentID = json['departmentID'];
    entityCode = json['entityCode'];
    departmentCode = json['departmentCode'];
    departmentName = json['departmentName'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departmentID'] = departmentID;
    data['entityCode'] = entityCode;
    data['departmentCode'] = departmentCode;
    data['departmentName'] = departmentName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class Users {
  int? userID;
  String? userCode;
  String? userType;
  String? firstName;
  String? lastName;
  String? displayName;
  String? designation;
  String? department;
  int? gender;
  String? mobile;
  String? emailID;
  bool? isPortalAccess;
  bool? isAccess;
  String? locationCode;
  String? loginUserName;
  String? reportingUserCode;
  String? employeeType;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  bool? isActive;

  Users(
      {this.userID,
      this.userCode,
      this.userType,
      this.firstName,
      this.lastName,
      this.displayName,
      this.designation,
      this.department,
      this.gender,
      this.mobile,
      this.emailID,
      this.isPortalAccess,
      this.isAccess,
      this.locationCode,
      this.loginUserName,
      this.reportingUserCode,
      this.employeeType,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.isActive});

  Users.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userCode = json['userCode'];
    userType = json['userType'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    displayName = json['displayName'];
    designation = json['designation'];
    department = json['department'];
    gender = json['gender'];
    mobile = json['mobile'];
    emailID = json['emailID'];
    isPortalAccess = json['isPortalAccess'];
    isAccess = json['isAccess'];
    locationCode = json['locationCode'];
    loginUserName = json['loginUserName'];
    reportingUserCode = json['reportingUserCode'];
    employeeType = json['employeeType'];

    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    modifiedDate = json['modifiedDate'];
    modifiedBy = json['modifiedBy'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['userCode'] = userCode;
    data['userType'] = userType;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['displayName'] = displayName;
    data['designation'] = designation;
    data['department'] = department;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['emailID'] = emailID;
    data['isPortalAccess'] = isPortalAccess;
    data['isAccess'] = isAccess;
    data['locationCode'] = locationCode;
    data['loginUserName'] = loginUserName;
    data['reportingUserCode'] = reportingUserCode;
    data['employeeType'] = employeeType;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['modifiedDate'] = modifiedDate;
    data['modifiedBy'] = modifiedBy;
    data['isActive'] = isActive;
    return data;
  }
}

class UnitMasters {
  int? unitMasterID;
  String? uCode;
  String? uName;
  String? locCode;
  String? country;

  UnitMasters(
      {this.unitMasterID, this.uCode, this.uName, this.locCode, this.country});

  UnitMasters.fromJson(Map<String, dynamic> json) {
    unitMasterID = json['unitMasterID'];
    uCode = json['uCode'];
    uName = json['uName'];
    locCode = json['locCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitMasterID'] = unitMasterID;
    data['uCode'] = uCode;
    data['uName'] = uName;
    data['locCode'] = locCode;
    data['country'] = country;
    return data;
  }
}
