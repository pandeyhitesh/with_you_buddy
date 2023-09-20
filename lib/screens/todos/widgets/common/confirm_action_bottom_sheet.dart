import 'package:flutter/material.dart';
import 'package:get/get.dart';

const confirmationOptions = ['Yes', 'No'];

Future<bool?> confirmActionSelection({
  required BuildContext context,
  String? message = 'Do you want to continue?',
}) async {
  final result = await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0, top: 3),
              child: Text(
                message!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: confirmationOptions
                  .map(
                    (e) => Flexible(
                      fit: FlexFit.tight,
                      child: GestureDetector(
                        onTap: () {
                          Get.back(result: e == 'Yes');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: e == 'Yes'
                                ? Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer
                                    .withOpacity(.5)
                                : Colors.white10,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Center(
                            child: Text(e),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    },
  );

  return result;
}
