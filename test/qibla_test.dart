import 'package:qibla/qibla.dart';
import 'package:test/test.dart';

void main() {
  group('KAABA constants', () {
    test('latitude is approximately 21.42 N', () {
      expect((kaabaLat - 21.42).abs(), lessThan(0.1));
    });
    test('longitude is approximately 39.83 E', () {
      expect((kaabaLng - 39.83).abs(), lessThan(0.1));
    });
    test('earthRadiusKm is 6371', () {
      expect(earthRadiusKm, equals(6371));
    });
  });

  group('qiblaAngle', () {
    test('returns a number between 0 and 360', () {
      final angle = qiblaAngle(40.7128, -74.006);
      expect(angle, greaterThanOrEqualTo(0));
      expect(angle, lessThan(360));
    });

    test('New York City (~58 NE)', () {
      final angle = qiblaAngle(40.7128, -74.006);
      expect(angle, greaterThan(50));
      expect(angle, lessThan(70));
    });

    test('London (~119 SE)', () {
      final angle = qiblaAngle(51.5074, -0.1278);
      expect(angle, greaterThan(110));
      expect(angle, lessThan(130));
    });

    test('Tokyo (~293 NW)', () {
      final angle = qiblaAngle(35.6762, 139.6503);
      expect(angle, greaterThan(280));
      expect(angle, lessThan(310));
    });

    test('Sydney (~277 W)', () {
      final angle = qiblaAngle(-33.8688, 151.2093);
      expect(angle, greaterThan(260));
      expect(angle, lessThan(300));
    });

    test('Islamabad (~268 W)', () {
      final angle = qiblaAngle(33.6844, 73.0479);
      expect(angle, greaterThan(250));
      expect(angle, lessThan(290));
    });

    test('returns finite number at Ka\'bah (degenerate case)', () {
      final angle = qiblaAngle(kaabaLat, kaabaLng);
      expect(angle.isFinite, isTrue);
    });

    test('equator east of Mecca points NW', () {
      final angle = qiblaAngle(0, 80);
      expect(angle, greaterThan(270));
      expect(angle, lessThan(360));
    });

    test('result is stable (same input gives same output)', () {
      final a = qiblaAngle(40.7128, -74.006);
      final b = qiblaAngle(40.7128, -74.006);
      expect(a, equals(b));
    });

    test('throws RangeError for invalid latitude', () {
      expect(() => qiblaAngle(91, 0), throwsRangeError);
      expect(() => qiblaAngle(-91, 0), throwsRangeError);
    });

    test('throws RangeError for invalid longitude', () {
      expect(() => qiblaAngle(0, 181), throwsRangeError);
      expect(() => qiblaAngle(0, -181), throwsRangeError);
    });
  });

  group('compassDir', () {
    test('returns N for 0', () => expect(compassDir(0), equals('N')));
    test('returns N for 360', () => expect(compassDir(360), equals('N')));
    test('returns NE for 45', () => expect(compassDir(45), equals('NE')));
    test('returns E for 90', () => expect(compassDir(90), equals('E')));
    test('returns SE for 135', () => expect(compassDir(135), equals('SE')));
    test('returns S for 180', () => expect(compassDir(180), equals('S')));
    test('returns SW for 225', () => expect(compassDir(225), equals('SW')));
    test('returns W for 270', () => expect(compassDir(270), equals('W')));
    test('returns NW for 315', () => expect(compassDir(315), equals('NW')));
    test('returns NE for NYC Qibla', () {
      final bearing = qiblaAngle(40.7128, -74.006);
      expect(compassDir(bearing), equals('NE'));
    });
  });

  group('compassName', () {
    test('returns North for 0', () {
      expect(compassName(0), equals('North'));
    });
    test('returns Northeast for 45', () {
      expect(compassName(45), equals('Northeast'));
    });
    test('returns East for 90', () {
      expect(compassName(90), equals('East'));
    });
    test('returns Southeast for 135', () {
      expect(compassName(135), equals('Southeast'));
    });
    test('returns South for 180', () {
      expect(compassName(180), equals('South'));
    });
    test('returns Southwest for 225', () {
      expect(compassName(225), equals('Southwest'));
    });
    test('returns West for 270', () {
      expect(compassName(270), equals('West'));
    });
    test('returns Northwest for 315', () {
      expect(compassName(315), equals('Northwest'));
    });
    test('returns North for 360', () {
      expect(compassName(360), equals('North'));
    });
  });

  group('qiblaGreatCircle', () {
    test('returns a list of [lat, lng] pairs', () {
      final points = qiblaGreatCircle(40.7128, -74.006);
      expect(points, isNotEmpty);
      expect(points[0].length, equals(2));
    });

    test('returns 121 points by default', () {
      final points = qiblaGreatCircle(40.7128, -74.006);
      expect(points.length, equals(121));
    });

    test('respects custom steps parameter', () {
      final points = qiblaGreatCircle(40.7128, -74.006, 60);
      expect(points.length, equals(61));
    });

    test('first point is close to origin', () {
      final point = qiblaGreatCircle(40.7128, -74.006)[0];
      expect((point[0] - 40.7128).abs(), lessThan(0.01));
      expect((point[1] - -74.006).abs(), lessThan(0.01));
    });

    test('last point is close to Ka\'bah', () {
      final points = qiblaGreatCircle(40.7128, -74.006);
      final last = points[points.length - 1];
      expect((last[0] - kaabaLat).abs(), lessThan(0.01));
      expect((last[1] - kaabaLng).abs(), lessThan(0.01));
    });

    test('all points have valid coordinates', () {
      final points = qiblaGreatCircle(51.5074, -0.1278, 10);
      for (final point in points) {
        expect(point[0].isFinite, isTrue);
        expect(point[1].isFinite, isTrue);
        expect(point[0], greaterThanOrEqualTo(-90));
        expect(point[0], lessThanOrEqualTo(90));
        expect(point[1], greaterThanOrEqualTo(-180));
        expect(point[1], lessThanOrEqualTo(180));
      }
    });

    test('returns single point at Ka\'bah', () {
      final points = qiblaGreatCircle(kaabaLat, kaabaLng);
      expect(points.length, equals(1));
      expect((points[0][0] - kaabaLat).abs(), lessThan(0.0001));
      expect((points[0][1] - kaabaLng).abs(), lessThan(0.0001));
    });

    test('throws RangeError for invalid coordinates', () {
      expect(() => qiblaGreatCircle(91, 0), throwsRangeError);
      expect(() => qiblaGreatCircle(0, 181), throwsRangeError);
    });
  });

  group('distanceKm', () {
    test('returns 0 for the same point', () {
      expect(
        distanceKm(40.7128, -74.006, 40.7128, -74.006).abs(),
        lessThan(0.001),
      );
    });

    test('NYC to Ka\'bah is approximately 9600 km', () {
      final km = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng);
      expect(km, greaterThan(9000));
      expect(km, lessThan(10500));
    });

    test('London to Ka\'bah is approximately 4950 km', () {
      final km = distanceKm(51.5074, -0.1278, kaabaLat, kaabaLng);
      expect(km, greaterThan(4500));
      expect(km, lessThan(5500));
    });

    test('distance is symmetric', () {
      final d1 = distanceKm(40.7128, -74.006, kaabaLat, kaabaLng);
      final d2 = distanceKm(kaabaLat, kaabaLng, 40.7128, -74.006);
      expect((d1 - d2).abs(), lessThan(0.001));
    });

    test('quarter equator is approximately 10,018 km', () {
      final d = distanceKm(0, 0, 0, 90);
      expect(d, greaterThan(9800));
      expect(d, lessThan(10200));
    });

    test('pole to pole is approximately 20,000 km', () {
      final d = distanceKm(90, 0, -90, 0);
      expect(d, greaterThan(19000));
      expect(d, lessThan(21000));
    });

    test('returns positive for distinct points', () {
      expect(distanceKm(0, 0, 10, 10), greaterThan(0));
    });
  });
}
