import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/features/map/domain/place.dart';
import 'package:vive_local/features/map/presentation/widgets/place_summary_card.dart';

void main() {
  testWidgets('shows the place photo when a URL is available', (tester) async {
    const place = Place(
      id: 'cafe-central',
      name: 'Café Central',
      latitude: -17.3938,
      longitude: -66.1569,
      photoUrl: 'https://example.com/lugar.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: PlaceSummaryCard(place: place, onViewDetails: () {}),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Café Central'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
