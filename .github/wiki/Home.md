# qibla

Qibla direction, great-circle path, and haversine distance for Dart and Flutter. Computes the bearing to the Ka'bah from any point on Earth. Pure math, zero dependencies.

## Install

```yaml
dependencies:
  qibla: ^1.0.1
```

```dart
import 'package:qibla/qibla.dart';

final bearing = qiblaAngle(40.7128, -74.006);
print(bearing);               // ~58.48
print(compassDir(bearing));   // NE

final km = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng);
print(km);  // ~9634
```

## Contents

- [Quickstart Guide](guides/quickstart) — install, first call, compass directions
- [Advanced Usage](guides/advanced) — great-circle paths, custom interpolation
- [API Reference](API-Reference) — full function and constant reference
- [Examples](examples/basic-usage) — real-world snippets
- [Contributing](CONTRIBUTING)
