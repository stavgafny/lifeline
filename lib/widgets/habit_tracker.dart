import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../controllers/habit_trackers_controller.dart';

class HabitTracker extends StatelessWidget {
  final String name;
  final Tracker tracker;

  const HabitTracker({
    required this.name,
    required this.tracker,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void playTap() {
      tracker.togglePlaying();
    }

    void settingsTap() {}

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: playTap,
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: Stack(
                      children: [
                        Obx(
                          () => CircularPercentIndicator(
                            radius: 25.0,
                            lineWidth: 4,
                            backgroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            progressColor:
                                Theme.of(context).colorScheme.primary,
                            percent: tracker.toIndicator,
                          ),
                        ),
                        Obx(
                          () => Center(
                            child: Icon(
                              tracker.playing.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Obx(
                          () => Text(
                            tracker.precentFormat,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Obx(
                      () => Text(
                        tracker.toString(),
                        //duration.difference(progress).inSeconds.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTap,
              child: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
