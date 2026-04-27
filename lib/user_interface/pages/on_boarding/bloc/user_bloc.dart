

import 'package:expense_app/data/helper/db_helper.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_event.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  DBHelper dbHelper;
  UserBloc({required this.dbHelper}) : super(UserInitialState()) {

    on<UserSignUpEvent>((event, emit) async{
      emit(UserLoadingState());
      int value = await dbHelper.createUser(newUserModel: event.newUser);
      if(value == 3){
        emit(UserSuccessState());
      }
      else if(value ==2){
        emit(UserFailureState(errorMsg: "Email already exists !!!"));
      }
      else{
        emit(UserFailureState(errorMsg: "Something went wrong !!!"));
      }
    } );

    on<UserLoginEvent>((event, emit) async{
      emit(UserLoadingState());
      int value = await dbHelper.authUser(email: event.email, password: event.password);
      if(value == 1){
        emit(UserFailureState(errorMsg: "Incorrect email !!!"));
      } else if(value == 2){
        emit(UserFailureState(errorMsg: "Incorrect password !!!"));
      } else if(value == 3){
        emit(UserSuccessState());
      }
    });
  }
}