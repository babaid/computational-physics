module DN	
	export Dual

	mutable struct Dual{T} <: Number
		x::T
		y::Union{Vector{T}, T}
	end

	Dual(x::Float64) = Dual{Float64}(x, 0.0)

	Base.:+(x::Dual, y::Dual) = Dual(x.x+y.x, x.y.+y.y)
	Base.:+(x::Dual, s::Union{Real, Float64, Int64}) = Dual(x.x.+s, x.y)
	Base.:+(s::Union{Real, Float64, Int64}, x::Dual) = Dual(s.+x.x, x.y)


	Base.:-(x::Dual, y::Dual) = Dual(x.x-y.x, x.y .-y.y)
	Base.:-(x::Dual, s::Union{Real, Float64, Int64}) = Dual(x.x.-s, x.y)
	Base.:-(s::Union{Real, Float64, Int64}, x::Dual) = Dual(s.-x.x, -x.y)
	Base.:-(x::Dual) = Dual(-x.x, -x.y)



	Base.:*(x::Dual, y::Dual) = Dual(x.x*y.x, x.x .* y.y .+ x.y .* y.x)
	Base.:*(x::Dual, s::Union{Float64, Int64}) = Dual(x.x*s, x.y*s)
	Base.:*(s::Union{Float64, Int64}, a::Dual) = Dual(a.x*s, a.y*s)




	Base.:/(x::Dual, y::Dual) = Dual(x.x/y.x, (x.y .+ y.x .- x.x .*y.y) ./ y.x^2)
	Base.:/(a::Dual, s) = a*(1/s)
	Base.:/(s, a::Dual) = Dual(s/a.x,  -s .*a.y ./ a.x^2)


	Base.:^(x::Dual, s::Union{Float64, Int64}) = Dual(x.x^s, s*x.y*x.x^(s-1))	
	Base.:^(x::Dual, s::Union{Float64, Int64}) = Dual(x.x^s, s*x.y*x.x^(s-1))
	Base.:^(s::Real, x::Dual) = Dual(s^x.x, x.y*s^x.x*log(s))


	Base.:exp(x::Dual) = Dual(exp(x.x), exp(x.x).*x.y)
	Base.:sin(x::Dual) = Dual(sin(x.x), cos(x.x).*x.y)
	Base.:cos(x::Dual) = Dual(cos(x.x), -sin(x.x).*x.y)
	Base.:tan(x::Dual) = Dual(tan(x.x), sec(x.x)^2*x.y)

	Base.:sinh(x::Dual) = Dual(sinh(x.x), cosh(x.x).*x.y)
	Base.:cosh(x::Dual) = Dual(cosh(x.x), -sinh(x.x).*x.y)
	Base.:tanh(x::Dual) = Dual(tanh(x.x), sech(x.x)^2*x.y)
	

end;
