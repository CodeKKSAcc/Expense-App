import 'dart:io';

import 'package:expense_app/data/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper onlyInstance() {
    return DBHelper._();
  }

  Database? myDB;

  static String db_name = "expensoDB.db";

  static String table_user = "users";

  static String column_user_id = "u_id";
  static String column_user_name = "u_name";
  static String column_user_email = "u_email";
  static String column_user_mob_no = "u_mob_no";
  static String column_user_password = "u_password";
  static String column_user_budget = "u_budget";
  static String column_user_balance = "u_balance";
  static String column_user_created_at = "u_created_at";

  static String table_expense = "expenses";

  static String column_expense_id = "e_id";
  static String column_expense_title = "e_title";
  static String column_expense_remark = "e_remark";
  static String column_expense_amount = "e_amount";
  static String column_expense_created_at = "e_created_at";
  static String column_expense_catagory_id = "e_category_id";
  static String column_expense_type = "e_type";

  Future<Database> initDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory myDir = await getApplicationDocumentsDirectory();
    String path = join(myDir.path, db_name);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        database.execute(
          "create table $table_user ("
          "$column_user_id integer primary key autoincrement, "
          "$column_user_name text, "
          "$column_user_email text, "
          "$column_user_mob_no text, "
          "$column_user_password text, "
          "$column_user_budget real, "
          "$column_user_balance real, "
          "$column_user_created_at text)",
        );

        database.execute(
          "create table $table_expense ("
          "$column_expense_id integer primary key autoincrement, "
          "$column_user_id integer, "
          "$column_expense_title text, "
          "$column_expense_remark text, "
          "$column_expense_catagory_id integer,"
          "$column_expense_amount real, "
          "$column_expense_created_at text, "
          "$column_expense_type integer)",
        );
      },
    );
  }

  /*Future<List<Map<String, dynamic>>> fetchAllUserData({required int userId}) async {
    Database dbReference = await initDB();
    return await dbReference.query(
      table_user,
      where: "$column_user_id = ?",
      whereArgs: [userId],
    );
  }*/

  // Create user
  Future<int> createUser({required UserModel newUserModel}) async {
    Database dbReference = await initDB();

    bool emailExistCheck = await doesEmailExist(email: newUserModel.email);

    // 1 -> Something went wrong, 2 -> Email already exist's, 3 -> Acc created successfully

    // If the email exists then we don't need to create an account
    if (emailExistCheck) {
      return 2;
    }
    // Create account if the email doesn't exist
    else {
      int rowsEff = await dbReference.insert(table_user, newUserModel.toMap());
      if (rowsEff > 0) {
        return 3;
      } else {
        return 1;
      }
    }
  }

  // Check's both email and password, but can't identify specifically which of two/both of them is incorrect.
  /*Future<bool> authUser({required String email, required String password}) async {
    Database dbReference = await initDB();
    List<Map<String, dynamic>> myUser = await dbReference.query(
      table_user,
      where: "$column_user_email = ? and $column_user_password = ?",
      whereArgs: [email, password],
    );
    return myUser.isNotEmpty;
  }*/

  // 1-> Incorrect email
  // 2-> Incorrect password
  // 3-> Authenticated/varified user

  Future<int> authUser({required String email, required String password}) async {
    Database dbReference = await initDB();
    List<Map<String, dynamic>> myUser = await dbReference.query(
      table_user,
      where: "$column_user_email = ? and $column_user_password = ?",
      whereArgs: [email, password],
    );

    if(myUser.isEmpty){
      List<Map<String, dynamic>> emailUser = await dbReference.query(
        table_user,
        where: "$column_user_email = ?",
        whereArgs: [email],
      );

      if(emailUser.isNotEmpty){
        return 2;
      } else{
        return 1;
      }
    }

    else{
      return 3;
    }
  }

  Future<bool> doesEmailExist({required String email}) async {
    Database dbReference = await initDB();
    List<Map<String, dynamic>> myUsers = await dbReference.query(
      table_user,
      where: "$column_user_email = ?",
      whereArgs: [email],
    );
    return myUsers.isNotEmpty;
  }

/*Future<bool> doesPasswordMatched({required String password}) async {
    Database dbReference = await initDB();
    List<Map<String, dynamic>> myUserPass = await dbReference.query(
      table_user,
      where: "$column_user_password = ?",
      whereArgs: [password],
    );
    return myUserPass.isNotEmpty;
  }*/
}
