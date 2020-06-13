class CategoryStore {
  int id;
  String title;
  String description;

  CategoryStoreMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = title;
    mapping['description'] = description;

    return mapping;
  }
}
