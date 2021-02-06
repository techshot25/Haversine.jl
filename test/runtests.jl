using Haversine
using Test

@testset "Haversine.jl" begin
    @test HaversineDistance([1, 2], [3, 4]) == 314283.25507368386
end
