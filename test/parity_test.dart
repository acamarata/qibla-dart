/// Cross-language parity against the JavaScript `qibla` package.
///
/// The two ports are transcriptions of the same spherical trigonometry and are expected to
/// agree exactly, not approximately. This suite pins that:
/// `test/fixtures/cross_language_golden.json` holds the output of the JavaScript package for
/// twenty locations, chosen to include the awkward cases — both poles, both sides of the
/// dateline, the Kaaba itself, its antipode, and points due north and due south of it, where
/// the bearing is degenerate or unstable.
///
/// Floating-point note: both ports run IEEE-754 doubles through the same sequence of
/// operations, so bit-identical results are the expectation rather than a hope. A tolerance
/// of 1e-9 degrees is allowed only to absorb differences in how the two languages parse
/// decimal literals; that is roughly 0.1 millimetres on the ground and cannot mask a real
/// algorithmic divergence, which shows up in the first few decimal places.
///
/// The fixture is produced by the JavaScript package, which is the reference implementation:
/// see `tool/generate-parity-fixture.mjs` in the `qibla` repository. If this suite fails
/// against an unchanged fixture, that is the divergence it exists to catch — fix the port,
/// do not refresh the fixture.
library;

import 'dart:convert';
import 'dart:io';

import 'package:qibla/qibla.dart';
import 'package:test/test.dart';

void main() {
  final raw =
      jsonDecode(
            File('test/fixtures/cross_language_golden.json').readAsStringSync(),
          )
          as Map<String, dynamic>;

  final places = (raw['places'] as List).cast<Map<String, dynamic>>();

  test('fixture is present and covers the degenerate cases', () {
    expect(places.length, greaterThanOrEqualTo(20));
    final names = places.map((p) => p['name'] as String).toSet();
    expect(
      names,
      containsAll(<String>['North Pole', 'South Pole', 'Kaaba itself']),
    );
  });

  test('the Kaaba constants match the JavaScript package exactly', () {
    expect(kaabaLat, (raw['kaabaLat'] as num).toDouble());
    expect(kaabaLng, (raw['kaabaLng'] as num).toDouble());
  });

  group('cross-language parity with the JavaScript qibla package', () {
    for (final p in places) {
      final name = p['name'] as String;
      final lat = (p['lat'] as num).toDouble();
      final lng = (p['lng'] as num).toDouble();

      test(name, () {
        final angle = qiblaAngle(lat, lng);
        expect(
          angle,
          closeTo((p['angle'] as num).toDouble(), 1e-9),
          reason: 'qiblaAngle at $name',
        );

        // Compass labels are pure string lookups off the bearing, so any difference here
        // means the two ports disagree about the rounding boundary, not the maths.
        expect(
          compassDir(angle),
          p['dir'] as String,
          reason: 'compassDir at $name',
        );
        expect(
          compassName(angle),
          p['compassName'] as String,
          reason: 'compassName at $name',
        );

        expect(
          distanceKm(lat, lng, kaabaLat, kaabaLng),
          closeTo((p['distance'] as num).toDouble(), 1e-6),
          reason: 'distanceKm at $name',
        );

        // Great-circle path: length, and the first, middle and last points. Pinning the
        // midpoint catches an interpolation that drifts without moving the endpoints.
        final path = qiblaGreatCircle(lat, lng);
        expect(
          path.length,
          p['gcLength'] as int,
          reason: 'path length at $name',
        );

        final expectedGc =
            (p['gc'] as List)
                .map(
                  (pt) =>
                      (pt as List).map((v) => (v as num).toDouble()).toList(),
                )
                .toList();
        final actualGc = [path.first, path[path.length ~/ 2], path.last];

        for (var i = 0; i < 3; i++) {
          expect(
            actualGc[i][0],
            closeTo(expectedGc[i][0], 1e-9),
            reason: 'path point $i latitude at $name',
          );
          expect(
            actualGc[i][1],
            closeTo(expectedGc[i][1], 1e-9),
            reason: 'path point $i longitude at $name',
          );
        }
      });
    }
  });
}
