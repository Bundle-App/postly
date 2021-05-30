import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:Postly/model/user.dart';
import 'package:Postly/repo/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserRepo userRepo;

  UserCubit(this.userRepo) : super(UserInactive());

  /// checks if user is saved, else fetches online
  Future<void> retrieveUser() async {
    emit(UserProcessing());
    try {
      var savedUser = await userRepo.checkUser();
      if (savedUser == null) {
        processNewUser();
      } else {
        User user = User.fromMap(jsonDecode(savedUser));
        emit(UserActive(user));
      }
    } catch (e) {
      emit(UserInactive(error: e.toString()));
    }
  }

  // fetches online users, selects at random and saves user object
  void processNewUser() async{
    emit(UserProcessing());
    try{
      List<Map<String, dynamic>> users = List<Map<String,dynamic>>.from(await userRepo.getNewUsers());
      if (users.isEmpty) {
        emit(UserInactive(error: 'We couldn\'t find an active user'));
        return;
      }
      int randomNumber = Random().nextInt(users.length - 1);
      User user = User.fromMap(users[randomNumber]);
      await userRepo.saveUser(jsonEncode(users[randomNumber]));
      emit(UserActive(user));
    } on TimeoutException catch(e){
      emit(UserInactive(error: 'Check your Internet connection and try again'));
    }catch(e){
      emit(UserInactive(error: e.toString()));
    }
}
}
