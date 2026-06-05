class PickupOrder {
  final String orderNumber;
  final String status;
  final double total;
  final int remainingMinutes;
  final List<Map<String, dynamic>> items;

  PickupOrder({
    required this.orderNumber,
    required this.status,
    required this.total,
    required this.remainingMinutes,
    required this.items,
  });
}