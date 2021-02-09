using Haversine
using Test

# constants for single value test
single_p1, single_p2 = [1, 2], [9, 1]
single_θ = 45
p = [5, 4]
d = 900000


distance = 896167.96
bearing = 97.01
destination = [10.80, 9.69]

# constants for broadcasting test
p1 = [[1, 2], [3, 4], [0, 9]]
p2 = [[5, 1], [0, 9], [12, 4]]
θ = [30, 60]

distances = [458315.02, 647215.42, 1.44e6]
bearings = [103.98, -30.645, 111.99]
destinations = [[9.11, 10.99], [12.07, 8.01]]

@testset "Haversine.jl" begin
    @test isapprox(HaversineDistance(single_p1, single_p2), distance, rtol=0.01)
    @test isapprox(HaversineBearing(single_p1, single_p2), bearing, rtol=0.01)
    @test isapprox(HaversineDestination(p, single_θ, d), destination, rtol=0.01)

    @test isapprox(HaversineDistance(p1, p2), distances, rtol=0.01)
    @test isapprox(HaversineBearing(p1, p2), bearings, rtol=0.01)
    @test isapprox(HaversineDestination(p, θ, d), destinations, rtol=0.01)
end
