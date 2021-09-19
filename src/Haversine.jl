module Haversine

R = 6.371e6 # earth's volumetric mean radius in meters


struct GeoLocation
    ϕ::Real
    λ::Real
end


function BaseHaversineDistance(λ1::Number, ϕ1::Number, λ2::Number, ϕ2::Number)::Float64
    # Elementwise implementation of HaversineDistance
    Δϕ = ϕ2 - ϕ1
    Δλ = λ2 - λ1
    a = sind(Δϕ / 2)^2 + cosd(ϕ1) * cosd(ϕ2) * sind(Δλ / 2)^2
    c = 2 * atan(sqrt(a), sqrt(1 - a))
    return c * R
end


function BaseHaversineBearing(λ1::Number, ϕ1::Number, λ2::Number, ϕ2::Number)::Float64
    # Elementwise implementation of HaversineBearing
    Δϕ = ϕ2 - ϕ1
    Δλ = λ2 - λ1
    θ = atand(sind(Δλ) * cosd(ϕ2), cosd(ϕ1) * sind(ϕ2) - sind(ϕ1) * cosd(ϕ2) * cosd(Δλ))
    return θ
end


function BaseHaversineDestination(λ1::Number, ϕ1::Number, θ::Number, d::Number)::Array{Float64}
    # Elementwise implementation of HaversineDestination
    δ = d / R
    ϕ2 = asind(sind(ϕ1) * cos(δ) + cosd(ϕ1) * sin(δ) * cosd(θ))
    λ2 = λ1 + atand(sind(θ) * sin(δ) * cosd(ϕ1), cos(δ) - sind(ϕ1) * sind(ϕ2))
    return [λ2, ϕ2]
end


function HaversineDistance(p1, p2)
    #=
    Get the haversine distance between two points

    Parameters
    ----------
    p1 : Array-like[Number] or nested array of multiple points
        First point in degrees (lon, lat)
    p2 : Array-like[Number] or nested array of multiple points
        Second point in degrees (lon, lat)

    Returns
    -------
    Float64 or Array{Float64}
        Haversine distance between points in meters
    =#
    p1, p2 = reduce(hcat, p1), reduce(hcat, p2)
    if size(p1)[1] == 1
        (λ1, ϕ1), (λ2, ϕ2) = p1, p2
    else
        (λ1, ϕ1), (λ2, ϕ2) = (p1[1, :], p1[2, :]), (p2[1, :], p2[2, :])
    end
    return broadcast((λ1, ϕ1, λ2, ϕ2) -> BaseHaversineDistance(λ1, ϕ1, λ2, ϕ2), λ1, ϕ1, λ2, ϕ2)
end


function HaversineDistance(p1::AbstractArray{GeoLocation}, p2::AbstractArray{GeoLocation})::AbstractArray{Float64}
    (λ1, ϕ1), (λ2, ϕ2) = transpose([[x.λ, x.ϕ] for x in p1]), transpose([[x.λ, x.ϕ] for x in p2])
    return broadcast((λ1, ϕ1, λ2, ϕ2) -> BaseHaversineDistance(λ1, ϕ1, λ2, ϕ2), λ1, ϕ1, λ2, ϕ2)
end


function HaversineBearing(p1, p2)
    #=
    Find the heading from point 1 to point 2
    
    Parameters
    ----------
    p1 : Array-like[Number] or nested array of multiple points
        First point coordinates in degrees (lon, lat)
    p2 : Array-like[Number] or nested array of multiple points
        Second point coordinates in degrees (lon, lat)

    Returns
    -------
    Float64 or Array{Float64}
        The heading in degrees
    =#
    p1, p2 = reduce(hcat, p1), reduce(hcat, p2)
    if size(p1)[1] == 1
        (λ1, ϕ1), (λ2, ϕ2) = p1, p2
    else
        (λ1, ϕ1), (λ2, ϕ2) = (p1[1, :], p1[2, :]), (p2[1, :], p2[2, :])
    end
    return broadcast((λ1, ϕ1, λ2, ϕ2) -> BaseHaversineBearing(λ1, ϕ1, λ2, ϕ2), λ1, ϕ1, λ2, ϕ2)
end


function HaversineBearing(p1::AbstractArray{GeoLocation}, p2::AbstractArray{GeoLocation})::AbstractArray{Float64}
    (λ1, ϕ1), (λ2, ϕ2) = transpose([[x.λ, x.ϕ] for x in p1]), transpose([[x.λ, x.ϕ] for x in p2])
    return broadcast((λ1, ϕ1, λ2, ϕ2) -> BaseHaversineBearing(λ1, ϕ1, λ2, ϕ2), λ1, ϕ1, λ2, ϕ2)
end


function HaversineDestination(p, θ, d)
    #=
    Find the destination coordinates given a starting point
    
    Parameters
    ----------
    p : Array-like[Number] or nested array of multiple points
        Initial coordinates in degrees (lon, lat)
    θ : Number or Array-like{Number}
        Heading in degrees
    d : Number or Array-like{Number}
        Distance in meters

    Returns
    -------
    Array[Float, Float]
        The destination point coordinates in degrees
    =#
    p = reduce(hcat, p)
    if size(p)[1] == 1
        λ1, ϕ1 = p
    else
        λ1, ϕ1 = p[1, :], p[2, :]
    end
    return broadcast((λ1, ϕ1, θ, d) -> BaseHaversineDestination(λ1, ϕ1, θ, d), λ1, ϕ1, θ, d)
end


function HaversineDestination(p::AbstractArray{GeoLocation}, θ, d)::Vector{Float64}
    λ1, ϕ1 = transpose([[x.λ, x.ϕ] for x in p])
    return copy(broadcast((λ1, ϕ1, θ, d) -> BaseHaversineDestination(λ1, ϕ1, θ, d), λ1, ϕ1, θ, d))
end

export GeoLocation, HaversineDistance, HaversineBearing, HaversineDestination

end
