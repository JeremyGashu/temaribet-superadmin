import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:temaribet/blocs/auth/auth_bloc.dart';
import 'package:temaribet/blocs/auth/auth_event.dart';
import 'package:temaribet/blocs/auth/auth_states.dart';
import 'package:temaribet/presentations/homepage/pages/homepage.dart';
import 'package:temaribet/presentations/login/widgets/loading_indicator.dart';
import 'package:temaribet/presentations/login/widgets/otp_input.dart';

import '../../../service_locator.dart';

class LoginPage extends StatefulWidget {
  static const String loginPageRouterName = 'login_page_route_name';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ET';
  PhoneNumber number = PhoneNumber(isoCode: 'ET');
  String inputNumber;
  bool isInputValid = false;

  LoginBloc loginBloc = sl<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) async {
        if (state is ExceptionState || state is OtpExceptionState) {
          String message;
          if (state is ExceptionState) {
            message = state.message;
          } else if (state is OtpExceptionState) {
            message = state.message;
          }
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
        } else if (state is LoginCompleteState) {
          // authBloc.add(LoggedIn(token: state.getUser().uid));
          // SharedPreferences sharedPreferences =
          //     await SharedPreferences.getInstance();
          // await sharedPreferences.setInt('homePage', 0);
          Navigator.pushReplacementNamed(context, HomePage.homepageRouteName);
          
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 60,
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  _buildInfoText(),
                  _getViewAsPerState(context, state),
                  Spacer(),
                  _builTermsAndConditionsText(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getViewAsPerState(BuildContext context, LoginState state) {
    if (state is LoginInitial) {
      return _buildLoginForm(context);
    } else if (state is OtpSentState || state is OtpExceptionState) {
      return OtpInput();
    } else if (state is LoadingState) {
      return LoadingIndicator();
    } else {
      return _buildLoginForm(context);
    }
  }

  Column _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        _buildPhoneInputField(),
        _buildHelpText(context),
        SizedBox(height: 20),
        _buildProccedButton(),
      ],
    );
  }

  Container _buildPhoneInputField() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 20, top: 20),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          inputNumber = number.phoneNumber;
        },
        onInputValidated: (bool value) {
          setState(() {
            isInputValid = value;
          });
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        initialValue: number,
        cursorColor: Colors.purple[900],
        textFieldController: controller,
        formatInput: false,
        spaceBetweenSelectorAndTextField: 4,
        inputBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.cyanAccent.shade700,
          width: 1,
        )),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ),
    );
  }

  Container _buildHelpText(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 20, bottom: 50, top: 10),
      child: Text(
        'Need Help?',
        style: TextStyle(
          fontSize: 16, color: Colors.purple[900],
          // color: Colors.cyanAccent.shade700,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }

  Container _buildProccedButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.purple[900],
      ),
      margin: EdgeInsets.fromLTRB(30, 10, 20, 0),
      height: 45,

      width: double.infinity,
      // padding: EdgeInsets.all(15),
      child: MaterialButton(
        onPressed: () {
          if (isInputValid) {
            loginBloc.add(SendOtpEvent(phoNo: inputNumber));
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_open, color: Colors.white),
            SizedBox(
              width: 5,
            ),
            Text(
              'Proceed Securely',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _builTermsAndConditionsText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'By proceeding you agree to our ',
            style: TextStyle(color: Colors.grey, fontSize: 12),
            children: <TextSpan>[
              TextSpan(
                text: 'Terms and conditions & Privacy policy.',
                style: TextStyle(color: Colors.purple[900], fontSize: 12),
              ),
              TextSpan(
                text: ' We will send you SMS shortly. ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ]),
      ),
    );
  }

  Container _buildInfoText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login or create an Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            'Pay with your preference later',
            style: TextStyle(
              color: Colors.purple[900],
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }


}
