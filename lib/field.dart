class Filed {
  String name;
  String type;
  bool required;
  String? value;
  bool isList;
  String? subType;

  Filed({
    required this.name,
    required this.type,
    this.required = false,
    this.value,
    this.isList = false,
    this.subType,
  });
}
