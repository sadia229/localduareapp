
class PaymentMethodModel {
  final String id;
  final String name;
  final String description;
  final String? icon;
  final bool isPopular;

  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.description,
     this.icon,
    this.isPopular = false,
  });
}