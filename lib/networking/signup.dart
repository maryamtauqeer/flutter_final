// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_final/networking/auth_service.dart';
// import 'package:flutter_final/networking/constants.dart';
// import 'package:flutter_final/networking/dashboard.dart';
// import 'package:flutter_final/networking/login.dart';
// import 'package:flutter_final/networking/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class SignUpScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isPasswordVisible = ref.watch(isPasswordVisibleProvider);
//     final TextEditingController _emailController =
//         ref.read(emailControllerProvider);
//     final TextEditingController _passwordController =
//         ref.read(passwordControllerProvider);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               stops: [0.1, 1.0],
//               colors: CustomColors.backgroundColor,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(5, 100, 0, 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RotatedBox(
//                       quarterTurns: 3,
//                       child: Container(
//                         margin: EdgeInsets.only(
//                           right: 2,
//                         ),
//                         child: Text(
//                           'Sign up',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 45,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'A world of',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 27,
//                           ),
//                         ),
//                         Text(
//                           'possibility in an',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 27,
//                           ),
//                         ),
//                         Text(
//                           'app',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 27,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: _buildInputField(
//                     'Email',
//                     _emailController,
//                     isPasswordVisible,
//                     ref,
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: _buildInputField(
//                     'Password',
//                     _passwordController,
//                     isPasswordVisible,
//                     ref,
//                     isPassword: true,
//                   ),
//                 ),
//                 Spacer(),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 50, bottom: 80),
//                     child: _buildSignUpButton(
//                       context,
//                       _emailController,
//                       _passwordController,
//                       ref,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSignUpButton(
//     BuildContext context,
//     TextEditingController emailController,
//     TextEditingController passwordController,
//     WidgetRef ref,
//   ) {
//     return ElevatedButton(
//       onPressed: () async {
//         String email = emailController.text.trim();
//         String password = passwordController.text;

//         // Validate email using your custom method
//         if (!email.isValidEmail()) {
//           showToast('Invalid email format');
//           return;
//         }

//         User? user =
//             await ref.read(authServiceProvider).signUpWithEmailAndPassword(
//                   emailController.text,
//                   passwordController.text,
//                 );

//         if (user != null) {
//           // Successfully signed up, update the authentication state
//           ref.read(authProvider.notifier).state = user;

//           // Navigate to the DashboardScreen
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => LoginScreen(),
//             ),
//           );
//         } else {
//           showToast('Failed to sign up');
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         primary: Colors.transparent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         padding: EdgeInsets.zero,
//       ).copyWith(
//         overlayColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.pressed)) {
//               return Colors.transparent;
//             }
//             return null;
//           },
//         ),
//       ),
//       child: Ink(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: CustomColors.buttonShadowColor,
//           ),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Container(
//           width: 120,
//           height: 60,
//           constraints: BoxConstraints(minHeight: 40, minWidth: 180),
//           alignment: Alignment.center,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'SIGN UP',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//               SizedBox(width: 4),
//               Icon(Icons.arrow_forward, color: Colors.white),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField(
//     String label,
//     TextEditingController controller,
//     bool isPasswordVisible,
//     WidgetRef ref, {
//     bool isPassword = false,
//   }) {
//     return Container(
//       width: double.infinity,
//       child: TextFormField(
//         controller: controller,
//         obscureText: isPassword && !isPasswordVisible,
//         validator: (value) {
//           if (label == 'Email' && !value!.isValidEmail()) {
//             return 'Invalid email entered!';
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: Colors.black),
//           contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           suffixIcon: isPassword
//               ? IconButton(
//                   icon: Icon(
//                     isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                     color: Color.fromARGB(255, 62, 61, 61),
//                   ),
//                   onPressed: () {
//                     ref.read(isPasswordVisibleProvider.notifier).state =
//                         !ref.read(isPasswordVisibleProvider.notifier).state;
//                   },
//                 )
//               : Icon(Icons.email, color: Color.fromARGB(255, 62, 61, 61)),
//         ),
//       ),
//     );
//   }
// }

// void showToast(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: Colors.red,
//     textColor: Colors.white,
//   );
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/networking/auth_service.dart';
import 'package:flutter_final/networking/constants.dart';
import 'package:flutter_final/networking/dashboard.dart';
import 'package:flutter_final/networking/login.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(isPasswordVisibleProvider);
    final TextEditingController _emailController =
        ref.read(emailControllerProvider);
    final TextEditingController _passwordController =
        ref.read(passwordControllerProvider);
    final TextEditingController _confirmPasswordController =
        ref.read(confirmPasswordControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 1.0],
              colors: CustomColors.backgroundColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 100, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: 2,
                        ),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A world of',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                          ),
                        ),
                        Text(
                          'possibility in an',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                          ),
                        ),
                        Text(
                          'app',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildInputField(
                    'Email',
                    _emailController,
                    isPasswordVisible,
                    ref,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildInputField(
                    'Password',
                    _passwordController,
                    isPasswordVisible,
                    ref,
                    isPassword: true,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildInputField(
                    'Confirm Password',
                    _confirmPasswordController,
                    isPasswordVisible,
                    ref,
                    isPassword: true,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50, bottom: 80),
                    child: Column(
                      children: [
                        _buildSignUpButton(
                          context,
                          _emailController,
                          _passwordController,
                          _confirmPasswordController,
                          ref,
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Already signed up? Login',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    WidgetRef ref,
  ) {
    return ElevatedButton(
      onPressed: () async {
        String email = emailController.text.trim();
        String password = passwordController.text;

        // Validate email using your custom method
        if (!email.isValidEmail()) {
          showToast('Invalid email format');
          return;
        }

        // Validate confirm password
        if (password != confirmPasswordController.text) {
          showToast('Passwords do not match');
          return;
        }

        User? user =
            await ref.read(authServiceProvider).signUpWithEmailAndPassword(
                  emailController.text,
                  passwordController.text,
                );

        if (user != null) {
          // Successfully signed up, update the authentication state
          ref.read(authProvider.notifier).state = user;

          // Navigate to the DashboardScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else {
          showToast('Failed to sign up');
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.zero,
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          },
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: CustomColors.buttonShadowColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 120,
          height: 60,
          constraints: BoxConstraints(minHeight: 40, minWidth: 180),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SIGN UP',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    bool isPasswordVisible,
    WidgetRef ref, {
    bool isPassword = false,
  }) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        validator: (value) {
          if (label == 'Email' && !value!.isValidEmail()) {
            return 'Invalid email entered!';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromARGB(255, 62, 61, 61),
                  ),
                  onPressed: () {
                    ref.read(isPasswordVisibleProvider.notifier).state =
                        !ref.read(isPasswordVisibleProvider.notifier).state;
                  },
                )
              : Icon(Icons.email, color: Color.fromARGB(255, 62, 61, 61)),
        ),
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
