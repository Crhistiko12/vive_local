import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/database/database_helper.dart';
import '../domain/lugar_foto.dart';

class PlacePhotosRepository {
  PlacePhotosRepository({
    DatabaseHelper? databaseHelper,
    ImagePicker? imagePicker,
  })  : _databaseHelper = databaseHelper ?? DatabaseHelper.instance,
        _imagePicker = imagePicker ?? ImagePicker();

  final DatabaseHelper _databaseHelper;
  final ImagePicker _imagePicker;

  Future<LugarFoto?> takePhotoWithCamera({required String lugarId}) async {
    final photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );
    if (photo == null) {
      return null;
    }

    return saveLocalPhoto(
      lugarId: lugarId,
      sourceFile: File(photo.path),
    );
  }

  Future<LugarFoto?> pickPhotoFromGallery({required String lugarId}) async {
    final photo = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );
    if (photo == null) {
      return null;
    }

    return saveLocalPhoto(
      lugarId: lugarId,
      sourceFile: File(photo.path),
    );
  }

  Future<LugarFoto> saveLocalPhoto({
    required String lugarId,
    required File sourceFile,
  }) async {
    final appDir = await getApplicationDocumentsDirectory();
    final photosDir = Directory(p.join(appDir.path, 'lugar_fotos'));
    if (!await photosDir.exists()) {
      await photosDir.create(recursive: true);
    }

    final ext = p.extension(sourceFile.path).isNotEmpty
        ? p.extension(sourceFile.path)
        : '.jpg';
    final fileName = '${lugarId}_${DateTime.now().millisecondsSinceEpoch}$ext';
    final destinationPath = p.join(photosDir.path, fileName);

    final savedFile = await sourceFile.copy(destinationPath);

    final foto = LugarFoto(
      lugarId: lugarId,
      imagePath: savedFile.path,
      esLocal: true,
    );

    final id = await _databaseHelper.insertFoto(foto);
    return foto.copyWith(id: id);
  }

  Future<List<LugarFoto>> getPhotosForPlace(
    String lugarId, {
    String? defaultPhotoUrl,
  }) async {
    await _databaseHelper.seedDefaultPhotos();
    var photos = await _databaseHelper.getFotosByLugarId(lugarId);

    if (defaultPhotoUrl != null &&
        defaultPhotoUrl.trim().isNotEmpty &&
        !photos.any((f) => f.imagePath == defaultPhotoUrl.trim())) {
      final defaultFoto = LugarFoto(
        lugarId: lugarId,
        imagePath: defaultPhotoUrl.trim(),
        esLocal: false,
      );
      final id = await _databaseHelper.insertFoto(defaultFoto);
      photos = [...photos, defaultFoto.copyWith(id: id)];
    }

    return photos;
  }

  Future<void> deletePhoto(LugarFoto foto) async {
    if (foto.id != null) {
      await _databaseHelper.deleteFoto(foto.id!);
    }
    if (foto.esLocal) {
      try {
        final file = File(foto.imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {}
    }
  }
}
