/// Qibla direction utilities. Pure math, zero external dependencies.
///
/// Computes the initial bearing (forward azimuth) from any point on Earth to
/// the Ka'bah using the spherical law of cosines. Includes compass direction
/// lookup, great-circle interpolation, and haversine distance.
///
/// Ka'bah coordinates sourced from verified GPS data.
library;

import 'dart:math';

/// Latitude of the Ka'bah center, Masjid al-Haram, Mecca (degrees north).
const double kaabaLat = 21.422511;

/// Longitude of the Ka'bah center, Masjid al-Haram, Mecca (degrees east).
const double kaabaLng = 39.82615;

/// Mean radius of the Earth in kilometers (WGS-84 volumetric mean).
const double earthRadiusKm = 6371;

const double _deg = pi / 180;

/// Eight-point compass abbreviations.
const List<String> _compassAbbr = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];

/// Eight-point compass full names.
const List<String> _compassNames = [
  'North',
  'Northeast',
  'East',
  'Southeast',
  'South',
  'Southwest',
  'West',
  'Northwest',
];

/// Qibla bearing in degrees clockwise from true north.
///
/// Uses the forward azimuth formula from spherical trigonometry.
/// Result range: [0, 360).
///
/// [lat] is the observer latitude in decimal degrees (-90 to 90).
/// [lng] is the observer longitude in decimal degrees (-180 to 180).
///
/// Returns the bearing in degrees clockwise from north
/// (0 = N, 90 = E, 180 = S, 270 = W).
///
/// Throws [RangeError] if latitude is outside [-90, 90] or longitude
/// outside [-180, 180].
double qiblaAngle(double lat, double lng) {
  if (lat < -90 || lat > 90) {
    throw RangeError('Latitude must be between -90 and 90, got $lat');
  }
  if (lng < -180 || lng > 180) {
    throw RangeError('Longitude must be between -180 and 180, got $lng');
  }
  final phi1 = lat * _deg;
  final lam1 = lng * _deg;
  final phi2 = kaabaLat * _deg;
  final lam2 = kaabaLng * _deg;
  final y = sin(lam2 - lam1) * cos(phi2);
  final x = cos(phi1) * sin(phi2) - sin(phi1) * cos(phi2) * cos(lam2 - lam1);
  return (atan2(y, x) / _deg + 360) % 360;
}

/// Eight-point compass abbreviation for a bearing.
///
/// [bearing] is the bearing in degrees (0-360).
///
/// Returns a compass abbreviation: N, NE, E, SE, S, SW, W, or NW.
String compassDir(double bearing) {
  return _compassAbbr[(bearing / 45).round() % 8];
}

/// Full compass direction name for a bearing.
///
/// [bearing] is the bearing in degrees (0-360).
///
/// Returns the full direction name (North, Northeast, etc.).
String compassName(double bearing) {
  return _compassNames[(bearing / 45).round() % 8];
}

/// Great-circle waypoints from ([lat], [lng]) to the Ka'bah.
///
/// Uses Slerp (spherical linear interpolation). Useful for drawing Qibla
/// direction lines on maps.
///
/// [lat] is the origin latitude in decimal degrees.
/// [lng] is the origin longitude in decimal degrees.
/// [steps] is the number of segments (default: 120, producing 121 points).
///
/// Returns a list of [lat, lng] pairs in degrees.
///
/// Throws [RangeError] if coordinates are out of bounds.
List<List<double>> qiblaGreatCircle(double lat, double lng, [int steps = 120]) {
  if (lat < -90 || lat > 90) {
    throw RangeError('Latitude must be between -90 and 90, got $lat');
  }
  if (lng < -180 || lng > 180) {
    throw RangeError('Longitude must be between -180 and 180, got $lng');
  }
  final phi1 = lat * _deg;
  final lam1 = lng * _deg;
  final phi2 = kaabaLat * _deg;
  final lam2 = kaabaLng * _deg;

  final d =
      2 *
      asin(
        sqrt(
          pow(sin((phi2 - phi1) / 2), 2) +
              cos(phi1) * cos(phi2) * pow(sin((lam2 - lam1) / 2), 2),
        ),
      );

  if (d == 0) {
    return [
      [lat, lng],
    ];
  }

  final points = <List<double>>[];
  for (var i = 0; i <= steps; i++) {
    final f = i / steps;
    final a = sin((1 - f) * d) / sin(d);
    final b = sin(f * d) / sin(d);
    final x = a * cos(phi1) * cos(lam1) + b * cos(phi2) * cos(lam2);
    final y = a * cos(phi1) * sin(lam1) + b * cos(phi2) * sin(lam2);
    final z = a * sin(phi1) + b * sin(phi2);
    points.add([atan2(z, sqrt(x * x + y * y)) / _deg, atan2(y, x) / _deg]);
  }
  return points;
}

/// Haversine distance between two coordinate pairs.
///
/// [lat1], [lng1] define the first point in decimal degrees.
/// [lat2], [lng2] define the second point in decimal degrees.
///
/// Returns the distance in kilometers (spherical Earth approximation).
double distanceKm(double lat1, double lng1, double lat2, double lng2) {
  final dLat = (lat2 - lat1) * _deg;
  final dLng = (lng2 - lng1) * _deg;
  final a =
      pow(sin(dLat / 2), 2) +
      cos(lat1 * _deg) * cos(lat2 * _deg) * pow(sin(dLng / 2), 2);
  return earthRadiusKm * 2 * atan2(sqrt(a), sqrt(1 - a));
}
