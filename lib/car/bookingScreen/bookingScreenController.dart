import 'package:get/get.dart';

class bookingScreenController extends GetxController{
  var persondropdownvalue = '1'.obs;
  var carqntyvalue = '1'.obs;
  var paymenttypevalue = 'cash on delivery'.obs;
  var childrenvalue = false.obs;
  var babyvalue = false.obs;
  RxInt total = 0.obs;
  RxInt subtotal = 0.obs;


  var persons = [
    '1',
    '2',
    '3',
    '4',
  ];



  void personSelected(String value){
    persondropdownvalue.value = value;
  }
  var carqnty = [
    '1',
    '2',
    '3',
    '4',
  ];


  void carqntySelected(String value){
    carqntyvalue.value = value;
  }

  var paymenttype = [
    "cash on delivery",
    "online payment"
  ];



  void paymentTypeSelected(String value){
    paymenttypevalue.value = value;
  }


  void handleRadioValueChanged(val) {
    babyvalue.value = val;
  }


  void handleRadioValueChanged1(val) {
    childrenvalue.value = val;
  }

  int totalcarPrice(List isSelected , List charges, carprice){
     total.value = int.parse(carprice);
    for (var entry in isSelected.asMap().entries) {
      if (entry.value == true) {
        print('Index ${entry.key} has value of true');
        total.value +=  int.parse(charges[entry.key]);
      }
      /*else{
        total.value = int.parse(carprice);
      }*/
    }
    return total.value;
  }


}