import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:petzz_project/data_controller.dart';
import 'package:petzz_project/login_user_adds.dart';
import 'signinscreen.dart';

class AnimalList extends StatelessWidget {
  final DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllProduct();
    });

    return Scaffold(
      appBar: AppBar(title: Text("All Adds"), actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'myadds') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginUserAdds()));
            }
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
              value: 'myadds',
              child: Text('My Adds', style: TextStyle(color: Colors.black)),
            ),
            PopupMenuItem<String>(
              value: 'logout',
              child: Text('Log Out', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ]),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.allAnimals.isEmpty
            ? Center(
                child: Text('😔 NO DATA FOUND (: 😔'),
              )
            : ListView.builder(
                itemCount: controller.allAnimals.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            controller.allAnimals[index].a_image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Name: ${controller.allAnimals[index].a_name}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Phone: ${controller.allAnimals[index].a_phone_number.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Animal: ${controller.allAnimals[index].a_tbr}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Location: ${controller.allAnimals[index].a_location}",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
