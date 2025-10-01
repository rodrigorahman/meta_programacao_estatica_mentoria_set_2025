# 🚀 Flutter Metaprogramming Workshop

Um projeto educacional demonstrando técnicas avançadas de **metaprogramação** e **geração de código** em Dart/Flutter usando `source_gen` e `build_runner`.

## 📋 Sobre o Projeto

Este projeto explora o poder da geração de código automática em Dart através de:
- ✨ **Annotations customizadas** para reduzir boilerplate
- 🔧 **Code generators** que analisam e geram código automaticamente
- 🛡️ **Sistema de validação** declarativo e extensível
- 📦 **Getters automáticos** para encapsulamento de campos privados

## 🎯 Funcionalidades

### 1️⃣ Geração Automática de Getters

Elimine o boilerplate de criar getters manualmente para campos privados.

**Antes:**
```dart
class User {
  final String? _name;
  final int _age;

  String? get name => _name;
  int get age => _age;
}
```

**Depois:**
```dart
@Getter()
class User {
  final String? _name;
  final int _age;
}

// Getters gerados automaticamente!
// user.name
// user.age
```

### 2️⃣ Sistema de Validação Declarativa

Defina regras de validação usando annotations e obtenha um método `validate()` completo gerado automaticamente.

```dart
@Validator()
class User {
  @NotNull(message: 'Nome obrigatório')
  final String? _name;

  @MinLength(8)
  final String? _password;

  @MinLength(8)
  final String email;
}

// Uso:
final user = User(name: null, email: 'test', password: '123');
final errors = user.validate();
// ['Nome obrigatório', 'Campo password deve ter no mínimo 8 caracteres', ...]
```

## 🏗️ Estrutura do Projeto

```
lib/
├── annotation/                 # Definições de annotations
│   ├── getter.dart            # @Getter annotation
│   ├── validator.dart         # @Validator annotation
│   └── validator/             # Annotations de validação
│       ├── not_null_validator.dart
│       └── min_length_validator.dart
├── generators/                # Code generators
│   ├── combined_generator.dart    # Combina todos os generators
│   ├── getter_generator.dart      # Gera getters
│   └── validation_generator.dart  # Gera validações
├── model/                     # Modelos de exemplo
│   ├── user.dart             # Modelo com annotations
│   └── user.g.dart           # Código gerado (não editar!)
└── main.dart                  # Aplicação Flutter
```

## 🚀 Começando

### Pré-requisitos

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2

### Instalação

1. **Clone o repositório**
```bash
git clone <repository-url>
cd mentoria_set_2025
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o code generator**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Para desenvolvimento contínuo (watch mode)**
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

5. **Execute o app**
```bash
flutter run
```

## 💡 Como Usar

### Criando um Modelo com Validação

```dart
import 'package:mentoria_set_2025/annotation/getter.dart';
import 'package:mentoria_set_2025/annotation/validator.dart';
import 'package:mentoria_set_2025/annotation/validator/min_length_validator.dart';
import 'package:mentoria_set_2025/annotation/validator/not_null_validator.dart';

part 'my_model.g.dart';

@Getter()
@Validator()
class MyModel {
  @NotNull(message: 'Campo obrigatório')
  final String? _field1;

  @MinLength(5, message: 'Mínimo 5 caracteres')
  final String? _field2;

  MyModel({String? field1, String? field2})
      : _field1 = field1,
        _field2 = field2;
}
```

### Usando o Código Gerado

```dart
void main() {
  final model = MyModel(field1: null, field2: 'abc');

  // Usando getters gerados
  print(model.field1); // null
  print(model.field2); // 'abc'

  // Validando
  final errors = model.validate();
  if (errors.isNotEmpty) {
    print('Erros de validação:');
    for (final error in errors) {
      print('- $error');
    }
  }
}
```

## 🔧 Validadores Disponíveis

| Validator | Descrição | Exemplo |
|-----------|-----------|---------|
| `@NotNull` | Campo não pode ser nulo | `@NotNull(message: 'Obrigatório')` |
| `@MinLength` | Tamanho mínimo de string | `@MinLength(8, message: 'Mín. 8 chars')` |

## 🎓 Conceitos Aprendidos

### Metaprogramação em Dart
- Como criar annotations customizadas
- Análise de código usando `analyzer` package
- Geração de código com `source_gen`
- Configuração de builders com `build.yaml`

### Design Patterns
- **Builder Pattern**: `build_runner` constrói código incrementalmente
- **Visitor Pattern**: Percorre a AST (Abstract Syntax Tree) do Dart
- **Code Generation**: Reduz boilerplate e aumenta produtividade

### Arquitetura
- Separação entre definições (annotations) e implementação (generators)
- Extensibilidade através de novos validators
- Uso de `part` e `part of` para código gerado

## 📚 Estendendo o Sistema

### Criando um Novo Validator

1. **Defina a annotation**
```dart
// lib/annotation/validator/max_value_validator.dart
class MaxValue {
  final int max;
  final String message;

  const MaxValue(this.max, {this.message = ''});
}
```

2. **Implemente a lógica no generator**
```dart
// Em validation_generator.dart
if (annotation.type.element?.name == 'MaxValue') {
  final maxValue = annotation.getField('max')?.toIntValue();
  buffer.writeln('if ($fieldName > $maxValue) {');
  buffer.writeln('  errors.add("$fieldDisplay deve ser no máximo $maxValue");');
  buffer.writeln('}');
}
```

3. **Regenere o código**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🛠️ Comandos Úteis

```bash
# Limpar cache e arquivos gerados
flutter pub run build_runner clean

# Gerar código (sobrescrever conflitos)
flutter pub run build_runner build --delete-conflicting-outputs

# Modo watch (regenera automaticamente)
flutter pub run build_runner watch

# Análise de código
flutter analyze

# Formatar código
dart format .

# Executar testes
flutter test
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Este é um projeto educacional e melhorias são sempre apreciadas.

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/NovoValidator`)
3. Commit suas mudanças (`git commit -m 'Adiciona validator @Email'`)
4. Push para a branch (`git push origin feature/NovoValidator`)
5. Abra um Pull Request

## 📖 Recursos Adicionais

- [Dart Code Generation](https://dart.dev/guides/libraries/create-library-packages#organizing-a-library-package)
- [source_gen Package](https://pub.dev/packages/source_gen)
- [build_runner Package](https://pub.dev/packages/build_runner)
- [analyzer Package](https://pub.dev/packages/analyzer)

## 📝 Licença

Este projeto é um material educacional desenvolvido para fins de aprendizado e mentoria.

## 👥 Autores

Projeto desenvolvido como parte do programa de mentoria - Setembro 2025

---

**Feito com ❤️ e muito código gerado automaticamente!**
