# Haversine

[![Build Status](https://travis-ci.com/techshot25/Haversine.svg?branch=master)](https://travis-ci.com/techshot25/Haversine)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/techshot25/Haversine?svg=true)](https://ci.appveyor.com/project/techshot25/Haversine)
[![Coverage](https://codecov.io/gh/techshot25/Haversine/branch/master/graph/badge.svg)](https://codecov.io/gh/techshot25/Haversine)
[![Coverage](https://coveralls.io/repos/github/techshot25/Haversine/badge.svg?branch=master)](https://coveralls.io/github/techshot25/Haversine?branch=master)

Haversine (Great Circle) distance tools for Julia

There are a few functions here to help

### HaversineDistance
This uses the great circle distance to find the approximate distance between two coordinates assuming a perfectly spherical earth

```julia
using Haversine

p1 = [1, 2] # (lon, lat) in degrees
p2 = [3, 4]

# returns distance in meters
HaversineDistance(p1, p2)
>>> 314283.25507368386
```

### HaversineBearing
This returns the bearing/heading between from point 1 to point 2 in degrees

```julia
using Haversine

p1 = [1, 2] # (lon, lat) in degrees
p2 = [3, 4]

# returns heading in degrees
HaversineBearing(p1, p2)
>>> 44.91272645906142
```

### HaversineDestination
Given a point, bearing, and distance, show the coordinates of the final destination

```julia
using Haversine

p = [1, 2] # (lon, lat) in degrees
theta = 30 # heading in degrees
d = 2 # distance in meters

# returns destination coordinates as Array[lon, lat]
HaversineDestination([1, 2], 30, 2)
>>> 2-element Array{Float64,1}:
>>> 1.0000089986979082
>>> 2.000015576707113
```
