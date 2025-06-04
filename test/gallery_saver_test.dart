import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('gallery_saver');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'saveImage':
          return '';
        case 'saveVideo':
          return 'error';
      }
      return 'unknown method';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('save image', () async {
    expect(await GallerySaver.saveImage('/storage/emulated/image.jpg'), '');
  });

  test('save video', () async {
    expect(await GallerySaver.saveVideo('/storage/emulated/video.mov'), 'error');
  });
}
