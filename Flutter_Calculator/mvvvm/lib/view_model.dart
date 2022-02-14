import 'package:get/get.dart';
import 'package:mvvvm/model.dart';

class PostVM extends GetxController {
  int count = 0;
  PostModel _newPost;
  PostVM({required PostModel model}) : _newPost = model;

  List<Post> get list {
    return _newPost.itemList;
  }

  void filteringBasedOnType(int type) {
    _newPost.filteringBasedOnType(type);
    update();
  }

  void increase() {
    count++;
    update();
  }

  void addList() {
    _newPost.addList();
    update();
  }
}
