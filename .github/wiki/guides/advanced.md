# Advanced Usage

## Great-Circle Path

Compute N interpolated waypoints along the great-circle route from your location to the Ka'bah:

```dart
import 'package:qibla/qibla.dart';

void main() {
  // 5 waypoints from New York to Makkah
  final path = greatCirclePath(40.7128, -74.0060, kaabaLat, kaabaLng, 5);

  for (final point in path) {
    print('${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}');
  }
}
```

The path uses spherical linear interpolation (Slerp) and returns `n` evenly spaced coordinates including the start and end points.

## Custom Destination

`distanceKm` and `greatCirclePath` work with any two points, not just the Ka'bah:

```dart
// Distance between two mosques
final km = distanceKm(51.5074, -0.1278, 40.7128, -74.0060);
print('London to New York: ${km.toStringAsFixed(0)} km');

// Path from Istanbul to Makkah
final path = greatCirclePath(41.0082, 28.9784, kaabaLat, kaabaLng, 10);
```

## Flutter Compass Widget Integration

```dart
import 'package:qibla/qibla.dart';

// In a StatefulWidget with device compass heading:
Widget buildQiblaArrow(double deviceHeading, double lat, double lng) {
  final qibla = qiblaAngle(lat, lng);
  final arrowRotation = (qibla - deviceHeading) * (pi / 180);

  return Transform.rotate(
    angle: arrowRotation,
    child: const Icon(Icons.navigation, size: 48),
  );
}
```
