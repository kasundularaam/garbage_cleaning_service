part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucceed extends RegisterState {
  final TypeUser typeUser;
  RegisterSucceed({
    required this.typeUser,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterSucceed && other.typeUser == typeUser;
  }

  @override
  int get hashCode => typeUser.hashCode;

  @override
  String toString() => 'RegisterSucceed(typeUser: $typeUser)';
}

class RegisterFailed extends RegisterState {
  final String errorMsg;
  RegisterFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'RegisterFailed(errorMsg: $errorMsg)';
}
