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

    print(
      '${city.padRight(18)}'
      '${bearing.toStringAsFixed(1).padLeft(6)}°  '
      '${dir.padRight(9)}  '
      '${km.toStringAsFixed(0)} km',
    );
  }
}
```

Expected output:

```
City              Bearing  Direction  Distance
──────────────────────────────────────────────────────
New York            58.5°  NE         9634 km
London              49.3°  NE         5148 km
Istanbul            41.5°  NE         2517 km
Jakarta            295.1°  NW         7665 km
Cape Town           22.3°  NE         8832 km
```

## Great-Circle Path Waypoints

```dart
import 'package:qibla/qibla.dart';

void main() {
  // 8 segments (9 waypoints) from London to Makkah
  final path = qiblaGreatCircle(51.5074, -0.1278, steps: 8);

  print('Waypoints from London to Makkah:');
  for (int i = 0; i < path.length; i++) {
    print(
      '  ${i + 1}. '
      '${path[i][0].toStringAsFixed(4)}°, '
      '${path[i][1].toStringAsFixed(4)}°',
    );
  }
}
```

Each element of the returned list is a `[latitude, longitude]` pair in decimal degrees. The first point is the observer location; the last is the Ka'bah.
