import 'package:flutter/material.dart';

class InternetExceptionWidgit extends StatelessWidget {
  final VoidCallback onPressed;
  const InternetExceptionWidgit({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .15,
        ),
        const Icon(
          Icons.cloud_off,
          color: Colors.red,
          size: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Text(
              'We`re unable to show results.\nPlease checkyour data\connection',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .15,
        ),
        ElevatedButton(
            onPressed: onPressed,
            child: Center(
              child: Text(
                'RETERY',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ))
      ],
    );
  }
}
