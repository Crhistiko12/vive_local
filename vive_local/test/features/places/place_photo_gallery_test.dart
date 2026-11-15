import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vive_local/core/l10n/app_localizations.dart';
import 'package:vive_local/features/places/domain/lugar_foto.dart';
import 'package:vive_local/features/places/presentation/providers/place_photos_providers.dart';
import 'package:vive_local/features/places/presentation/widgets/place_photo_gallery.dart';

void main() {
  testWidgets('renders empty state when there are no photos', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          placePhotosProvider('test-place').overrideWith(
            (ref) async => <LugarFoto>[],
          ),
        ],
        child: MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: PlacePhotoGallery(lugarId: 'test-place'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Aún no hay fotos para este lugar'), findsOneWidget);
    expect(find.text('Tomar foto con la cámara'), findsOneWidget);
  });

  testWidgets('renders thumbnails and badges when photos are available',
      (tester) async {
    const photos = [
      LugarFoto(
        id: 1,
        lugarId: 'test-place',
        imagePath: 'https://example.com/photo1.jpg',
        esLocal: false,
      ),
      LugarFoto(
        id: 2,
        lugarId: 'test-place',
        imagePath: '/tmp/local_photo.jpg',
        esLocal: true,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          placePhotosProvider('test-place').overrideWith(
            (ref) async => photos,
          ),
        ],
        child: MaterialApp(
          locale: const Locale('es'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: PlacePhotoGallery(lugarId: 'test-place'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Web'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
    expect(find.text('Tomar foto'), findsOneWidget);
  });
}
