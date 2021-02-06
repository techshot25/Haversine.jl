module Haversine

R = 6.371e6 # earth's average radius in meters


function HaversineDistance(p1, p2)
    """Get the haversine distance between two points

    Parameters
    ----------
    p1 : Array-like[Float]
        First point in degrees (lon, lat)
    p2 : Array-like[Float]
        Second point in degrees (lon, lat)

    Returns
    -------
    Float
        Haversine distance between points
    """
    (λ1, ϕ1), (λ2, ϕ2) = p1, p2
    Δϕ = ϕ2 - ϕ1
    Δλ = λ2 - λ1
    a = sind(Δϕ / 2)^2 + cosd(ϕ1) * cosd(ϕ2) * sind(Δλ / 2)^2
    c = 2 * atan(sqrt(a), sqrt(1 - a))
    return c * R
end


function HaversineBearing(p1, p2)
    """Find the heading from point 1 to point 2
    
    Parameters
    ----------
    p1 : Array-like[Float]
        First point coordinates in degrees (lon, lat)
    p2 : Array-like[Float]
        Second point coordinates in degrees (lon, lat)

    Returns
    -------
    Float
        The heading in degrees
    """
    (λ1, ϕ1), (λ2, ϕ2) = p1, p2
    Δϕ = ϕ2 - ϕ1
    Δλ = λ2 - λ1
    θ = atand(sind(Δλ) * cosd(ϕ2), cosd(ϕ1) * sind(ϕ2) - sind(ϕ1) * cosd(ϕ2) * cosd(Δλ))
    return θ
end


function HaversineDestination(p, θ, d)
    """Find the destination coordinates given a starting point
    
    Parameters
    ----------
    p : Array-like[Float]
        Initial coordinates in degrees (lon, lat)
    θ : Float
        Heading in degrees
    d : Float
        Distance in meters

    Returns
    -------
    Array[Float, Float]
        The destination point coordinates in degrees
    """
    λ1, ϕ1 = p
    δ = d / R
    ϕ2 = asind(sind(ϕ1) * cos(δ) + cosd(ϕ1) * sin(δ) * cosd(θ))
    λ2 = λ1 + atand(sind(θ) * sin(δ) * cosd(ϕ1), cos(δ) - sind(ϕ1) * sind(ϕ2))
    return [λ2, ϕ2]
end

export HaversineDistance
export HaversineBearing
export HaversineDestination

end
