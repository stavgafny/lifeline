import 'package:flutter/material.dart';
import '../data/verify_explanations.dart';

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

  Widget _explanation(Explanation explanation) {
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
          itemBuilder: (context, index) {
            return _explanation(VerifyExplanations.explanations[index]);
          },
          itemCount: VerifyExplanations.explanations.length,
        ),
      ),
    );
  }
}
