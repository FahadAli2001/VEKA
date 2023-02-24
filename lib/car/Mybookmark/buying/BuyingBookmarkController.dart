import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyingBookmarkController extends GetxController{

  var isbookedmark = false.obs;

  Future<void> toggleBookmark(String productId, String productName, String productPrice, String productImage,) async {
    //SharedPreferences rentBookmarksp =await SharedPreferences.getInstance();
    // get current user
    SharedPreferences bmrvalue = await SharedPreferences.getInstance();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // user not signed in
      return;
    }
    // reference to bookmarks collection for this user
    final bookmarksRef = FirebaseFirestore.instance
        .collection('BuyCar-bookmarks')
        .doc(user.uid)
        .collection('productIds')
        .doc(productId);

    // check if product is already bookmarked
    final snapshot = await bookmarksRef.get();
    if (snapshot.exists) {
      // already bookmarked, so remove it
      await bookmarksRef.delete();
      isbookedmark.value = false;

      //print(bmvalue.getBool("isBookmark"));
      bmrvalue.setBool("isBookmark", isbookedmark.value);
      print('Bookmark removed for product ');
      print(isbookedmark.value);
      print(bmrvalue.getBool("isBookmark"));
    } else {
      // product not bookmarked yet, so add it
      await bookmarksRef.set({
        'name': productName,
        'price': productPrice,
        'image': productImage,
        'isBookmark': true
      }, SetOptions(merge: true));
      print('Bookmark added for product');
      // isbookedmark.value = true;
      //rentBookmarksp.setBool("isBookmark", isbookedmark.value);
    }

    final isBookmarkSnapshot = await bookmarksRef.get();
    if (isBookmarkSnapshot.exists) {
      isbookedmark.value = isBookmarkSnapshot.data()!['isBookmark'] ?? false;
      print(isbookedmark.value);

      bmrvalue.setBool('isBookmark', isbookedmark.value);
      print(bmrvalue.getBool('isBookmark'));

    }
  }

}