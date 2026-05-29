# Quickstart

## Install

Add to `pubspec.yaml`:

```yaml
dependencies:
  qibla: ^1.0.1
```

Run `dart pub get`.

## Qibla Bearing

```dart
import 'package:qibla/qibla.dart';

void main() {
  // New York
  final bearing = qiblaAngle(40.7128, -74.0060);
  print('Bearing to Ka''bah: ${bearing.toStringAsFixed(2)}°');
  print('Compass direction:  ${compassDir(bearing)}');
  print('Full direction:     ${compassPoint(bearing)}');

  // Distance to Ka'bah
  final km = distanceKm(40.7128, -74.0060, kaabaLat, kaabaLng);
  print('Distance:          ${km.toStringAsFixed(0)} km');
}
```

## Compass Directions

`compassDir` returns an 8-point abbreviation (N, NE, E, SE, S, SW, W, NW).
`compassPoint` returns the full name (North, Northeast, East, etc.).

```dart
final bearing = qiblaAngle(lat, lng);
final short = compassDir(bearing);   // "NE"
final full = compassPoint(bearing);  // "Northeast"
```

## Ka'bah Coordinates

The Ka'bah coordinates are exported as constants:

```dart
print(kaabaLat);  // 21.4225
print(kaabaLng);  // 39.8262
```
