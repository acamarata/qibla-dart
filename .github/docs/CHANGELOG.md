# Changelog

## 1.0.1 - 2026-05-25

### Verified

- Full surface-area parity audit against `@acamarata/qibla` (JS reference package).
- All five public functions (`qiblaAngle`, `compassDir`, `compassName`,
  `qiblaGreatCircle`, `distanceKm`) and three exported constants (`kaabaLat`,
  `kaabaLng`, `earthRadiusKm`) confirmed present with idiomatic Dart typed
  signatures and matching semantics. No gaps found.
- 48 tests pass; no changes to runtime code required.

## 1.0.0 - 2026-03-08

### Added

- `qiblaAngle(lat, lng)` computes the initial bearing to the Ka'bah in degrees.
- `compassDir(bearing)` returns an eight-point compass abbreviation (N, NE, E, etc.).
- `compassName(bearing)` returns the full compass direction name (North, Northeast, etc.).
- `qiblaGreatCircle(lat, lng, [steps])` generates waypoints along the great circle to the Ka'bah via spherical linear interpolation.
- `distanceKm(lat1, lng1, lat2, lng2)` computes haversine distance between two points.
- Constants: `kaabaLat`, `kaabaLng`, `earthRadiusKm`.
- RangeError validation for all coordinate inputs.
