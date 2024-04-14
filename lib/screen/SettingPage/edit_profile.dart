import 'package:IntelliHome/screen/SettingPage/components/editprofile_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(50, 50),
                elevation: 5
              ),
              icon: Icon(
                Ionicons.checkmark_outline,
                color: Colors.white
              )
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 40),
        
              // EDIT AVATAR
              editItem(
                title: "Photo",
                widget: Column(
                  children: [
                    Image.asset(
                      "assets/images/avatar.jpg",
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent
                      ),
                      child: Text(
                        "Upload Image"
                      )
                    )
                  ],
                ),
              ),
        
              // EDIT NAME
              editItem(
                title: "Name",
                widget: TextField()
              ),
        
              SizedBox(height: 40),
              
              // EDIT EMAIL
              editItem(
                title: "Email",
                widget: TextField()
              )
            ],
          ),
        ),
      ),
    );
  }
}