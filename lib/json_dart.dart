import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';

import 'builder.dart';

Builder jsonBuilder(BuilderOptions options) => JsonBuilder();

class JsonBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final input = buildStep.inputId;
    final output = AssetId(
      input.package,
      input.path.replaceFirst('jsons/', 'lib/models/').replaceFirst(".json", ".g.dart"),
    );

    final content = await buildStep.readAsString(input);
    final fileName = input.pathSegments.last.replaceFirst('.json', '');
    final builder = GenerateBuilder(name: fileName, data: jsonDecode(content));
    final buffer = StringBuffer(builder.source);
    if (builder.fields.isNotEmpty) {
      for (final item in builder.newFiles.entries) {
        final nBuilder = GenerateBuilder(name: item.key, data: item.value);
        buffer.write(nBuilder.source);
      }
    }

    await buildStep.writeAsString(output, buffer.toString());
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        '^jsons/{{}}.json': ['lib/models/{{}}.g.dart']
      };
}
