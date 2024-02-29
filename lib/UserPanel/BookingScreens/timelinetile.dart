import 'package:flutter/material.dart';
import 'package:luxurycars/UserPanel/BookingScreens/event_card_timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTile extends StatelessWidget {
  final bool isfirst;
  final bool isLast;
  final bool isPast;
  final child;

  MyTimeLineTile(
      {super.key,
      required this.isLast,
      required this.isPast,
      required this.child,
      required this.isfirst});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .16,
      child: TimelineTile(
        beforeLineStyle: LineStyle(
          color: isPast ? Colors.green : Color.fromARGB(255, 241, 241, 241),
        ),
        indicatorStyle: IndicatorStyle(
          color: isPast ? Colors.green : Color.fromARGB(255, 241, 241, 241),
        ),
        isLast: isLast,
        isFirst: isfirst,
        endChild: EventCard(child: child, isPast: isPast),
      ),
    );
  }
}
