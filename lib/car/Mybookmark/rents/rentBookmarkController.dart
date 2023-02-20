import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class rentBookmarkController extends GetxController{

  RxList RentBookmarkList = [].obs;

  marktoFav (rentbookmarkModel model) {
    RentBookmarkList.value.add(model);
  }
  deleteFrombookMark (rentbookmarkModel model){
    RentBookmarkList.value.remove(model);
  }

  void checkModel(rentbookmarkModel model) {
    if (RentBookmarkList.contains(model)) {
      print("${model.name} exists in the list");
      RentBookmarkList.remove(model);
      print(" removed");
    } else {
      print("${model.name} does not exist in the list");
        RentBookmarkList.add(model);
      print(" added");
    }
  }


}





class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});
}
