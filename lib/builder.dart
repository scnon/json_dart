import 'package:dart_style/dart_style.dart';

import 'field.dart';
import 'tmpl.dart';

class GenerateBuilder {
  String _className = "";
  String _imports = "";
  String _fields = "";
  String _ctor = "";
  String _fromJson = "";
  String _toJson = "";

  final String name;
  final newTypeList = [];
  final fields = <Filed>[];
  final Map<String, Map> _newFiles = {};
  final formatter = DartFormatter();
  final StringBuffer buffer = StringBuffer();

  GenerateBuilder({required this.name, dynamic data}) {
    _className = getClassName(name);

    if (data is Map) {
      initFields(data as Map<String, dynamic>);

      _imports = newTypeList.map((e) => "import '${e}.g.dart';").join('\n');
      _fields = generateFields();
      _ctor = generateCtor();
      _fromJson = generateFromJson();
      _toJson = generateToJson();
    } else {
      throw Exception("Please provide a json map data.");
    }
  }

  String get className => _className;
  Map<String, Map> get newFiles => _newFiles;
  bool isNewType(String type) => newTypeList.contains(type);
  String getClassName(String name) => name[0].toUpperCase() + name.substring(1) + "Model";

  String get text => template
      .replaceAll('{{imports}}', _imports)
      .replaceAll('{{className}}', className)
      .replaceAll('{{fields}}', _fields)
      .replaceAll('{{ctor}}', _ctor)
      .replaceAll('{{fromJson}}', _fromJson)
      .replaceAll('{{toJson}}', _toJson);

  String get source => formatter.format(text);

  initFields(Map<String, dynamic> data) {
    for (final item in data.keys) {
      final field = Filed(name: item, type: data[item].runtimeType.toString());
      final value = data[item];
      if (item.contains("@")) {
        if (item.startsWith("r@")) {
          field.required = true;
          field.name = item.split("@")[1];
        } else if (item.startsWith("d@")) {
          field.value = value;
          field.name = item.split("@")[1];
        }
      }

      if (value is String) {
        if (value.startsWith("[]\$")) {
          final type = value.substring(3);
          newTypeList.add(type);

          field.type = type;
          field.isList = true;
        } else {
          field.type = "String";
        }
      } else if (value is int) {
        field.type = "int";
      } else if (value is double) {
        field.type = "double";
      } else if (value is bool) {
        field.type = "bool";
      } else if (value is List) {
        field.isList = true;
        field.type = value.first.runtimeType.toString();
      } else if (value is Map) {
        _newFiles[item + "Item"] = value;
        continue;
      }

      fields.add(field);
    }
  }

  String generateFields() {
    final buffer = StringBuffer();
    for (var item in fields) {
      final nullable = item.required || item.isList || (item.value != null) ? "" : "?";
      final type = item.isList && isNewType(item.type) ? getClassName(item.type) : item.type;
      buffer.write('final ${item.isList ? "List<" : ""}$type${item.isList ? ">" : ""}$nullable ${item.name};\n');
    }

    return buffer.toString();
  }

  String generateCtor() {
    final buffer = StringBuffer();
    for (final item in fields) {
      if (item.isList) {
        buffer.write('this.${item.name} = const [], ');
        continue;
      }
      final required = item.required ? "required" : "";
      final defualtValue = item.value != null ? " = ${item.value}" : "";
      buffer.write('$required this.${item.name}$defualtValue, ');
    }
    return buffer.toString();
  }

  String generateFromJson() {
    final buffer = StringBuffer();
    for (final item in fields) {
      buffer.write("${item.name}: ");
      final nullable = item.required || item.value != null ? "" : "?";
      if (item.isList) {
        buffer.write("json[\'${item.name}\'] == null ? [] : ");
        if (isNewType(item.type)) {
          buffer.write(
              "(json[\'${item.name}\'] as List).map((e) => ${getClassName(item.type)}.fromJson(e as Map<String, dynamic>)).toList(), ");
        } else {
          buffer.write("(json[\'${item.name}\'] as List).map((e) => e as ${item.type}).toList(), ");
        }
      } else {
        buffer.write("json[\'${item.name}\'] as ${item.type}$nullable, ");
      }
    }
    return buffer.toString();
  }

  String generateToJson() {
    return fields.map((e) => '      \'${e.name}\': ${e.name},').join('\n');
  }
}
