
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mich/configuration/app_colors.dart';
import 'package:flutter_mich/configuration/configuration.dart';
import 'package:flutter_mich/translations/translations.dart';
import 'package:flutter_mich/view/screens/github_issues_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  ///region variables
  bool _switchTheme = false;
  ///endregion

  ///region lifecycle
  ///endregion

  ///region widgets
  @override
  Widget build(BuildContext context) {
    _switchTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Builder(
        builder: (BuildContext context){
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Dimens.marginGlobal2),
              child: Center(
                child: Column(
                  children: [
                    Spacer(),
                    MediaQuery.of(context).orientation == Orientation.portrait ?
                    Image(
                      width: MediaQuery.of(context).size.width / 2.5,
                      color: _switchTheme ? AppColors.lightBackground :
                      Theme.of(context).primaryColor,
                      image: Image.asset(
                          "assets/images/git_logo.png"
                      ).image,
                    ) : Wrap(),
                    Spacer(),
                    ElevatedButton(
                      key: Key('enter_btn'),
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) =>
                                  GithubIssuesListScreen()), (route) => false);
                        },
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(Dimens.marginGlobal),
                          child: Text(
                            Translations.of(context).trans('welcome'),
                            style: Theme.of(context).textTheme.headline4.
                            copyWith(color: AppColors.lightBackground),
                          ),
                        )),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Dark mode'),
                        SizedBox(width: Dimens.marginGlobal2,),
                        CupertinoSwitch(
                            activeColor: Theme.of(context).accentColor,
                            value: _switchTheme,
                            onChanged: (bool val){
                              final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
                              setState(() {
                                _switchTheme = val;
                              });
                              _changeTheme(themeNotifier, val);
                            })
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
///endregion

///region methods
  _changeTheme(ThemeNotifier themeNotifier, bool isOn) async {
    (isOn) ? themeNotifier.setTheme(appThemeDark) : themeNotifier.setTheme(appTheme);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(Preferences.pref_theme, isOn);
  }
///endregion


}