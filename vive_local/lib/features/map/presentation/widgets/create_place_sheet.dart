import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/l10n/failure_message.dart';
import '../providers/create_place_controller.dart';

class CreatePlaceSheet extends ConsumerStatefulWidget {
  const CreatePlaceSheet({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.usingMapCenter,
  });

  final double latitude;
  final double longitude;
  final bool usingMapCenter;

  @override
  ConsumerState<CreatePlaceSheet> createState() => _CreatePlaceSheetState();
}

class _CreatePlaceSheetState extends ConsumerState<CreatePlaceSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imagePicker = ImagePicker();
  XFile? _photo;
  bool _isPickingPhoto = false;
  bool _photoPickFailed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    setState(() {
      _isPickingPhoto = true;
      _photoPickFailed = false;
    });
    try {
      final photo = await _imagePicker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (!mounted) {
        return;
      }
      if (photo != null) {
        setState(() => _photo = photo);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _photoPickFailed = true);
      }
    } finally {
      if (mounted) {
        setState(() => _isPickingPhoto = false);
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final created = await ref
        .read(createPlaceControllerProvider.notifier)
        .create(
          name: _nameController.text,
          category: _categoryController.text,
          latitude: widget.latitude,
          longitude: widget.longitude,
          photoPath: _photo?.path,
          photoContentType: _photo?.mimeType,
        );
    if (!mounted) {
      return;
    }
    if (created) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final state = ref.watch(createPlaceControllerProvider);
    final isLoading = state.isLoading;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.createPlaceTitle,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.close,
                      onPressed: isLoading
                          ? null
                          : () => Navigator.of(context).pop(false),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.placeNameLabel,
                    prefixIcon: const Icon(Icons.place_outlined),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? l10n.placeNameRequired
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _categoryController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l10n.placeCategoryLabel,
                    prefixIcon: const Icon(Icons.category_outlined),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? l10n.placeCategoryRequired
                      : null,
                  onFieldSubmitted: (_) => isLoading ? null : _submit(),
                ),
                const SizedBox(height: 16),
                Text(l10n.placePhotoLabel, style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                if (_photo != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(_photo!.path),
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      cacheWidth: 800,
                      semanticLabel: l10n.placePhotoLabel,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 160,
                        color: theme.colorScheme.surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image_outlined,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: isLoading || _isPickingPhoto
                          ? null
                          : () => _pickPhoto(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: Text(l10n.takePhoto),
                    ),
                    OutlinedButton.icon(
                      onPressed: isLoading || _isPickingPhoto
                          ? null
                          : () => _pickPhoto(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: Text(l10n.chooseFromGallery),
                    ),
                    if (_photo != null)
                      TextButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => setState(() => _photo = null),
                        icon: const Icon(Icons.delete_outline),
                        label: Text(l10n.removePhoto),
                      ),
                  ],
                ),
                if (_isPickingPhoto) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(),
                ],
                if (_photoPickFailed) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.errorPhotoPick,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(Icons.my_location),
                    title: Text(
                      l10n.placeLocationHint(
                        widget.latitude.toStringAsFixed(6),
                        widget.longitude.toStringAsFixed(6),
                      ),
                    ),
                    subtitle: widget.usingMapCenter
                        ? Text(l10n.usingMapCenter)
                        : null,
                  ),
                ),
                if (state.hasError) ...[
                  const SizedBox(height: 12),
                  Text(
                    l10n.errorCreatePlace,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    failureMessage(context, state.error!),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: isLoading || _isPickingPhoto ? null : _submit,
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_location_alt_outlined),
                  label: Text(isLoading ? l10n.loading : l10n.savePlace),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
