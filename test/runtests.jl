using Haversine
using Test

p1 = [[1, 2], [3, 4]]
p2 = [[5, 1], [0, 9]]

p = [5, 4]

θ = [30, 60]
d = 900000

distances = [555811.94, 566838.25]
bearings = [126.81, -11.18]
destinations = [[9.1, 11.0], [12.1, 8]]

@testset "Haversine.jl" begin
    @test isapprox(HaversineDistance(p1, p2), distances, rtol=0.01)
    @test isapprox(HaversineBearing(p1, p2), bearings, rtol=0.01)
    @test isapprox(HaversineDestination(p, θ, d), destinations, rtol=0.01)
end
