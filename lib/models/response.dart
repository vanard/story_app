class BaseResponse {
  final bool error;
  final String message;

  BaseResponse({required this.error, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
