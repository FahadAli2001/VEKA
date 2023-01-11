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

  int totalcarPrice(int val){
    total.value = val*int.parse(carqntyvalue.value);
    return total.value;
  }

  subTotalofRent(int carprice){
    if(childrenvalue.value == false && babyvalue.value == false){
      subtotal.value = total.value;
    }
    else if(childrenvalue.value == true && babyvalue.value==true){
      subtotal.value = total.value + 20;

    }
    else{

      subtotal.value = total.value + 10;
    }
    return subtotal.value;
  }
}