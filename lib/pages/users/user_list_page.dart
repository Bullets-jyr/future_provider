import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_detail_page.dart';
import 'users_providers.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<List<User>>
    final userList = ref.watch(userListProvider);
    print(userList);
    // isLoading: 데이터를 다시 불러오는 액션에서는 항상 true
    // isRefreshing: ref.invalidate, ref.refresh를 이용해서 Provider를 강제로 dispose 시킨 후, 새로 데이터를 불러올 때 true
    // isReloading property에 대해서는 AsyncDetails 섹션에서 설명드립니다.
    print('isLoading: ${userList.isLoading}, isRefreshing: ${userList.isRefreshing}, isReloading: ${userList.isReloading}');
    print('hasValue: ${userList.hasValue}, hasError: ${userList.hasError}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(userListProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      // Object 패턴매칭을 할 때는, named field를 사용해야만 합니다.
      // body: switch (userList) {
      // AsyncData의 value argument를 users final 변수에 매칭시키겠습니다.
      //   AsyncData(value: final users) => ListView.separated(
      //       itemCount: users.length,
      //       separatorBuilder: (BuildContext context, int index) {
      //         return const Divider();
      //       },
      //       itemBuilder: (BuildContext context, int index) {
      //         final user = users[index];

      //         return ListTile(
      //           leading: CircleAvatar(
      //             child: Text(user.id.toString()),
      //           ),
      //           title: Text(user.name),
      //         );
      //       },
      //     ),
      //   AsyncError(error: final e) => Center(
      //       child: Text(
      //         e.toString(),
      //         style: const TextStyle(
      //           fontSize: 20,
      //           color: Colors.red,
      //         ),
      //       ),
      //     ),
      //// switch expression에서는 와일드카드 패턴으 _(언더스코어)를 제공하고 있습니다.
      //// 이 _(언더스코어) switch statement의 default와 유사합니다.
      //   _ => const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      // },
      body: userList.when(
        // Provider가 refresh되었을 때, loading callback을 호출할지 말지를 결정합니다.
        // default값은 true 즉, Provider가 refresh되었을 때는 loading callback을 호출하지 않습니다.
        skipLoadingOnRefresh: false,
        data: (users) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(userListProvider),
            color: Colors.red,
            child: ListView.separated(
              // ListView의 Children이 화면 내에 못 있어도 항상 over scroll이 가능해지기 때문입니다.
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return UserDetailPage(userId: user.id);
                        },
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.id.toString()),
                    ),
                    title: Text(user.name),
                  ),
                );
              },
            ),
          );
        },
        // StackTrace: 에러 상세
        error: (e, st) {
          return Center(
            child: Text(
              e.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}