import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mentoria_set_2025/annotation/getter.dart';
import 'package:source_gen/source_gen.dart';

Builder gettersBuilder(BuilderOptions options) =>
    PartBuilder([GetterGenerator()], '.g.dart');

class GetterGenerator extends GeneratorForAnnotation<Getter> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw ArgumentError('Getter annotation can only be used on classes');
    }

    final className = element.name;
    final buffer = StringBuffer();

    final privateFields = element.fields.where((f) => f.isPrivate);

    if (privateFields.isEmpty) {
      throw ArgumentError(
        'Class $className must have at least one private field',
      );
    }

    buffer.writeln('extension ${className}Getters on $className {');
    for (final f in privateFields) {
      //  _name
      final fieldName = f.name ?? '';
      // name
      final getterName = fieldName.substring(1);
      // String
      final fieldType = f.type.getDisplayString();

      buffer.writeln('   $fieldType get $getterName => $fieldName;');
    }
    buffer.writeln('}');

    return buffer.toString();
  }
}
