import 'package:mentoria_set_2025/annotation/getter.dart';
import 'package:mentoria_set_2025/annotation/validator.dart';
import 'package:mentoria_set_2025/annotation/validator/min_length_validator.dart';
import 'package:mentoria_set_2025/annotation/validator/not_null_validator.dart';

part 'user.g.dart';

@Getter()
@Validator()
class User {
  @NotNull(message: 'Nome obrigatório')
  final String? _name;

  @MinLength(8)
  final String? _password;
  final int _age = 42;
  @MinLength(8)
  final String email;

  User({String? name, required this.email, required String password})
    : _name = name,
      _password = password;
}
