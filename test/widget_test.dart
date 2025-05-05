import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studysphere/app/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudySphereApp());
    
    // Verifikasi bahwa aplikasi dimuat
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}