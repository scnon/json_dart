# File with heading

This is a simple package to help build dart model from json.

## Features

About json file you can add some sign to assign default or nullable or not like this:

```json
{
  "r@id": 1,
  "d@sex": 1,
  "name": "Jack"
}
```

you will get like this:

```dart
class ExampleModel {
final int id;
final int sex;
final String? name;
ExampleModel({required this.id, this.sex = 1, this.name})
}
```

And you can use custom class List like this:

```json
{
  "list": "[]example"
}
```

```dart
final List<ExampleModel> list;
```

Also it support nested object like this:

```json
{
  "list": {
    "length": 3,
    "body": []
  }
}
```

It will auto generate a class named ***ListItemModel***

## Getting started

## Usage

1. Add to your ***pubspec.yaml***

```yaml
dev_dependencies:
  build_runner: any
  json_dart:
    git:
      url: git://github.com/scnon/json_dart.git
```

1. You need put some json file to your jsons folder.like this:

```bash
├── jsons
│   ├── class.json
│   └── user.json
├── libs
│   └── main.dart
```

1. Just run it like this:

```bash
dart run build_runner build
```

1. You will see you json model file in ***lib/models/***

1. Enjoy it.
