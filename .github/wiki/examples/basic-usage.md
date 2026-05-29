# Basic Usage Examples

## Qibla for Multiple Cities

```dart
import 'package:qibla/qibla.dart';

void main() {
  final cities = [
    ('New York',  40.7128,  -74.0060),
    ('London',    51.5074,   -0.1278),
    ('Istanbul',  41.0082,   28.9784),
    ('Jakarta',   -6.2088,  106.8456),
    ('Cape Town', -33.9249,  18.4241),
  ];

  print('City              Bearing  Direction  Distance');
  print('${'─' * 54}');

  for (final (city, lat, lng) in cities) {
    final bearing = qiblaAngle(lat, lng);
    final dir = compassDir(bearing);
    final km = distanceKm(lat, lng, kaabaLat, kaabaLng);

    print('${city.padRight(18)}${bearing.toStringAsFixed(1).padLeft(6)}°  ${dir.padRight(9)}  ${km.toStringAsFixed(0)} km');
  }
}
```

## Great-Circle Path Waypoints

```dart
import 'package:qibla/qibla.dart';

void main() {
  // 8 waypoints from London to Makkah
  final path = greatCirclePath(51.5074, -0.1278, kaabaLat, kaabaLng, 8);

  print('Waypoints from London to Makkah:');
  for (int i = 0; i < path.length; i++) {
    final p = path[i];
    print('  ${i + 1}. ${p.latitude.toStringAsFixed(4)}°, ${p.longitude.toStringAsFixed(4)}°');
  }
}
```
