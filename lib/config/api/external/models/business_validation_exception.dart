class BusinessValidationException implements Exception {
  final String message;
  BusinessValidationException(this.message);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusinessValidationException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
