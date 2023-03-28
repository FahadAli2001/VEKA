import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veka/car/Mybookmark/rents/rentBookmarkController.dart';

class Rent extends StatelessWidget {
  final bool isBuy;
  const Rent({Key? key, required this.isBuy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    rentBookmarkController rbmc = Get.put(rentBookmarkController());

    return Scaffold(
      body: FutureBuilder(
        future: rbmc.getsharekeybyId(isBuy),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (rbmc.products.isEmpty) {
            return const Center(child: Text("No Bookmark"));
          }

          return ListView.builder(
              itemCount: rbmc.products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500)),
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.5,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(rbmc.products[index]
                                      ["images"][0]["src"]
                                  .toString()),
                              radius: 30,
                              backgroundColor: Colors.black54,
                            ),
                            title:
                                Text(rbmc.products[index]["name"].toString()),
                            subtitle: Text(
                              rbmc.products[index]["price"].toString(),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (rbmc.wishListId.containsValue(int.parse(
                                rbmc.products[index]["id"].toString()))) {
                              rbmc
                                  .removeBookmark(rbmc.wishListId["itemId"])
                                  .then((value) => Navigator.pop(context));
                            }
                          },
                          icon: const Icon(Icons.favorite),
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
