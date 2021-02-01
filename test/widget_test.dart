// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mich/controllers/issues_list_screen_controller.dart';
import 'package:flutter_mich/models/github_issues.dart';
import 'package:flutter_mich/translations/translations_delegate.dart';
import 'package:flutter_mich/view/screens/github_issue_detail_screen.dart';
import 'package:flutter_mich/view/screens/github_issues_list_screen.dart';
import 'package:flutter_mich/view/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver{}

void main() {
  testWidgets('Test to check if login has a welcome button', (WidgetTester tester) async{

    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            const TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales){
            if(locale != null){
              for (Locale supported in supportedLocales){
                if(supported.languageCode == locale.languageCode)
                  return locale;
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: [
            const Locale('en'),
            const Locale('es')
          ],
          home: LoginScreen(),
          navigatorObservers: [mockObserver],
        ));
    await tester.pumpAndSettle();

    final welcomeBtnFinder = find.byKey(Key('enter_btn'));
    expect(welcomeBtnFinder, findsOneWidget);
  });

  testWidgets('Test view detail page', (WidgetTester tester) async{
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            const TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales){
            if(locale != null){
              for (Locale supported in supportedLocales){
                if(supported.languageCode == locale.languageCode)
                  return locale;
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: [
            const Locale('en'),
            const Locale('es')
          ],
          home: GithubIssueDetailScreen(issue: GithubIssue(
              id: 797128190,
              url: 'https://api.github.com/repos/flutter/flutter/issues/75016',
              number: 75016,
              state: 'open',
              title: "Move over all hosts in prod pool to use salt prod master",
              body: "Many hosts in prod pool are still pointing to the salt dev master. Move them over to point to salt prod master."
          ),),
          navigatorObservers: [mockObserver],
        )
    );
    await tester.pumpAndSettle();
    expect(find.byType(Icon), findsOneWidget);
  });

}
