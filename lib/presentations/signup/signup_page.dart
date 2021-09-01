import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:temaribet/blocs/auth/auth_bloc.dart';
import 'package:temaribet/blocs/auth/auth_event.dart';
import 'package:temaribet/blocs/auth/auth_states.dart';
import 'package:temaribet/core/firebase_services.dart';
import 'package:temaribet/presentations/homepage/pages/homepage.dart';
import 'package:temaribet/presentations/login/widgets/loading_indicator.dart';
import 'package:temaribet/presentations/login/widgets/login_otp_input.dart';
import 'package:temaribet/service_locator.dart';
import 'package:temaribet/utils/utils.dart';

class SignupPage extends StatefulWidget {
  static const String signUpPageRouteName = 'signup_page_route_name';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ET';
  PhoneNumber number = PhoneNumber(isoCode: 'ET');
  String inputNumber;
  bool isInputValid = false;
  String selectedRole = 'student';
  AuthBloc authBloc = sl<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
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

  Widget _getViewAsPerState(BuildContext context, AuthState state) {
    if (state is LoginInitial) {
      return _buildLoginForm(context);
    } else if (state is OtpSentState || state is OtpExceptionState) {
      return LoginOtpInput();
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
        _buildSelector(),
        _buildProccedButton(),
      ],
    );
  }

  Widget _buildSelector() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Text('Register as '),
            SizedBox(width: 30,),
            DropdownButton(
              value: selectedRole,
              items: [
                DropdownMenuItem(child: Text('Student'), value: 'student',),
                DropdownMenuItem(child: Text('Parent'), value: 'parent',),
              ],
              onChanged: (val) {
                authBloc.selectedRole = val;
                setState(() {
                  selectedRole = val;
                });
              },
            )
          ],
        ),
      ),
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
      padding: EdgeInsets.only(right: 20, bottom: 20, top: 10),
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
        onPressed: () async {
          if (isInputValid) {
            print('check is the user with the phone number is registered!');
            print('phone number $inputNumber');
            authBloc.add(SignUpUserEvent(phoneNo: inputNumber, role: selectedRole));
          }

          else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid phone!')));
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
            'Create Account',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}
