import 'package:expense_app/data/helper/db_helper.dart';

class UserModel {
  int? uid;
  int created_at;
  String name, email, mobNo, password;
  num budget, balance;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.mobNo,
    required this.password,
    required this.budget,
    required this.balance,
    required this.created_at,
  });

  // Model to Map
  Map<String, dynamic> toMap(){
    return {
      DBHelper.column_user_name : name,
      DBHelper.column_user_email : email,
      DBHelper.column_user_mob_no : mobNo,
      DBHelper.column_user_password : password,
      DBHelper.column_user_budget : budget,
      DBHelper.column_user_balance : balance,
      DBHelper.column_user_created_at : created_at.toString()
    };
  }

  // Map from DB to Model
  factory UserModel.fromMap(Map<String, dynamic> myMap){
    return UserModel(
        uid: myMap[DBHelper.column_user_id],
        name: myMap[DBHelper.column_user_name],
        email: myMap[DBHelper.column_user_email],
        mobNo: myMap[DBHelper.column_user_mob_no],
        password: myMap[DBHelper.column_user_password],
        budget: myMap[DBHelper.column_user_budget],
        balance: myMap[DBHelper.column_user_balance],
        created_at: int.parse(myMap[DBHelper.column_user_created_at]),
    );
  }
}
