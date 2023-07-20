import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:petzz_project/data_controller.dart';
import 'signinscreen.dart';

class LoginUserAdds extends StatelessWidget {
  final DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getLoginUserProduct();
    });

    return Scaffold(
      appBar: AppBar(title: Text("My Adds"), actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'logout') {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => signinscreen()));
              });
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'logout',
              child: Text('Log Out', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ]),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.loginUserData.isEmpty
            ? Center(
                child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
              )
            : ListView.builder(
                itemCount: controller.loginUserData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            controller.loginUserData[index].a_image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Name: ${controller.loginUserData[index].a_name}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Phone: ${controller.loginUserData[index].a_phone_number}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Edit'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
