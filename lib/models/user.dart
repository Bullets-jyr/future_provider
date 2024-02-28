// import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  // freezed 클래스에 메소드나, getter나 setter를 만드려면, unnamed private constructor를 만들어야합니다.
  const User._();

  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required String phone,
    required String website,
  }) = _User;

  // 다시 override하려면 어떻게 해야할까요?
  @override
  String toString() => 'User(id: $id)';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// User Model에 가서 toString메서드를 override하겠습니다.
// freezed를 이용해 data class를 만들었기 때문에 toString이 이미 override되었습니다.
// 다시 override하려면 어떻게 해야할까요?
// 그런데 freezed 클래스에 메소드나, getter나 setter를 만드려면, unnamed private constructor를 만들어야한다는 걸 기억하시죠?
// User._를 만들겠습니다.
// 다음으로 toString메서드를 override하는데 User Model에 전체 Property 중 id Property만으로 이루어진 String을 리턴하겠습니다.
// 이렇게 하면 foundation package가 unused import라고 표시됩니다. 원래 foundeation pakage를 import한 이유는
// object를 flutter devtool에서 보기 좋게 표시해주는 class를 사용하기 위함인데 custom method를 만들면 freezed에서 이 기능을
// 사용 못하게 되는거 같습니다. foundation import를 comment처리하겠습니다.