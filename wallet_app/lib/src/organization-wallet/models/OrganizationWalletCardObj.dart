import 'dart:ffi';

class OrganizationWalletCardObj {
  final String id;
  final Map<String, dynamic> organization;
  final String name;
  final String description;
  final String backgroundImage;
  final String icon;
  final bool darkMode;
  final bool clickable;
  final String? issuerImg; 
  final List<Attribute>? attributes;

  OrganizationWalletCardObj({
    required this.id,
    required this.organization,
    required this.name,
    required this.description,
    required this.backgroundImage,
    required this.icon,
    required this.darkMode,
    required this.clickable,
    this.attributes,
    this.issuerImg
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
