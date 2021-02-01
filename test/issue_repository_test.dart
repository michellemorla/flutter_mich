import 'package:flutter_mich/models/github_issues.dart';
import 'package:flutter_mich/repositories/interfaces/github_issues_repo_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGithubIssuesRepository extends Mock implements IGithubIssuesRepo{}

void main(){
  MockGithubIssuesRepository mockGithubIssuesRepository;

  setUp((){
    mockGithubIssuesRepository = MockGithubIssuesRepository();
  });

  test('When the function getIssuesByState is called it should return a list of issues', () async {
        when(mockGithubIssuesRepository.getIssuesByState('all')).thenAnswer((_) => Future.value(
            [
              GithubIssue(
                  id: 797128190,
                  url: 'https://api.github.com/repos/flutter/flutter/issues/75016',
                  number: 75016,
                  state: 'open',
                  title: "Move over all hosts in prod pool to use salt prod master",
                  body: "Many hosts in prod pool are still pointing to the salt dev master. Move them over to point to salt prod master."
              ),
              GithubIssue(
                  id: 797127277,
                  url: 'https://api.github.com/repos/flutter/flutter/issues/75015',
                  number: 75015,
                  state: 'open',
                  title: "Roll Plugins from cd358b07e7bc to 8c9ad1198a1e (3 revisions)",
                  body: "Many hosts in prod pool are still pointing to the salt dev master. Move them over to point to salt prod master."
              ),
              GithubIssue(
                  id: 797127279,
                  url: 'url',
                  number: 75014,
                  state: 'closed',
                  title: "a title",
                  body: "a body"
              )
            ]
        ));

        var issues = await mockGithubIssuesRepository.getIssuesByState('all');
        expect(issues.length, 3);
      }
  );

}