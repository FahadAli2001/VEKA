import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class rentBookmarkController extends GetxController{

  var RentBookmarkList = [].obs;

  marktoFav (id,name,price,image) {
    RentBookmarkList.add(rentbookmarkModel(id: id, name: name, price: price, image: image));
  }
  deleteFrombookMark (id,name,price,image){
    RentBookmarkList.remove(rentbookmarkModel(id: id, name: name, price: price, image: image));
  }

}

class rentbookmarkModel {
  String? id;
  String? name;
  String? price;
  String? image;

  rentbookmarkModel({required this.id , required this.name , required this.price , required this.image});
}
