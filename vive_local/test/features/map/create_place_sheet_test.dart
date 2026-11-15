import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/features/map/presentation/widgets/create_place_sheet.dart';

void main() {
  testWidgets('CreatePlaceSheet validates required fields', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: CreatePlaceSheet(
              latitude: -17.3938,
              longitude: -66.1569,
              usingMapCenter: false,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar lugar'));
    await tester.pump();

    expect(find.text('El nombre es obligatorio'), findsOneWidget);
    expect(find.text('La categoría es obligatoria'), findsOneWidget);
    expect(find.text('Ubicación: -17.393800, -66.156900'), findsOneWidget);
  });
}
