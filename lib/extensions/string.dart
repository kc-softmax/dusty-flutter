extension StringExtenson on String {
  String toSnakeCase() {
    final sb = StringBuffer();
    var first = true;
    for (var rune in runes) {
      var char = String.fromCharCode(rune);
      if (char == char.toUpperCase() && !first) {
        if (char != '_') {
          sb.write('_');
        }
        sb.write(char.toLowerCase());
      } else {
        first = false;
        sb.write(char.toLowerCase());
      }
    }
    return sb.toString();
  }
}
