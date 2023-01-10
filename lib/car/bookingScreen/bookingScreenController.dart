import 'package:get/get.dart';

class bookingScreenController extends GetxController{

  var persons = [
    '1',
    '2',
    '3',
    '4',
  ];
  var persondropdownvalue = '1'.obs;

  void personSelected(String value){
    persondropdownvalue.value = value;
  }
  var carqnty = [
    '1',
    '2',
    '3',
    '4',
  ];
  var carqntyvalue = '1'.obs;

  void carqntySelected(String value){
    carqntyvalue.value = value;
  }
  var paymenttype = [
    "cash on delivery",
    "online payment"

  ];

  var paymenttypevalue = 'cash on delivery'.obs;

  void paymentTypeSelected(String value){
    paymenttypevalue.value = value;
  }

  var babyvalue = false.obs;
  void handleRadioValueChanged(val) {
    babyvalue.value = val;
  }

  var childrenvalue = false.obs;
  void handleRadioValueChanged1(val) {
    childrenvalue.value = val;
  }
}