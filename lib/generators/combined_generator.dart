import 'package:build/build.dart';
import 'package:mentoria_set_2025/generators/getter_generator.dart';
import 'package:mentoria_set_2025/generators/validation_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder codeGenBuilder(BuilderOptions options) =>
    PartBuilder([GetterGenerator(), ValidationGenerator()], '.g.dart');
