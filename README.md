# qibla

[![pub package](https://img.shields.io/pub/v/qibla.svg)](https://pub.dev/packages/qibla)
[![CI](https://github.com/acamarata/qibla-dart/actions/workflows/ci.yml/badge.svg)](https://github.com/acamarata/qibla-dart/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

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
print(bearing);            // ~58.48
print(compassDir(bearing)); // NE

// Distance in kilometers
final km = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng);
print(km); // ~9634
```

## API

### `qiblaAngle(lat, lng)`

Computes the initial bearing (forward azimuth) from the given coordinates to the Ka'bah.

| Parameter    | Type     | Description                                     |
| ------------ | -------- | ----------------------------------------------- |
| `lat`        | `double` | Latitude in decimal degrees (-90 to 90)         |
| `lng`        | `double` | Longitude in decimal degrees (-180 to 180)      |
| **Returns**  | `double` | Bearing in degrees clockwise from north (0-360) |

Throws `RangeError` if coordinates are out of bounds.

### `compassDir(bearing)`

Eight-point compass abbreviation: N, NE, E, SE, S, SW, W, NW.

### `compassName(bearing)`

Full compass name: North, Northeast, East, Southeast, South, Southwest, West, Northwest.

### `qiblaGreatCircle(lat, lng, [steps])`

Generates waypoints along the great circle from (lat, lng) to the Ka'bah using spherical linear interpolation (Slerp). Returns `steps + 1` points (default: 121).

Useful for drawing Qibla direction lines on maps.

### `distanceKm(lat1, lng1, lat2, lng2)`

Haversine distance between two points in kilometers (spherical Earth approximation, R = 6,371 km).

### Constants

| Name           | Value     | Description                            |
| -------------- | --------- | -------------------------------------- |
| `kaabaLat`     | 21.422511 | Ka'bah center latitude (degrees north) |
| `kaabaLng`     | 39.826150 | Ka'bah center longitude (degrees east) |
| `earthRadiusKm`| 6371      | WGS-84 volumetric mean radius          |

## Architecture

All calculations use the forward azimuth formula from spherical trigonometry. Great-circle paths use spherical linear interpolation (Slerp). Distance uses the haversine formula. The Ka'bah coordinates are fixed constants verified against published GPS surveys.

## Compatibility

Dart 3.7+. Works with Flutter and standalone Dart applications.

## Related

- [qibla](https://www.npmjs.com/package/qibla) (npm) - The TypeScript version of this package.
- [pray-calc](https://github.com/acamarata/pray-calc) - Islamic prayer times calculator.

## Acknowledgments

Ka'bah coordinates verified against published GPS surveys and cross-checked with satellite imagery. Spherical trigonometry formulas follow the standard forward azimuth derivation used in aviation and geodesy.

## License

[MIT](LICENSE)
