import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/checker/ticket_checker_checker.dart';
import '../../../data/models/type_user.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../data/validator/data_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());

      final bool validatedLogin =
          DataValidator.validateLogin(email: email, password: password);
      if (validatedLogin) {
        TypeUser typeUser =
            await getUserTypeData(email: email, password: password);
        await SharedAuth.clearData();
        await SharedAuth.addUser(typeUser: typeUser);
        emit(LoginSucceed(typeUser: typeUser));
      }
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
      emit(LoginInitial());
    }
  }

  Future<TypeUser> getUserTypeData(
      {required String email, required String password}) async {
    try {
      final bool isTicketChecker = TicketCheckerChecker.isTicketChecker(
          email: email, password: password);

      if (isTicketChecker) {
        TypeUser typeUser = TypeUser(
          userId: TicketCheckerChecker.uid,
          userEmail: email,
        );
        await SharedAuth.clearData();
        await SharedAuth.addUser(typeUser: typeUser);
        return typeUser;
      }

      Random random = Random();
      int id = random.nextInt(10000);

      TypeUser fireUser = TypeUser(userId: id.toString(), userEmail: email);
      return fireUser;
    } catch (e) {
      throw e.toString();
    }
  }
}
