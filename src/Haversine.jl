module Haversine

using Parameters

R = 6.371e6 # earth's volumetric mean radius in meters


@with_kw struct GeoLocation
    λ::Real
    ϕ::Real
end




function HaversineDistance(p1::GeoLocation, p2::GeoLocation)
    λ1, ϕ1 = p1.λ, p1.ϕ
    λ2, ϕ2 = p2.λ, p2.ϕ
    Δϕ = ϕ2 - ϕ1
    Δλ = λ2 - λ1
    a = sind(Δϕ / 2)^2 + cosd(ϕ1) * cosd(ϕ2) * sind(Δλ / 2)^2
    c = 2 * atan(sqrt(a), sqrt(1 - a))
    return c * R   
end


function HaversineBearing(p1::GeoLocation, p2::GeoLocation)::Float64
    λ1, ϕ1 = p1.λ, p1.ϕ
    λ2, ϕ2 = p2.λ, p2.ϕ
    Δλ = λ2 - λ1
    θ = atand(sind(Δλ) * cosd(ϕ2), cosd(ϕ1) * sind(ϕ2) - sind(ϕ1) * cosd(ϕ2) * cosd(Δλ))
    return θ
end


function HaversineDestination(geopoint::GeoLocation, θ::Real, d::Real)::GeoLocation
    λ1, ϕ1 = geopoint.λ, geopoint.ϕ
    δ = d / R
    ϕ2 = asind(sind(ϕ1) * cos(δ) + cosd(ϕ1) * sin(δ) * cosd(θ))
    λ2 = λ1 + atand(sind(θ) * sin(δ) * cosd(ϕ1), cos(δ) - sind(ϕ1) * sind(ϕ2))
    return GeoLocation(λ=λ2, ϕ=ϕ2)
end


function HaversineDistance(p1::AbstractArray{GeoLocation}, p2::AbstractArray{GeoLocation})::AbstractArray{Float64}
    return map(HaversineDistance, p1, p2)
end


function HaversineBearing(p1::AbstractArray{GeoLocation}, p2::AbstractArray{GeoLocation})::AbstractArray{Float64}
    return map(HaversineBearing, p1, p2)
end

function HaversineDestination(
        p::AbstractArray{GeoLocation},
        θ::Union{AbstractArray, Real}, 
        d::Union{AbstractArray, Real}
    )::Vector{GeoLocation}
    return broadcast((x, y, z) -> HaversineDestination(x, y, z), p, θ, d)
end

export GeoLocation, HaversineDistance, HaversineBearing, HaversineDestination

end
