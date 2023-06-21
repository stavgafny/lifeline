import 'package:flutter/material.dart';

class VerifyExplanationDialog extends StatelessWidget {
  static const _contentPadding = 8.0;
  static const _explanationGap = 40.0;
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const VerifyExplanationDialog._(),
    );
  }

  const VerifyExplanationDialog._();

  AppBar _appBar(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Why Verify?",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                height: 0,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _explanation(_Explanation explanation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          explanation.title,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(_contentPadding, 0, 0, 0),
          child: Text(explanation.content),
        ),
        const SizedBox(height: _explanationGap),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: _appBar(context),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (context, index) => _explanation(_explanations[index]),
          itemCount: _explanations.length,
        ),
      ),
    );
  }
}

class _Explanation {
  final String title;
  final String content;
  const _Explanation({required this.title, required this.content});
}

const List<_Explanation> _explanations = [
  _Explanation(
    title: "Keep the hackers at bay",
    content:
        "Email verification adds an extra shield to your account, keeping those pesky hackers scratching their heads and wondering what went wrong.",
  ),
  _Explanation(
    title: "No room for impostors",
    content:
        "By verifying your email, we make sure our app is filled with real superheroes like you, and not sneaky villains in disguise!",
  ),
  _Explanation(
    title: "Account hero recovery",
    content:
        "Forgot your password? No worries! With email verification, we'll help you regain access to your account faster than a speeding bullet.",
  ),
  _Explanation(
    title: "Stay in the loop",
    content:
        "Get the latest scoop on app updates, exciting features, and secret surprises delivered right to your inbox. Don't miss out on the fun!",
  ),
  _Explanation(
    title: "Tailored just for you",
    content:
        "By verifying your email, we can unlock a world of personalized experiences and recommendations tailored specifically to your superpowers and interests.",
  ),
  _Explanation(
    title: "Play it safe, play it cool",
    content:
        "Email verification also helps us ensure that you have a secure and safe experience within the app. Think of it as your secret superhero handshake!",
  ),
];
