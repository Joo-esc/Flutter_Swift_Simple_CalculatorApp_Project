import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mvvvm/controller.dart';
import 'package:mvvvm/model.dart';
import 'package:mvvvm/view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final model = PostModel();
    final viewModel = PostVM(model: model);
    Get.put(PostVM(model: model)).count;
    final controller = Get.put(PostVM(model: model));

    void addItem() {
      viewModel.addList();
    }

    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.addList();
            controller.increase();
            Get.find<PostVM>().increase();
          },
        ),
        body: GetBuilder<PostVM>(
          init: PostVM(model: model),
          builder: (_) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.list.length,
                  itemBuilder: (btx, index) {
                    return Text(_.list[index].title);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.filteringBasedOnType(0);
                  },
                  child: Text("FITLER0"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.filteringBasedOnType(1);
                  },
                  child: Text("FITLER1"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.filteringBasedOnType(2);
                  },
                  child: Text("FITLER2"),
                ),
              ],
            );
          },
        ));
  }
}
