import 'package:equatable/equatable.dart';

class OrganizationCredentials extends Equatable {
  final String email;
  final String password;
  final String organizationName;

  const OrganizationCredentials({
    required this.email,
    required this.password,
    required this.organizationName,
  });

  @override
  List<Object?> get props => [email, password, organizationName];
}

abstract class OrganizationWalletStore {
  /// Saves organization credentials
  Future<void> saveCredentials(OrganizationCredentials credentials);

  /// Retrieves all saved organization credentials
  Future<List<OrganizationCredentials>> getAllCredentials();

  /// Deletes credentials for a specific organization
  Future<void> deleteCredentials(String organizationName);

  /// Updates existing credentials
  Future<void> updateCredentials(OrganizationCredentials credentials);
} 
