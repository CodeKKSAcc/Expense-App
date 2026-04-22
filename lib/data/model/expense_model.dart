import 'package:expense_app/data/helper/db_helper.dart';

class ExpenseModel {
  int? eid;
  int uid, catagoryId, createdAt, type;
  String title, remark;
  double amount;

  ExpenseModel({
    this.eid,
    required this.uid,
    required this.catagoryId,
    required this.createdAt,
    required this.type,
    required this.title,
    required this.remark,
    required this.amount,
  });

  Map<String, dynamic> toEMap(){
    return {
      DBHelper.column_user_id : uid,
      DBHelper.column_expense_catagory_id : catagoryId,
      DBHelper.column_expense_created_at : createdAt.toString(),
      DBHelper.column_expense_type : type,
      DBHelper.column_expense_title : title,
      DBHelper.column_expense_remark : remark,
      DBHelper.column_expense_amount : amount
    };
  }

  ExpenseModel toEModel(Map<String, dynamic> myMap){
    return ExpenseModel(
        eid: myMap[DBHelper.column_expense_id],
        uid: myMap[DBHelper.column_user_id],
        catagoryId: myMap[DBHelper.column_expense_catagory_id],
        createdAt: int.parse(myMap[DBHelper.column_expense_created_at]),
        type: myMap[DBHelper.column_expense_type],
        title: myMap[DBHelper.column_expense_title],
        remark: myMap[DBHelper.column_expense_remark],
        amount: myMap[DBHelper.column_expense_amount]);
  }
}
