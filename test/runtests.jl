using Haversine
using Test

# constants for single value test
single_p1, single_p2 = GeoLocation(1, 2), GeoLocation(9, 1)
single_θ = 45
p = GeoLocation(5, 4)
d = 900000


distance = 896167.96
bearing = 97.01
destination = [10.80, 9.69]

# constants for broadcasting test
p1 = [GeoLocation(1, 2), GeoLocation(3, 4), GeoLocation(0, 9)]
p2 = [GeoLocation(5, 1), GeoLocation(0, 9), GeoLocation(12, 4)]
θ = [30, 60]

geo_p1 = [GeoLocation(1, 2), GeoLocation(3, 4), GeoLocation(0, 9)]
geo_p2 = [GeoLocation(5, 1), GeoLocation(0, 9), GeoLocation(12, 4)]

distances = [458315.02, 647215.42, 1.44e6]
bearings = [103.98, -30.645, 111.99]
destinations = [[8.85, 0.032], [-1.19, 10.95], [7.54, 5.90]]

computed_geo_dest = HaversineDestination(p, single_θ, d)
computed_dest = [computed_geo_dest.λ, computed_geo_dest.ϕ]
computed_dests = [[x.λ, x.ϕ] for x in HaversineDestination(geo_p1, bearings, d)]

println(computed_dests)

@testset "Haversine.jl" begin
    @test isapprox(HaversineDistance(single_p1, single_p2), distance, rtol=0.01)
    @test isapprox(HaversineBearing(single_p1, single_p2), bearing, rtol=0.01)
    @test isapprox(computed_dest, destination, rtol=0.01)

    @test isapprox(HaversineDistance(p1, p2), distances, rtol=0.01)
    @test isapprox(HaversineBearing(p1, p2), bearings, rtol=0.01)
    @test isapprox(computed_dests, destinations, rtol=0.01)

    @test isapprox(HaversineDistance(geo_p1, geo_p2), distances, rtol=0.01)
    @test isapprox(HaversineBearing(geo_p1, geo_p2), bearings, rtol=0.01)
end
