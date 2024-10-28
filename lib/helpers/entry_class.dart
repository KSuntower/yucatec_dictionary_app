class Entry {
  List<String> flags = [];
  String yucatecWord = "nil";
  List<String>definition = [];
  List<String> specialDefinition = [];
  List<String> example = [];
  List<String> exampleTranslation = [];
  List<int> categories = [];

  Entry(this.flags, this.yucatecWord, this.definition,
      this.specialDefinition, this.example, this.exampleTranslation, this.categories);

  Entry.fromMap(Map<dynamic, dynamic> map) {
    flags = map['Flags'].split(';');
    yucatecWord = map['WordYuc'];
    definition = map['Definition'].split(';');
    example = map['Example'].split(';');
    exampleTranslation = map['WordEsp'].split(';');
    // List<String> cat = map['Categories'].split(',');
    // categories = cat.map(int.parse).toList();

    if (map['Single'] == ".") {
      specialDefinition = map['Definition'].split(';');
      return;
    }
    specialDefinition = map['Single'].split(';');
  }
}
