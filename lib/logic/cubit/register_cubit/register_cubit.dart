import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/enums/user_type.dart';
import '../../../data/models/type_user.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../data/validator/data_validator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static TypeUser user = TypeUser(
      userId: "456", userEmail: "user@gcs.com", userType: UserType.user);
  static TypeUser truck = TypeUser(
      userId: "123", userEmail: "truck@gcs.com", userType: UserType.driver);

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      emit(RegisterLoading());

      final bool validatedRegister = DataValidator.validateRegister(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (validatedRegister) {
        TypeUser typeUser = getTypeUser(email: email);

        await SharedAuth.clearData();
        await SharedAuth.addUser(typeUser: typeUser);
        emit(RegisterSucceed(user: typeUser));
      }
    } catch (e) {
      emit(RegisterFailed(errorMsg: e.toString()));
      emit(RegisterInitial());
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
