import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:IntelliHome/constants/app_colors.dart';
import 'package:IntelliHome/global/common/toast.dart';
// import 'package:IntelliHome/screen/Auth/firebase_auth_implementation/firebase_auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // FIREBASE AUTHENTICATION SERVICE INSTANCE
  // final FirebaseAuthService _auth = FirebaseAuthService();

  // TEXT EDITING CONTROLLERS FOR USERNAME, EMAIL, AND PASSWORD
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // INDICATE USER SIGNING PROCESS AND PASSWORD VISIBILITY
  bool isSigning = false;
  bool isObscure = true;

  @override
  void dispose() {
    // DISPOSE TEXT EDITING CONTROLLERS WHEN NOT NEEDED
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 45,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.keyboard_arrow_left, color: AppColor.grey, size: 30,),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 120),
                  child: Column(
                    children: [
                      Text(
                        'Đăng ký ngay',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Vui lòng đăng ký để sử dụng ứng dụng',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                      ),

                      // INPUT NAME
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _usernameController,
                          cursorColor: Color(0xffF5591F),
                          decoration: InputDecoration(
                            hintText: "Tên đăng nhập",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),

                      //INPUT EMAIL
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Color(0xffEEEEEE)),
                          ],
                        ),
                        child: TextField(
                          controller: _emailController,
                          cursorColor: Color(0xffF5591F),
                          decoration: InputDecoration(
                            hintText: "example@gmail.com",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),

                      //INPUT PASSWORD
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)
                            ),
                          ],
                        ),

                        // SHOW/HIDE PASSWORD
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                cursorColor: Color(0xffF5591F),
                                decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                obscureText: isObscure,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isObscure ? Icons.visibility_off : Icons.visibility,
                                color: AppColor.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            )
                          ],
                        ),
                      ),

                      // FORGET PASSWORD
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Write Click Listener Code Here
                          },
                          child: Text(
                            "Quên mật khẩu?",
                            style: TextStyle(color: AppColor.fgColor),
                          ),
                        ),
                      ),

                      // BUTTON REGISTER
                      GestureDetector(
                        onTap: () {
                          _signUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            color: AppColor.fgColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE)),
                            ],
                          ),
                          child: isSigning ? CircularProgressIndicator(color: Colors.white) : Text(
                            "Đăng ký",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      // LOGIN IF USER ALREADY HAVE ACCOUNT
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn đã có tài khoản?  ",
                              style: TextStyle(color: AppColor.grey),
                            ),
                            GestureDetector(
                              child: Text(
                                "Đăng nhập ngay",
                                style: TextStyle(
                                  color: AppColor.fgColor,
                                ),
                              ),
                              onTap: () {
                                // Write Tap Code Here.
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FUNCTION TO HANDLE USER SIGN UP
  void _signUp() async {
    // INDICATE SIGN UP PROCESS STARTED
    setState(() {
      isSigning = true;
    });

    // RETRIEVE USER INPUTS FOR USERNAME, EMAIL, AND PASSWORD
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // CHECK IF FIELDS ARE NOT EMPTY BEFORE SIGNING UP
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // ATTEMPT TO SIGN UP USER WITH EMAIL AND PASSWORD
        User? user = userCredential.user;

        // MARK SIGN UP PROCESS AS COMPLETED
        setState(() {
          isSigning = false;
        });

        // REDIRECT TO HOME SCREEN IF SIGN UP IS SUCCESSFUL
        if (user != null) {
          showToast(message: "Tạo tài khoản thành công");

          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'username': username,
          });
          Navigator.pushNamed(context, '/home');
        } else {
          // HANDLE FAILURE OR ERROR IN SIGN UP PROCESS
        }
      } catch (e) {
        // HANDLE EXCEPTIONS IF NECESSARY
      }
    } else {
      // SHOW ERROR MESSAGE IF FIELDS ARE EMPTY AND ABORT SIGN UP
      showToast(message: "Vui lòng điền đầy đủ thông tin.");
      setState(() {
        isSigning = false;
      });
    }
  }
}