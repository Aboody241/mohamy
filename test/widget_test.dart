import 'package:flutter_test/flutter_test.dart';
import 'package:mohamy/main.dart';

void main() {
  testWidgets('Home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const CaseManagerApp());

    expect(find.text('إدارة القضايا'), findsWidgets);
    expect(find.text('قضية عقد إيجار'), findsOneWidget);
  });
}
