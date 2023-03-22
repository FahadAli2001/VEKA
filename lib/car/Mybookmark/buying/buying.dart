import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../SignIn/SignInController.dart';
import 'BuyingBookmarkController.dart';

class buying extends StatelessWidget {
  const buying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController sic = Get.put(SignInController());
    BuyingBookmarkController bbmc = Get.put(BuyingBookmarkController());
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('BuyCar-bookmarks')
        .doc(sic.userId)
        .collection('productIds')
        .snapshots();
    //var bookmark = true.obs;
    return Scaffold(
      body: StreamBuilder(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("some thing went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Center(child: Text("no data"));
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500)),
                    width: Get.width,
                    //height: Get.height * 0.11,
                    //color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.5,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data[index]["image"].toString()),
                              radius: 30,
                              backgroundColor: Colors.black54,
                            ),
                            title: Text(data[index]["name"].toString()),
                            subtitle: Text(
                              data[index]["price"].toString(),
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            bbmc.toggleBookmark(
                                data[index]["id"].toString(),
                                data[index]["name"].toString(),
                                data[index]["price"].toString(),
                                data[index]["image"].toString());
                          },
                          icon: Icon(Icons.favorite),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
