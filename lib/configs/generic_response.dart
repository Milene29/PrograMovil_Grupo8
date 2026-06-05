class GenericResponse<T> {
  final bool success;
  final T? data;
  final String message;
  final String? error;

  GenericResponse({
    required this.success,
    this.data,
    this.message = '',
    this.error,
  });

  factory GenericResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic)? fromJsonT,
  }) {
    return GenericResponse<T>(
      success: json['success'] as bool? ?? false,
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      message: json['message'] as String? ?? '',
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson({Object? Function(T)? toJsonT}) {
    return {
      'success': success,
      'data': toJsonT != null && data != null ? toJsonT(data as T) : data,
      'message': message,
      'error': error,
    };
  }

  @override
  String toString() {
    return 'GenericResponse{success: $success, data: $data, message: "$message", error: $error}';
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasData => data != null;

  GenericResponse<T> copyWith({
    bool? success,
    T? data,
    String? message,
    String? error,
  }) {
    return GenericResponse<T>(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
