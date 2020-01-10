# dart-github-sign-in
Sign In With GitHub

## Getting Started

Add package dependency

```yaml
github_sign_in: ^0.0.1
```

Perform `Sign In With GitHub`

```dart
final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: clientId,
        clientSecret: clientSecret,
        redirectUrl: redirectUrl);
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token)
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }
```
