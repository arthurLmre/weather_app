import 'package:flutter/material.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';

class ActivitySelector extends StatelessWidget {
  const ActivitySelector({
    required this.selectedActivity,
    required this.onActivitySelected,
    super.key,
  });

  final ActivityEnum selectedActivity;
  final ValueChanged<ActivityEnum> onActivitySelected;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ActivityEnum>(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 13)),
      ),
      segments: const [
        ButtonSegment(
          value: ActivityEnum.walking,
          icon: Icon(Icons.directions_walk_outlined, size: 18),
          label: Text('Balade'),
        ),
        ButtonSegment(
          value: ActivityEnum.running,
          icon: Icon(Icons.directions_run_outlined, size: 18),
          label: Text('Course'),
        ),
        ButtonSegment(
          value: ActivityEnum.picnic,
          icon: Icon(Icons.park_outlined, size: 18),
          label: Text('Pique-nique'),
        ),
      ],
      selected: {selectedActivity},
      showSelectedIcon: false,
      onSelectionChanged: (selection) {
        onActivitySelected(selection.first);
      },
    );
  }
}
