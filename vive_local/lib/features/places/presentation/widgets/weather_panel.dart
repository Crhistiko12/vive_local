import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/env.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/l10n/failure_message.dart';
import '../../domain/weather.dart';

class WeatherPanel extends StatelessWidget {
  const WeatherPanel({super.key, required this.weather, this.onRetry});

  final AsyncValue<Weather> weather;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.weatherTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            weather.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stackTrace) => Row(
                children: [
                  Icon(Icons.cloud_off, color: theme.colorScheme.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      failureMessage(context, error),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  if (onRetry != null)
                    TextButton(
                      onPressed: onRetry,
                      child: Text(l10n.retry),
                    ),
                ],
              ),
              data: (weather) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    '${AppEnv.openWeatherIconUrl}/${weather.iconCode}@2x.png',
                    width: 64,
                    height: 64,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.cloud, size: 40),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${weather.temperatureLabel} · '
                          '${weather.description}',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.weatherFeelsLike(
                            weather.feelsLike.round().toString(),
                          ),
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          '${l10n.weatherHumidity('${weather.humidity}')} · '
                          '${l10n.weatherWind(weather.windSpeed.toStringAsFixed(1))}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
