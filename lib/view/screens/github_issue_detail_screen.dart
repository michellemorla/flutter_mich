
import 'package:flutter/material.dart';
import 'package:flutter_mich/configuration/configuration.dart';
import 'package:flutter_mich/models/github_issues.dart';
import 'package:flutter_mich/translations/translations.dart';
import 'package:flutter_mich/utils/formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubIssueDetailScreen extends StatelessWidget {
  final GithubIssue issue;

  GithubIssueDetailScreen({Key key, this.issue}) : super(key: key);

  ///region widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).trans('detail_screen_title')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.marginGlobal2,
              horizontal: Dimens.marginGlobal),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Icon(AppIcons.bug,
                            size: Dimens.xlIcon,
                            color: issue.getColorByStatusKey(),),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(Dimens.marginGlobal),
                            child: Text(
                              Formatter.capitalize(issue.title),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,),
                          ),
                        ),
                        SizedBox(height: Dimens.marginGlobal2,),
                        _builtTextRow(context,
                            Translations.of(context).trans('issue_number'),
                            issue.number?.toString() ?? ""),
                        _builtTextRow(context,
                            Translations.of(context).trans('issue_author'),
                            issue.author?.login ?? ""),
                        issue.dateCreated != null ? _builtTextRow(context,
                            Translations.of(context).trans('issue_date_created'),
                            Formatter.dateToString(issue.dateCreated)) : Wrap(),
                        issue.state.toUpperCase() == GithubIssue.STATUS_CLOSE &&
                            issue.dateCreated != null ?
                        _builtTextRow(context,
                            Translations.of(context).trans('issue_date_closed'),
                            Formatter.dateToString(issue.dateClosed)) : Wrap(),
                        SizedBox(height: Dimens.marginGlobal2,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimens.marginGlobal),
                          child: Text(Translations.of(context).trans('issue_description'),
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold, fontSize: Dimens.fontSize18),),
                        ),
                        Text(issue.body ?? issue.description ?? "")
                      ],
                    ),
                  )),
              issue.httpUrl != null ? Center(
                child: RaisedButton(
                  onPressed: () async {
                    _launchURL(issue.httpUrl);
                  },
                  child: Text(
                      Translations.of(context).trans('issue_url')
                  ),
                ),
              ) : Wrap()
            ],
          ),
        ),
      ),
    );
  }

  Widget _builtTextRow(BuildContext context, String title, String content){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.marginMinGlobal),
      child: Row(
        children: [
          Text(title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
          Expanded(child: Text(content))
        ],
      ),
    );
  }
  ///endregion
  ///region functions
  _launchURL(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    } else {
      debugPrint('could not launch url');
    }
  }
///endregion
}