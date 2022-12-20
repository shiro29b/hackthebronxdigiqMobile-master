// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:digiq/Constants/round_button.dart';
import 'package:digiq/Screens/all_queues.dart';
import 'package:digiq/Screens/login_sreen.dart';
import 'package:digiq/Screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Is Signup working properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: const SignUpScreen()));
    expect(find.text('Log In'),findsNothing);
    await tester.tap(find.text('Sign Up'));
    await tester.pump();
    await tester.pumpWidget(MaterialApp(home: const LoginScreen()));
    expect((find.text('Login')),findsOneWidget);
  });
  testWidgets('Is Login working properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: const LoginScreen()));
    expect(find.text('Login'),findsNothing);
    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pumpWidget(MaterialApp(home: const MainMenu()));
    expect((find.text('All queues')),findsOneWidget);
  });
}
