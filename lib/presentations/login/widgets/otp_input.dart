import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:temaribet/blocs/auth/auth_bloc.dart';
import 'package:temaribet/blocs/auth/auth_event.dart';

class OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 48, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            PinEntryTextField(
                fields: 6,
                onSubmit: (String pin) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(VerifyOtpEvent(otp: pin));
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(AppStartEvent());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[900],
                      borderRadius: BorderRadius.circular(14)),
                  height: 40,
                  width: 100,
                  child: Center(
                    child: Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      constraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }
}