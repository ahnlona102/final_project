import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:IntelliHome/constants/app_colors.dart';
import 'package:IntelliHome/global/common/toast.dart';
// import 'package:IntelliHome/screen/Auth/Register/register_page.dart';
import 'package:IntelliHome/screen/Auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  // INITIALIZING TEXT EDITING CONTROLLERS FOR EMAIL AND PASSWORD FIELDS
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // INDICATE LOGIN STATUS
  bool isLogging = false;

  // CONTROL PASSWORD OBSCURITY
  bool isObscure = true;

  @override
  void dispose() {
    // DISPOSING TEXT EDITING CONTROLLERS TO FREE UP RESOURCES
    // _usernameController.dispose();
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 120),
                  child: Column(
                    children: [
                      Text(
                        'Đăng nhập ngay',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Vui lòng đăng nhập để sử dụng ứng dụng',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300
                        ),
                      ),

                      // INPUT EMAIL
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
                          controller: _emailController,
                          cursorColor: Color(0xffF5591F),
                          decoration: InputDecoration(
                            hintText: "Email",
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

                            // SHOW/HIDE PASSWORD
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
                        margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        onTap: _logIn,
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
                          child: isLogging
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                            "Đăng nhập",
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
                              "Bạn chưa có tài khoản?  ",
                              style: TextStyle(color: AppColor.grey),
                            ),
                            GestureDetector(
                              child: Text(
                                "Đăng ký ngay",
                                style: TextStyle(
                                  color: AppColor.fgColor,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
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

  // FUNCTION TO HANDLE USER LOGIN
  void _logIn() async {
    // INDICATE START OF LOGIN PROCESS
    setState(() {
      isLogging = true;
    });

    // RETRIEVE USER INPUTS FOR EMAIL AND PASSWORD
    String email = _emailController.text;
    String password = _passwordController.text;

    // CHECK IF FIELDS ARE NOT EMPTY BEFORE LOGGING IN
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // ATTEMPT USER LOGIN WITH PROVIDED EMAIL AND PASSWORD
        User? user = await _auth.signInWithEmailAndPassword(email, password);

        // MARK LOGIN PROCESS AS COMPLETED
        setState(() {
          isLogging = false;
        });

        // REDIRECT TO HOME SCREEN IF LOGIN IS SUCCESSFUL
        if (user != null) {
          showToast(message: "Đăng nhập thành công");
          // SAVE LOGIN STATE TO SHAREDPREFERENCES
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', true);
          // REDIRECT TO HOME SCREEN AFTER SUCCESSFUL LOGIN
          Navigator.pushNamed(context, '/home');
        } else {
          // HANDLE LOGIN FAILURE OR ERROR
          // For example:
          // showToast(message: "AN ERROR OCCURRED DURING LOGIN. PLEASE TRY AGAIN.");
        }
      } catch (e) {
        // HANDLE EXCEPTIONS IF NECESSARY
        // For example:
        // print("Exception during login: $e");
      }
    } else {
      // SHOW ERROR MESSAGE IF FIELDS ARE EMPTY AND ABORT LOGIN
      showToast(message: "Vui lòng điền đầy đủ thông tin.");
      setState(() {
        isLogging = false;
      });
    }
  }
}