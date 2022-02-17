import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({
    Key? key,
    required this.isDone,
  }) : super(key: key);

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      height: isDone? 70 : 100,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        border:  isDone == true?null : Border.all(color: Colors.green),
        borderRadius:BorderRadius.circular(8),
        color: isDone == true? Colors.grey[300] : null,
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
                      child: const Text(
                        'Here will be the todo title more more more more more more',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
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
                if(isDone == false)
                SizedBox(
                  width: screenWidth * 0.75,
                  child: const Text(
                    'Here a user can see his/her task todo, it will be max two lines and other line will be opted',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if(isDone == false)
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '10:49 AM Feb 17,2022',
                  style: TextStyle(
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