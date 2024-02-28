import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../users/users_providers.dart';

class FamilyDisposePage extends ConsumerWidget {
  const FamilyDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userDetailProvider(1));
    ref.watch(userDetailProvider(2));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Dispose'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          shrinkWrap: true,
          children: [
            OutlinedButton(
              onPressed: () {
                // 둘 다 가능
                // ref.invalidate(userDetailProvider);
                ref.invalidate(userDetailProvider(1));
              },
              child: Text(
                'invalidate',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // error
                // ref.refresh(userDetailProvider);
                // 1가지만 가능
                return ref.refresh(userDetailProvider(1));
              },
              child: Text(
                'refresh',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}