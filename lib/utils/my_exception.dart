class MyException implements Exception {
  final String message;

  MyException(this.message);

  @override
  String toString() {
    return message;
  }
}
