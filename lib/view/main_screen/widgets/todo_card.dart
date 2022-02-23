import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({
    Key? key,
    required this.isDone,
    required this.title,
    required this.description,
    required this.time,
  }) : super(key: key);

  final String title;
  final String description;
  final DateTime time;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      height: isDone ? 70 : 100,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        border: isDone == true ? null : Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
        color: isDone == true ? Colors.grey[300] : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.fiber_manual_record,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: Text(
                        title,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (isDone == false)
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: Text(
                      description,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                if (isDone == false)
                  const SizedBox(
                    height: 10,
                  ),
                Text(
                  DateFormat('yyyy-MM-dd kk:mm').format(time),
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            const Icon(
              Icons.fiber_manual_record_outlined,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
