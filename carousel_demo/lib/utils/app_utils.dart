/// Utility class
class AppUtils {
  /// Method help convert pattern to real url
  /// For example, pattern '/category/{qa_id}'
  /// values ['123']
  /// Real url will be '/category/123'
  static String mapURLPatternValue(String urlStr, {List values}) {
    var newUrl = urlStr;
    print('AppUtils:before map: $newUrl');
    if (values != null) {
      for (int i = 0; i < values.length; i++) {
        var firstLeftBrace = newUrl.indexOf('{');
        var firstRightBrace = newUrl.indexOf('}');
        newUrl = newUrl.replaceRange(
            firstLeftBrace, firstRightBrace + 1, values[i].toString());
      }
    }
    print('AppUtils:after map: $newUrl');
    return newUrl;
  }
}
