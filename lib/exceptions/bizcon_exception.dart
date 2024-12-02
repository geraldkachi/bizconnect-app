// ignore_for_file: public_member_api_docs, sort_constructors_first
class BizException implements Exception {
  final String? message;
  BizException({
    this.message,
  });

  @override
  String toString() => 'BizException(message: $message)';
}
