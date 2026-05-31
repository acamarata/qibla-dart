# Security

## Scope

`qibla` is a pure-math library with no network access, no file I/O, and no external dependencies. The attack surface is limited to the mathematical functions themselves.

The main concern is input validation: `qiblaAngle` and `qiblaGreatCircle` throw `RangeError` on out-of-bounds coordinates. If you pass untrusted input to these functions, catch the error.

## Reporting a Vulnerability

If you discover a security issue (for example, a case where malformed input causes unexpected behavior beyond the documented `RangeError`), please report it privately before filing a public issue.

**Contact:** alisalaah@gmail.com

Include:

1. A description of the vulnerability
2. Steps to reproduce it
3. The version of `qibla` where you observed the issue
4. Any suggested fix if you have one

You can expect an acknowledgment within 48 hours and a resolution or status update within 7 days.

## Known Limitations

- `distanceKm` uses a spherical Earth model (R = 6,371 km). It does not account for Earth's ellipsoidal shape. For high-precision geodesy, use a WGS-84 library.
- Ka'bah coordinates are fixed constants. They will not change unless there is a documented scholarly correction to the GPS position.
