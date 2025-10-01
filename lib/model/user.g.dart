// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'user.dart';

// **************************************************************************
// GetterGenerator
// **************************************************************************

extension UserGetters on User {
  String? get name => _name;
  String? get password => _password;
  int get age => _age;
}

// **************************************************************************
// ValidationGenerator
// **************************************************************************

extension UserValidator on User {
  List<String> validate() {
    final errors = <String>[];
    if (_name == null) {
      errors.add('Nome obrigatório');
    }

    if (_password == null) {
      errors.add('Campo _password não pode ser nulo');
    } else if (_password.length < 8) {
      errors.add('Campo password deve ter no mínimo 8 caracteres');
    }

    if (email.length < 8) {
      errors.add('Campo email deve ter no mínimo 8 caracteres');
    }

    return errors;
  }
}
