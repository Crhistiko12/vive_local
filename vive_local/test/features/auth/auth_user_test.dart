import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/features/auth/domain/auth_user.dart';

void main() {
  group('AuthUser.initials', () {
    test('uses the first letters of first and last name', () {
      const user = AuthUser(
        id: '1',
        email: 'ana.perez@example.com',
        displayName: 'Ana Pérez',
      );

      expect(user.initials, 'AP');
    });

    test('falls back to the email when there is no display name', () {
      const user = AuthUser(id: '1', email: 'ana@example.com');

      expect(user.initials, 'A');
    });

    test('uses the first letter for a single-word name', () {
      const user = AuthUser(id: '1', email: 'x@example.com', displayName: 'Ana');

      expect(user.initials, 'A');
    });
  });
}
