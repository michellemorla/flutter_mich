
import 'package:flutter/material.dart';
import 'package:flutter_mich/configuration/configuration.dart';
import 'package:flutter_mich/controllers/issues_list_screen_controller.dart';
import 'package:flutter_mich/models/github_issues.dart';
import 'package:flutter_mich/translations/translations.dart';
import 'package:flutter_mich/utils/formatter.dart';
import 'package:flutter_mich/view/screens/github_issue_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GithubIssuesListScreen extends StatefulWidget {
  GithubIssuesListScreen ({Key key}) : super(key: key);

  @override
  GithubIssuesListState createState() => GithubIssuesListState();
}

class GithubIssuesListState extends State<GithubIssuesListScreen> {
  ///region variables
  bool _showLoading = true;
  bool _switchTheme = false;
  ///endregion

  ///region lifecycle
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gitIssuesNotifier = Provider.of<IssuesListScreenController>(context, listen: false);
      gitIssuesNotifier.getIssuesByState(GithubIssue.STATUS_ALL.toLowerCase());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  ///endregion

  ///region widgets
  @override
  Widget build(BuildContext context) {
    final gitIssuesNotifier = Provider.of<IssuesListScreenController>(context);
    _showLoading = gitIssuesNotifier.githubIssues.isEmpty;

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _switchTheme = (themeNotifier.getTheme() == appThemeDark);

    return WillPopScope(
      onWillPop: () async {
        return false; //block android's physical back button
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).trans('list_screen_title')),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: Dimens.marginGlobal2),
              child: InkWell(
                onTap: (){
                  setState(() {
                    _switchTheme = !_switchTheme;
                  });
                  _changeTheme(themeNotifier, _switchTheme);
                },
                child: Icon(_switchTheme ? AppIcons.dark : AppIcons.light),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.marginGlobal),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(Translations.of(context).trans('filter_state')),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceChip(
                          label: Text(
                              Formatter.capitalize(GithubIssue.STATUS_ALL.toLowerCase())
                          ),
                          selected: false,
                          onSelected: (val){
                            gitIssuesNotifier.getIssuesByState(GithubIssue.STATUS_ALL.toLowerCase());
                          },),
                        ChoiceChip(
                          label: Text(
                              Formatter.capitalize(GithubIssue.STATUS_OPEN.toLowerCase())
                          ),
                          selected: false,
                          onSelected: (val){
                            gitIssuesNotifier.getIssuesByState(GithubIssue.STATUS_OPEN.toLowerCase());
                          },),
                        ChoiceChip(
                          label: Text(
                              Formatter.capitalize(GithubIssue.STATUS_CLOSE.toLowerCase())
                          ),
                          selected: false,
                          onSelected: (val){
                            gitIssuesNotifier.getIssuesByState(GithubIssue.STATUS_CLOSE.toLowerCase());
                          },),
                      ],
                    )
                  ],
                ),
                SizedBox(height: Dimens.marginGlobal2,),
                Expanded(
                    child: _showLoading ?
                    Center(child: CircularProgressIndicator(),) :
                    Scrollbar(
                      child: RefreshIndicator(
                        onRefresh: () {
                          return gitIssuesNotifier.getIssuesByState(GithubIssue.STATUS_ALL.toLowerCase());
                        },
                        child: Consumer<IssuesListScreenController>(
                          builder: (context, git, child) => _buildList(git.githubIssues),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ), );
  }

  Widget _buildList(List<GithubIssue> issues){
    return ListView.builder(
        itemCount: issues.length,
        itemBuilder: (context, index){
          return _buildRowItem(context, issues[index]);
        });
  }

  Widget _buildRowItem(BuildContext context, GithubIssue issue){
    return ListTile(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context)=> GithubIssueDetailScreen(issue: issue,)));
      },
      leading: Icon(AppIcons.dot, color: issue.getColorByStatusKey(),),
      title: Text(issue.number.toString()),
      subtitle: Text(issue.title),
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