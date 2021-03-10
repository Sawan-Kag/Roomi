import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_auths/user_data/update.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../loginPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

// a simple sialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
            title: new Text("Error"),
            content: new Text(err),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
              )
            ],
          ));
  // return showDialog(
  //   context: context,
  //   // ignore: deprecated_member_use
  //   child: AlertDialog(
  //     title: Text("Error"),
  //     content: Text(err),
  //     actions: <Widget>[
  //       OutlineButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: Text("Ok"),
  //       ),
  //     ],
  //   ),
  // );
}

// many unhandled google error exist
// will push them soon

// ignore: missing_return
Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    //AuthResult result = await auth.signInWithCredential(credential);

    FirebaseUser user = await auth.currentUser();
    print(user.uid);

    return Future.value(true);
  }
}

// instead of returning true or false
// returning user to directly access UserID
Future<FirebaseUser> signin(
    String email, String password, BuildContext context) async {
  try {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    // return Future.value(true);
    return Future.value(user);
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_WRONG_PASSWORD':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_NOT_FOUND':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        showErrDialog(context, e.code);
        break;
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the valur returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

// change to Future<FirebaseUser> for returning a user
Future<FirebaseUser> signUp(String email, String password, String userNmae,
    BuildContext context) async {
  try {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = userNmae;
    user.updateProfile(updateInfo);
    user.reload();
    Firestore.instance.collection('users').document(user.uid).setData(
        {'userid': user.uid, 'displayName': userNmae, 'emailId': email});

    return Future.value(user);
    // return Future.value(true);
  } catch (error) {
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showErrDialog(context, "Email Already Exists");
        break;
      case 'ERROR_INVALID_EMAIL':
        showErrDialog(context, "Invalid Email Address");
        break;
      case 'ERROR_WEAK_PASSWORD':
        showErrDialog(context, "Please Choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}

signOutUser() async {
  /*FirebaseUser user = await auth.currentUser();
  print(user.providerData[1].providerId);
  if (user.providerData[1].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }*/
  await auth.signOut();
  //return Future.value(true);
}

Future sendPasswordResetEmail(String email) async {
  return auth.sendPasswordResetEmail(email: email);
}

deleteAccount() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  user.delete();
}
