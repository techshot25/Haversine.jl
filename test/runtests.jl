using Haversine
using Test

@testset "Haversine.jl" begin
    @test HaversineDistance([1, 2], [3, 4]) == 314283.25507368386
    @test HaversineBearing([1, 2], [3, 4]) == 44.91272645906142
    @test HaversineDestination([1, 2], 30, 2) == [1.0000089986979082, 2.000015576707113]
end
