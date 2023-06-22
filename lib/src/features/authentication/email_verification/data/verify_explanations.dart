class Explanation {
  final String title;
  final String content;

  const Explanation({required this.title, required this.content});
}

class VerifyExplanations {
  static const List<Explanation> explanations = [
    Explanation(
      title: "Keep the hackers at bay",
      content:
          "Email verification adds an extra shield to your account, keeping those pesky hackers scratching their heads and wondering what went wrong.",
    ),
    Explanation(
      title: "No room for impostors",
      content:
          "By verifying your email, we make sure our app is filled with real superheroes like you, and not sneaky villains in disguise!",
    ),
    Explanation(
      title: "Account hero recovery",
      content:
          "Forgot your password? No worries! With email verification, we'll help you regain access to your account faster than a speeding bullet.",
    ),
    Explanation(
      title: "Stay in the loop",
      content:
          "Get the latest scoop on app updates, exciting features, and secret surprises delivered right to your inbox. Don't miss out on the fun!",
    ),
    Explanation(
      title: "Tailored just for you",
      content:
          "By verifying your email, we can unlock a world of personalized experiences and recommendations tailored specifically to your superpowers and interests.",
    ),
    Explanation(
      title: "Play it safe, play it cool",
      content:
          "Email verification also helps us ensure that you have a secure and safe experience within the app. Think of it as your secret superhero handshake!",
    ),
  ];
}
