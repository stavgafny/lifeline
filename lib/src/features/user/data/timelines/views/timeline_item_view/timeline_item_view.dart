import 'package:flutter/material.dart';

class TimelineItemView extends StatelessWidget {
  const TimelineItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Divider(),
          Padding(
            padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Namasddsadasdsae",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(Icons.more_vert_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
