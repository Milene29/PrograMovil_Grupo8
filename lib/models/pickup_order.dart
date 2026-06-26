class PickupOrder {
  final int? id; // ID de la BD
  final String orderNumber; // Número generado
  final String status; // Estado: pendiente, preparando, listo, recogido, cancelado
  final double total;
  final int remainingMinutes;
  final List<Map<String, dynamic>> items;
  final DateTime? createdAt;

  PickupOrder({
    this.id,
    required this.orderNumber,
    required this.status,
    required this.total,
    required this.remainingMinutes,
    required this.items,
    this.createdAt,
  });

  /// Crear desde JSON del backend
  factory PickupOrder.fromJson(Map<String, dynamic> json) {
    return PickupOrder(
      id: json['id'] as int?,
      orderNumber: json['order_number'] as String? ?? (json['id']?.toString() ?? ''),
      status: json['status'] as String? ?? 'pendiente',
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      remainingMinutes: 5,
      items: (json['items'] as List?)
          ?.map((item) => item as Map<String, dynamic>)
          .toList() ?? [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  /// Convertir a JSON para enviar al backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'total': total,
      'items': items,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}