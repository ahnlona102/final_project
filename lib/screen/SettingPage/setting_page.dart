import 'package:IntelliHome/constants/app_colors.dart';
import 'package:IntelliHome/screen/SettingPage/components/forward_button.dart';
import 'package:IntelliHome/screen/SettingPage/components/setting_item.dart';
import 'package:IntelliHome/screen/SettingPage/components/setting_switch.dart';
import 'package:IntelliHome/screen/SettingPage/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // INITIALIZE USERNAME VARIABLE
  late String username = '';
  late String userEmail = '';

  @override
  void initState() {
    super.initState();
    // CALL FUNCTION TO RETRIEVE USERNAME
    getUsernameAndEmail();
  }
  
  // FETCH USERNAME AND EMAIL FROM FIRESTORE
  Future<void> getUsernameAndEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        username = userSnapshot['username'] ?? '';
        userEmail = user.email ?? ''; // Lấy email của người dùng từ Firebase Authentication
      });
    }
  }

  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cài đặt",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Tài khoản",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 20),

              // ACCOUNT SETTING
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/avatar.jpg",
                      width: 70,
                      height: 70,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userEmail,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.grey
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    fowardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const editProfile()
                          )
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Cài đặt",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500
                )
              ),
              SizedBox(height: 20),
          
              // LANGUAGE SETTING BUTTON
              settingItem(
                title: 'Ngôn ngữ',
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "Tiếng Việt",
                onTap: () {},
              ),
              SizedBox(height: 20),
              
              // NOTIFICATION SETTING BUTTON
              settingItem(
                title: 'Thông báo',
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              SizedBox(height: 20),
          
              // DARK MODE SETTING BUTTON
              settingSwitch(
                title: 'Dark Mode',
                icon: Ionicons.earth,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              SizedBox(height: 20),
          
              // HELP SETTING BUTTON
              // settingItem(
              //   title: 'Trợ giúp',
              //   icon: Ionicons.help,
              //   bgColor: Colors.red.shade100,
              //   iconColor: AppColor.red,
              //   onTap: () {},
              // )
            ],
          ),
        ),
      ),
    );
  }
}
