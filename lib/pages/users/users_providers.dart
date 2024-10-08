// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/user.dart';
import '../../providers/dio_provider.dart';

part 'users_providers.g.dart';

// final userListProvider = FutureProvider<List<User>>((ref) async { // error
// final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   ref.onDispose(() {
//     print('[userListProvider] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users');
//   // throw 'Fail to fetch user list';
//   final List userList = response.data;
//   // collection for-loop
//   final users = [for (final user in userList) User.fromJson(user)];
//   return users;
// });

@riverpod
FutureOr<List<User>> userList(UserListRef ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  // error 발생
  // throw 'Fail to fetch user list';
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
}

// 개별 유저 정보
// final userDetailProvider =
//     FutureProvider.autoDispose.family<User, int>((ref, id) async {
//   ref.onDispose(() {
//     print('[userDetailProvider($id)] disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final user = User.fromJson(response.data);
//   return user;
// });

@riverpod
FutureOr<User> userDetail(UserDetailRef ref, int id) async {
  ref.onDispose(() {
    print('[userDetailProvider($id)] disposed');
  });
  // http 호출
  final response = await ref.watch(dioProvider).get('/users/$id');
  // Provider가 autoDispose Provider일 때만 사용 가능합니다.
  // http 호출이 끝나면 ref.keepAlive(); 호출합니다. (주의)
  // 그전에 호출하면 원하는 동작을 하지 않습니다.
  // KeepAliveLink keepAlive();
  // close(): Provider의 모든 listener가 제거되었을 때,
  // Provider가 자기 자신을 dispose할 수 있습니다.
  ref.keepAlive();
  final user = User.fromJson(response.data);
  return user;
}

// @Riverpod(keepAlive: true)
@Riverpod(keepAlive: false)
Future<int> returnOne(ReturnOneRef ref) {
  ref.keepAlive();
  return Future.value(1);
}