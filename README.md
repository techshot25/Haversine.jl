# Haversine.jl

[![Build status](https://ci.appveyor.com/api/projects/status/r28nu7ghasrwgwcj?svg=true)](https://ci.appveyor.com/project/techshot25/haversine-jl)
[![codecov](https://codecov.io/gh/techshot25/Haversine.jl/branch/master/graph/badge.svg?token=W0VM6KD0CW)](https://codecov.io/gh/techshot25/Haversine.jl)

---

Haversine (Great Circle) distance tools for Julia

This project contains helper geospatial tools using Haversine which assume a perfectly spherical earth to compute special geospatial functions. All the functions included are using pairwise distance and will require mapping to work on arrays. Contributions are welcome, submit a PR and I will review it as soon as I can.

### HaversineDistance
This uses the great circle distance to find the approximate distance between two coordinates assuming a perfectly spherical earth

```julia
using Haversine



p1 = GeoLocation(lon=1, lat=2)
p2 = GeoLocation(3, 4) # (lon, lat) in degrees

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
θ = 30 # heading in degrees
d = 2 # distance in meters

# returns destination coordinates as Array[lon, lat]
HaversineDestination(p, θ, d)
>>> 2-element Array{Float64,1}:
>>>  1.0000089986979082
>>>  2.000015576707113
```

### Broadcasting
All functions as of version 1.0.0 can now support broadcasting. Arguments can broadcast to support array-like inputs

```julia
using Haversine

p = [5, 4] # initial location
θ = [30, 60] # multiple headings
d = [10, 900000] # destination for each heading

HaversineDestination(p, θ, d)
>>> 2-element Array{Array{Float64,1},1}:
>>>  [5.000045075887166, 4.0000778835344555]
>>>  [12.072951161820168, 8.006647216172182]
```

```julia
using Haversine

p1 = [[1, 2], [3, 4]] # multiple points
p2 = [[5, 1], [0, 9]]

HaversineBearing(p1, p2)
>>> 2-element Array{Float64,1}:
>>>  126.81261556373533
>>>  -11.186184406292147
```
