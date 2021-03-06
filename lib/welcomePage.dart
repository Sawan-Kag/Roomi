import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signUp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity/connectivity.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _value = 1;

  Widget _logInButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: containerOfLoginButton(),
    );
  }

  Container containerOfLoginButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: boxDecorationOfContainerOfLoginButton(),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
      ),
      /*child: DropdownButton(
        value: _value,
        items: [
          DropdownMenuItem(
            child: Text(
              "Log in",
              style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
            ),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text(
              "Log in as Landlord",
              style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
            ),
            value: 2,
            onTap: () {
              
            },
          ),
          DropdownMenuItem(
            child: Text(
              "Log in as Renter",
              style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
            ),
            value: 3,
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
      ),*/
    );
  }

  BoxDecoration boxDecorationOfContainerOfLoginButton() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xffdf8e33).withAlpha(100),
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2)
        ],
        color: Colors.white);
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: containerOfSignUpButton(),
    );
  }

  Container containerOfSignUpButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: boxDecorationOfContainerOfSignUpButton(),
      child: Text(
        'Register now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  BoxDecoration boxDecorationOfContainerOfSignUpButton() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      border: Border.all(color: Colors.white, width: 2),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: textSpanOfTitle(),
    );
  }

  TextSpan textSpanOfTitle() {
    return TextSpan(
        text: 'R',
        style: GoogleFonts.portLligatSans(
          // ignore: deprecated_member_use
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: 'oo',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'mi',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ]);
  }

  /* void checkStatusOfInternet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print('Connected');
        setState(() {
          isConnected = true;
        });
      } else {
        print('NOt Connected');
        setState(() {
          isConnected = false;
        });
      }
    });
  }*/

  /* Widget widgetForInternet() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child: Text(
          'Turn On Your Internet Connection and Try Again',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }*/

  /*@override
  void initState() {
    checkStatusOfInternet();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildSingleChildScrollViewOfScaffoldOfBuildWidget(context),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewOfScaffoldOfBuildWidget(
      BuildContext context) {
    return SingleChildScrollView(
      child: buildContainerOfSingleChildScrollViewOfBuildWidget(context),
    );
  }

  Container buildContainerOfSingleChildScrollViewOfBuildWidget(
      BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      decoration: buildBoxDecorationForContainerOfBuildWidget(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _title(),
          SizedBox(
            height: 80,
          ),
          _logInButton(),
          SizedBox(
            height: 20,
          ),
          _signUpButton(),
          SizedBox(
            height: 20,
          ),
          _label()
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecorationForContainerOfBuildWidget() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfffbb448), Color(0xffe46b10)]));
  }
}
