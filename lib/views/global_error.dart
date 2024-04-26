import 'package:dusty_flutter/main.dart';
import 'package:dusty_flutter/states/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalErrorView extends StatelessWidget {
  const GlobalErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 32,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text('Something went wrong. Please try again later.'),
            ElevatedButton(
                onPressed: () {
                  if (navigatorKey.currentState == null ||
                      navigatorKey.currentContext == null) return;
                  Provider.of<GameModel>(
                    navigatorKey.currentContext!,
                    listen: false,
                  ).restGame();
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                },
                child: const Text('OK')),
          ],
        ),
      ),
    );
  }
}
