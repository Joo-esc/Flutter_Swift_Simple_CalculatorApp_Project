class PostModel {
  var itemList = postList;

  void addList() {
    itemList.add(Post(title: "newItem", type: 2));
  }

  // 프로퍼티 필터링 로직
  void filteringBasedOnType(int type) {
    var newArray = postList
        .where((element) => element.type == type)
        .toList(); // prevent iterable
    itemList = newArray;
  }
}

/* Post Model */
class Post {
  String title;
  int type;
  Post({required this.title, required this.type});
}

/* Post List (Constant) */
List<Post> postList = [
  Post(title: "semi0", type: 0),
  Post(title: "semi0", type: 0),
  Post(title: "semi1", type: 1),
  Post(title: "semi1", type: 1),
  Post(title: "semi2", type: 2),
  Post(title: "semi2", type: 2)
];
