import 'package:noteapp/category.dart';
import 'package:noteapp/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  //Create Data
  saveCategory(CategoryStore category) async {
    return await _repository.insertData(
        'categories', category.CategoryStoreMap());
  }

  //Read Data From Table
  readCategories() async {
    return await _repository.readData('categories');
  }

  //Read Data From Table by Id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  //Update Data From Table
  updateCategory(CategoryStore categoryStore) async {
    return await _repository.updateDate(
        'categories', categoryStore.CategoryStoreMap());
  }

  //Delete Data From Table
  deleteCategory(categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }
}
