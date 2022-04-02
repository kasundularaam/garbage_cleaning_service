import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/type_user.dart';
import '../../../data/shared/shared_auth.dart';
import '../../../data/validator/data_validator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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
        Random random = Random();
        int id = random.nextInt(10000);

        TypeUser typeUser = TypeUser(
          userId: id.toString(),
          userEmail: email,
        );

        await SharedAuth.clearData();
        await SharedAuth.addUser(typeUser: typeUser);
        emit(RegisterSucceed(typeUser: typeUser));
      }
    } catch (e) {
      emit(RegisterFailed(errorMsg: e.toString()));
      emit(RegisterInitial());
    }
  }
}
