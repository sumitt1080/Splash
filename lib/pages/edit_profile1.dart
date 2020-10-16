import 'dart:ui';

import 'package:Splash/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import '../models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EditProfilePage1 extends StatelessWidget {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool _displayNameValid = true;
  bool _bioValid = true;

  _logout(BuildContext context) async {
    await googleSignIn.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  Widget buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: name,
          ),
        ),
      ],
    );
  }

  changeProfilePhoto(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Photo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Changing your profile photo has not been implemented yet'),
              ],
            ),
          ),
        );
      },
    );
  }

  applyChanges() {
    usersRef.doc(currentUser.id).update({
      "displayName": displayNameController.text,
      "bio": bioController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: usersRef.doc(currentUser.id).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());

          User user = User.fromDocument(snapshot.data);

          displayNameController.text = user.displayName;
          bioController.text = user.bio;

          return FadeAnimation(1.0,
                      Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.photoUrl),
                    radius: 50.0,
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      changeProfilePhoto(context);
                    },
                    child: Text(
                      "Change Photo",
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeAnimation(1.2,
                                    Column(
                      children: <Widget>[
                        buildDisplayNameField(),
                        buildBioField(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    onPressed: () {
                      _logout(context);
                    },
                    child: Text("Logout"),
                  ),
                )
              ],
            ),
          );
        });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Display Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
            errorText: _displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "Update Bio",
            errorText: _bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }
}
