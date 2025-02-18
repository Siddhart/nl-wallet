import 'dart:ffi';

class OrganizationWalletCardObj {
  final String id;
  final String name;
  final String description;
  final String backgroundImage;
  final String icon;
  final bool darkMode;
  final bool clickable;
  final List<Attribute> attributes;

  OrganizationWalletCardObj({
    required this.id,
    required this.name,
    required this.description,
    required this.backgroundImage,
    required this.icon,
    required this.darkMode,
    required this.clickable,
    required this.attributes,
  });
}

class Attribute {
  final String name;
  final String value;

  Attribute({
    required this.name,
    required this.value,
  });
}
