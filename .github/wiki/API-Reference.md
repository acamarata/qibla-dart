# API Reference

## qiblaAngle

```dart
double qiblaAngle(double lat, double lng)
```

Computes the initial bearing (forward azimuth) from the given coordinates to the Ka'bah using the spherical forward azimuth formula.

| Parameter | Type | Description |
| --- | --- | --- |
| `lat` | `double` | Latitude in decimal degrees (-90 to 90) |
| `lng` | `double` | Longitude in decimal degrees (-180 to 180) |
| Returns | `double` | Bearing in degrees clockwise from north (0-360) |

Throws `RangeError` if coordinates are out of bounds.

```dart
final bearing = qiblaAngle(40.7128, -74.006); // ~58.48
```

---

## compassDir

```dart
String compassDir(double bearing)
```

Returns an eight-point compass abbreviation for the given bearing.

| Bearing range | Returns |
| --- | --- |
| 337.5 - 22.5 | N |
| 22.5 - 67.5 | NE |
| 67.5 - 112.5 | E |
| 112.5 - 157.5 | SE |
| 157.5 - 202.5 | S |
| 202.5 - 247.5 | SW |
| 247.5 - 292.5 | W |
| 292.5 - 337.5 | NW |

---

## compassName

```dart
String compassName(double bearing)
```

Returns the full compass direction name for the given bearing: North, Northeast, East, Southeast, South, Southwest, West, or Northwest.

---

## qiblaGreatCircle

```dart
List<LatLng> qiblaGreatCircle(double lat, double lng, [int steps = 120])
```

Generates waypoints along the great circle from the observer's location to the Ka'bah using spherical linear interpolation (Slerp). Returns `steps + 1` points including both endpoints.

Useful for drawing the Qibla direction line on a map.

```dart
final path = qiblaGreatCircle(40.7128, -74.006);
// path[0] = observer location
// path[path.length - 1] = Ka'bah
```

### LatLng fields

| Field | Type | Description |
| --- | --- | --- |
| `lat` | `double` | Latitude in decimal degrees |
| `lng` | `double` | Longitude in decimal degrees |

---

## distanceKm

```dart
double distanceKm(double lat1, double lng1, double lat2, double lng2)
```

Haversine distance between two points in kilometers. Uses a spherical Earth model with R = 6,371 km.

```dart
final km = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng); // ~9634
```

---

## Constants

| Constant | Value | Description |
| --- | --- | --- |
| `kaabaLat` | 21.422511 | Ka'bah center latitude (degrees north) |
| `kaabaLng` | 39.826150 | Ka'bah center longitude (degrees east) |
| `earthRadiusKm` | 6371 | WGS-84 volumetric mean radius in km |

---

[Home](Home)
