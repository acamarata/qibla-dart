# qibla

[![pub package](https://img.shields.io/pub/v/qibla.svg)](https://pub.dev/packages/qibla)
[![CI](https://github.com/acamarata/qibla-dart/actions/workflows/ci.yml/badge.svg)](https://github.com/acamarata/qibla-dart/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![wiki](https://img.shields.io/badge/docs-wiki-blue.svg)](https://github.com/acamarata/qibla-dart/wiki)

Qibla direction, great-circle path, and haversine distance for Dart and Flutter. Pure math, zero dependencies.

## Installation

```yaml
dependencies:
  qibla: ^1.0.0
```

## Quick Start

```dart
import 'package:qibla/qibla.dart';

// Bearing from New York to the Ka'bah
final bearing = qiblaAngle(40.7128, -74.006);
print(bearing);             // ~58.48
print(compassDir(bearing)); // NE

// Distance in kilometers
final km = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng);
print(km); // ~9634
```

## API

| Function | Returns | Description |
| --- | --- | --- |
| `qiblaAngle(lat, lng)` | `double` | Bearing to Ka'bah, degrees clockwise from north |
| `compassDir(bearing)` | `String` | Eight-point abbreviation: N, NE, E, SE, S, SW, W, NW |
| `compassName(bearing)` | `String` | Full name: North, Northeast, ... |
| `qiblaGreatCircle(lat, lng, [steps])` | `List<List<double>>` | Great-circle waypoints to the Ka'bah |
| `distanceKm(lat1, lng1, lat2, lng2)` | `double` | Haversine distance in km |

Constants: `kaabaLat` (21.422511), `kaabaLng` (39.82615), `earthRadiusKm` (6371).

Full reference: [API Reference](https://github.com/acamarata/qibla-dart/wiki/API-Reference).

## Architecture

All calculations use the forward azimuth formula from spherical trigonometry. Great-circle paths use Slerp. Distance uses the haversine formula. Ka'bah coordinates are fixed constants verified against published GPS surveys.

## Compatibility

Dart 3.7+. Works with Flutter and standalone Dart.

## Related

- [qibla](https://www.npmjs.com/package/@acamarata/qibla) (npm) - The TypeScript version of this package.
- [pray-calc-dart](https://github.com/acamarata/pray-calc-dart) - Islamic prayer times calculator for Dart.

## License

[MIT](LICENSE)
