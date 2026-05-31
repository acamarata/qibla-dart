# Flutter Integration

This example shows how to use `qibla` in a Flutter widget. It reads the device's current location using `geolocator`, computes the Qibla bearing, and displays the result.

## Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  qibla: ^1.0.0
  geolocator: ^14.0.0
```

## QiblaCard Widget

```dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla/qibla.dart';

class QiblaCard extends StatefulWidget {
  const QiblaCard({super.key});

  @override
  State<QiblaCard> createState() => _QiblaCardState();
}

class _QiblaCardState extends State<QiblaCard> {
  double? _bearing;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadQibla();
  }

  Future<void> _loadQibla() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => _error = 'Location permission denied.');
        return;
      }

      final pos = await Geolocator.getCurrentPosition();
      final bearing = qiblaAngle(pos.latitude, pos.longitude);
      setState(() => _bearing = bearing);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Text('Error: $_error');
    }
    if (_bearing == null) {
      return const CircularProgressIndicator();
    }

    final dir = compassName(_bearing!);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_bearing!.toStringAsFixed(1)}°',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 4),
            Text(dir, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Qibla bearing from your location'),
          ],
        ),
      ),
    );
  }
}
```

## Notes

- `qiblaAngle` and `compassName` are pure functions. They do not require any platform channel or plugin; the only async work is the location request.
- The bearing is in degrees clockwise from true north. To rotate a compass needle image, use a `Transform.rotate` widget with `angle = bearing * (pi / 180)`.
- For a live compass, combine the bearing with a magnetometer reading from `flutter_compass` to subtract the device heading.
