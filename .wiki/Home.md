# qibla

Qibla direction, great-circle path, and haversine distance for Dart and Flutter. Pure math, zero dependencies.

## Quick Start

```dart
import 'package:qibla/qibla.dart';

final bearing = qiblaAngle(40.7128, -74.006);
print(bearing);             // ~58.48
print(compassDir(bearing)); // NE

final km = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng);
print(km); // ~9634
```

## Pages

- [API Reference](API-Reference) — Full function and constant reference
- [Architecture](Architecture) — Spherical trigonometry and Slerp implementation
