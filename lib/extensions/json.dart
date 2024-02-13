import 'dart:convert';
import 'dart:typed_data';

extension JsonStringExtension on String {
  ByteBuffer toByteBuffer() {
    return utf8.encode(this).buffer;
  }
}

extension JsonUint8ListExtension on ByteBuffer {
  Map<String, dynamic> toJson() {
    final uint8List = Uint8List.view(this);
    final decoded = const Utf8Decoder().convert(uint8List);
    return jsonDecode(decoded);
  }
}
