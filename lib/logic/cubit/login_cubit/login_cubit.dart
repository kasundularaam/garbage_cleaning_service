import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/user_type.dart';
import '../../../data/models/type_user.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../data/validator/data_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static TypeUser user = TypeUser(
      userId: "456", userEmail: "user@gcs.com", userType: UserType.user);
  static TypeUser truck = TypeUser(
      userId: "123", userEmail: "truck@gcs.com", userType: UserType.driver);

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final bool validatedLogin =
          DataValidator.validateLogin(email: email, password: password);
      if (validatedLogin) {
        TypeUser typeUser = getTypeUser(email: email);

        await SharedAuth.clearData();
        await SharedAuth.addUser(typeUser: typeUser);
        emit(LoginSucceed(typeUser: typeUser));
      }
    } catch (e) {
      emit(LoginFailed(errorMsg: e.toString()));
      emit(LoginInitial());
    }
  }

  TypeUser getTypeUser({required String email}) {
    if (email == user.userEmail) {
      return user;
    }
    if (email == truck.userEmail) {
      return truck;
    }

    throw "Wrong credentials";
  }
}
