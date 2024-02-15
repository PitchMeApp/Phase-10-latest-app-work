import 'package:get/get.dart';
import 'package:pitch_me_app/View/posts/post_conttroller.dart';

class PostBindng extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
  }
}
