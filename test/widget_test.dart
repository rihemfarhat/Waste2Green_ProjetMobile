import 'package:flutter_test/flutter_test.dart';
import 'package:paymenet/main.dart';  // Import your main.dart

void main() {
  testWidgets('ProfilePage navigates to PaymentPage when tapping on Payment Details', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Waste2GreenApp());  // Use Waste2GreenApp as the entry point

    // Verify ProfilePage is loaded.
    expect(find.text('Profile Page'), findsOneWidget);  // Adjust according to actual content

    // Tap the 'Payment Details' ListTile.
    await tester.tap(find.text('Payment Details'));
    await tester.pumpAndSettle();  // Wait for the navigation to settle

    // Verify that PaymentPage is displayed after navigation.
    expect(find.text('Payment Page'), findsOneWidget);  // Adjust according to actual content
  });

  testWidgets('PaymentPage shows the correct content', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Waste2GreenApp());  // Use Waste2GreenApp as the entry point

    // Tap the 'Payment Details' ListTile to navigate to PaymentPage.
    await tester.tap(find.text('Payment Details'));
    await tester.pumpAndSettle(); // Wait for navigation to finish

    // Verify that the PaymentPage shows the correct content (for example, a payment form).
    expect(find.text('Payment Form and Details'), findsOneWidget);  // Adjust based on actual content
  });
}
