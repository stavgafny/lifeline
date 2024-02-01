import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/goal_tracker_controller.dart';

class FooterButtons extends StatelessWidget {
  static const _gap = SizedBox(width: 15.0);
  static const _iconsSize = 26.0;

  final GoalTrackerProvider provider;
  final void Function() onDelete;

  const FooterButtons({
    super.key,
    required this.provider,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _ResetProgressButton(provider),
        _gap,
        _DeleteButton(onDelete),
      ],
    );
  }
}

class _ResetProgressButton extends ConsumerWidget {
  final GoalTrackerProvider provider;

  const _ResetProgressButton(this.provider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(provider.select((model) => model.progress));
    final hasProgress = progress.current > Duration.zero;

    return GestureDetector(
      onTap: () => ref.read(provider.notifier).resetProgress(),
      child: Icon(
        Icons.restart_alt_rounded,
        size: FooterButtons._iconsSize,
        color: hasProgress
            ? Theme.of(context).iconTheme.color
            : Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final void Function() onDelete;

  const _DeleteButton(this.onDelete);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDelete,
      child: const Icon(
        Icons.delete_outline_rounded,
        size: FooterButtons._iconsSize,
      ),
    );
  }
}
