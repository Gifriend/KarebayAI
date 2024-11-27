import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_screen_controller.g.dart';

@riverpod
class SplashScreenController extends _$SplashScreenController {
  @override
  Future<void> build() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
  }
}