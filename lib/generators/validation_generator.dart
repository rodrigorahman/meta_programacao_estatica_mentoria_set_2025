import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:mentoria_set_2025/annotation/validator.dart';
import 'package:source_gen/source_gen.dart';

Builder validationBuilder(BuilderOptions options) =>
    PartBuilder([ValidationGenerator()], '.g.dart');

class ValidationGenerator extends GeneratorForAnnotation<Validator> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();

    if (element is! ClassElement) {
      throw ArgumentError('Getter annotation can only be used on classes');
    }

    final className = element.name;
    buffer.writeln('extension ${className}Validator on $className {');
    buffer.writeln('  List<String> validate() {');
    buffer.writeln('    final errors = <String>[];');

    for (final f in element.fields) {
      final fieldName = f.name;

      for (final annotation in f.metadata.annotations) {
        final annotationValue = annotation.computeConstantValue();
        if (annotationValue == null) continue;

        final annotationType = annotationValue.type?.getDisplayString() ?? '';

        if (annotationType == 'NotNull') {
          var message =
              annotationValue.getField('message')?.toStringValue() ??
              'Campo $fieldName não pode ser nulo';

          if (message.isEmpty) {
            message =
                'Campo ${fieldName?.replaceAll('_', '')} não pode ser nulo';
          }
          buffer.writeln('    if($fieldName == null) {');
          buffer.writeln('      errors.add(\'$message\');');
          buffer.writeln('    }');
          buffer.writeln();
        }

        if (annotationType == 'MinLength') {
          final length = annotationValue.getField('length')?.toIntValue() ?? 0;
          final message =
              annotationValue.getField('message')?.toStringValue() ?? '';

          final errorMessage = message.isEmpty
              ? 'Campo ${fieldName?.replaceAll('_', '')} deve ter no mínimo $length caracteres'
              : message;

          if (f.type.nullabilitySuffix == NullabilitySuffix.question) {
            buffer.writeln('    if($fieldName == null) {');
            buffer.writeln(
              '      errors.add(\'Campo $fieldName não pode ser nulo\');',
            );
            buffer.writeln('    }else if($fieldName.length < $length){');
            buffer.writeln('      errors.add(\'$errorMessage\');');
            buffer.writeln('    }');
            buffer.writeln();
          } else {
            buffer.writeln('  if($fieldName.length < $length){');
            buffer.writeln('    errors.add(\'$errorMessage\');');
            buffer.writeln('  }');
            buffer.writeln();
          }
        }
      }
    }
    buffer.writeln('    return errors;');
    buffer.writeln('  }');
    buffer.writeln('}');
    return buffer.toString();
  }
}
