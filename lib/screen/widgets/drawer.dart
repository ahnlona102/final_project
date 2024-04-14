import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:IntelliHome/constants/app_colors.dart';
import 'package:IntelliHome/global/common/toast.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // INITIALIZE USERNAME VARIABLE
  late String username = '';

  @override
  void initState() {
    super.initState();
    // CALL FUNCTION TO RETRIEVE USERNAME
    getUsername();
  }

  // FETCH USERNAME FROM FIRESTORE
  Future<void> getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        username = userSnapshot['username'] ?? '';
      });
    }
  }

  // SIGN OUT USER FROM APP
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // NAVIGATE TO SETTING SCREEN
  Future<void> setting() async {
    try {
      Navigator.pushReplacementNamed(context, '/setting');
    } catch (e) {
      print('Error: $e');
    }
  }

  // BUILD USER INFO OR LOGIN BUTTON
  Widget _buildUserInfoOrLoginButton() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome,',
            style: TextStyle(color: AppColor.white),
          ),
          SizedBox(height: 5),
          Text(
            username,
            style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Text('Đăng nhập'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget userInfoOrLoginButton = _buildUserInfoOrLoginButton();

    return SafeArea(
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.fg1Color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: AppColor.white),
                      );
                    },
                  ),
                ],
              ),

              // DISPLAY AVATAR
              Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    height: size.width * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/avatar.jpg"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 2,
                        color: AppColor.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  userInfoOrLoginButton,
                ],
              ),
              Divider(
                thickness: 0.5,
                color: AppColor.white,
                height: 40,
              ),
              drawerTile(Icons.tv_outlined, " Các thiết bị", () {}),
              drawerTile(Icons.bed_rounded, " Phòng", () {}),
              drawerTile(Icons.settings, " Cài đặt", () {
                setting();
              }),
              drawerTile(Icons.help_outline, " Trợ giúp", () {}),
              Spacer(),
              if (FirebaseAuth.instance.currentUser != null)
                drawerTile(Icons.power_settings_new_outlined, " Đăng xuất", () {
                  signOut();
                  showToast(message: "Bạn đã đăng xuất");
                }),
            ],
          ),
        ),
      ),
    );
  }

  // BUILD DRAWER TILE
  ListTile drawerTile(IconData icon, String title, VoidCallback ontap) {
    return ListTile(
      onTap: ontap,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: Icon(icon, color: AppColor.white),
      title: Text(
        title,
        style: TextStyle(color: AppColor.white),
      ),
    );
  }
}