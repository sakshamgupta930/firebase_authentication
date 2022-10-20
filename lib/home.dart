import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/email_auth/login_screen.dart';
import 'package:flutter_application_1/phone_auth/sign_in_with_phone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  File? profilepic;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => SignInWithPhone(),
        ));
  }

  void saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();
    int age = int.parse(ageString);

    nameController.clear();
    emailController.clear();
    ageController.clear();

    if (name != "" && email != "" && profilepic != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profilepictures")
          .child(Uuid().v1())
          .putFile(profilepic!);

      StreamSubscription tasksubscription =
          uploadTask.snapshotEvents.listen((event) {
        double percentage = event.bytesTransferred / event.totalBytes * 100;
        log(percentage.toString());
      });

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      tasksubscription.cancel();

      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "age": age,
        "profilepic": downloadUrl,
        "samplearray": [name, email, age],
      };
      FirebaseFirestore.instance.collection("users").add(userData);
      log("User Created!");
    } else {
      log("PLease fill all the details");
    }
    setState(() {
      profilepic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            CupertinoButton(
              onPressed: () async {
                XFile? selectedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (selectedImage != null) {
                  File convertedFile = File(selectedImage.path);
                  setState(() {
                    profilepic = convertedFile;
                  });
                  log("Image Selected");
                } else {
                  log("No Image Selected");
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 60,
                backgroundImage:
                    (profilepic != null) ? FileImage(profilepic!) : null,
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(label: Text("Name")),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(label: Text("Email Address")),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(label: Text("Age")),
            ),
            SizedBox(height: 20),
            CupertinoButton(
              onPressed: () {
                saveUser();
              },
              child: Text("Save"),
              color: Colors.deepPurple,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  // .where("age", isGreaterThanOrEqualTo: 40)
                  // .orderBy("age", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userMap =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userMap["profilepic"])),
                            title:
                                Text(userMap["name"] + " (${userMap["age"]})"),
                            subtitle: Text(userMap["email"]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc("fx8cvdqrzX654oH1hi8F")
                                    .delete();
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    Text("No Data !");
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text("No widget to build");
              },
            )
          ],
        ),
      ),
    );
  }
}
