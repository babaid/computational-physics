### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ f00d9f7c-71f5-408a-95e0-94a4b53b4a33
begin
	#IMPORTS
	using Pkg
	Pkg.activate(".")
	using LinearAlgebra, PlutoLinks
end

# ╔═╡ 0ee1bb61-f6c4-46d5-845c-8f86c19da78f
@revise using DN

# ╔═╡ 77fd771a-9465-11ee-0c91-3b65886afe5a
md"""

# Root finding

Assuming we have a good guess for where the root of a function could be, we can use the newton-raphson algorithm to iteratively find the root. Let us expand a function close to the root:
$f(x_0+\Delta x) \approx  f(x_0) + \frac{df}{dx} |_{x_0} \cdot \Delta x$ = 0

Using this equation we can approximate $\Delta x$, and iteratively find our root:

$\Delta x = - f(x_0)/\frac{df}{dx} |_{x_0}$

I will provide both a numerical approach and an exact using automatic differentiation
"""

# ╔═╡ f5bae59b-ebcc-48e7-9715-28dd089f71b5
md"""
# Multidimensional Newton Raphson
You can do the same in more dimensions. But instead of $\frac{df}{dx}$ you have to calculate the jacobian and invert it.
"""

# ╔═╡ 1595c70d-38c0-4be9-bb34-f5f83183964f
function CartesianUnitVector(i, dim)
	v = zeros(dim)
	v[i] = 1.
	return v
end

# ╔═╡ 83c5cae2-06dc-4715-bf0b-e68ac00bf11c
function jacobian(f, xs, dim=1)
        #f is a scalar valued function
        #xs is a vector of the input x's
        #ps are the parameters
        # f(x_i)
	    dxs = [Dual(x, CartesianUnitVector(i, dim)) for (i, x) in enumerate(xs)]	
		y = f(dxs)
		j = [x.y for x in y]
	
        return reduce(hcat, j)
end

# ╔═╡ b0c1a729-8617-4cb0-afb9-d0f12b0d0334
function NewtonRaphson(f, x_0, tol=1e-3, max_iters=1000)
	x = 0.
	iters = 0
	while (abs(f(x_0)-x) > tol) && (iters<max_iters)
		y = f(x_0)
		x_0=x
		x -= y/jacobian(f, [x_0])[1]

		iters+=1
	end
	return x
end

# ╔═╡ d210832b-2319-43da-adbd-f68e84d1e1ed
function Base.inv(x::Vector{Float64})
	if length(x) == 1
		return 1 ./ x
	end
end

# ╔═╡ a3f9ba7e-1f77-4ba6-9115-0bea29a28d10
function MultidimNewtonRaphson(f, x₀, tol=1e-3,max_iters=1e3)
	n = length(x₀)
	x = zeros(n)
	iters = 0
	#do this until convergence or maximal number of iters
	while (sum((f(x₀).-f(x)).^2) > tol) && (iters<max_iters)

		x₀=x
		y = f(x₀)
		
		#step towards root
		x .-= inv(jacobian(f, x₀, n))'y
		iters+=1
		
	end
	println("It took $iters")
	return x
end


# ╔═╡ 31679461-c0c4-4bf6-b1e8-fab11b461654
f(x) = [sin(x[1]), cos(x[1])+x[2], exp(x[3])+x[1]]

# ╔═╡ efa90f4d-564d-4cce-b390-06f9bd13ac03
s = MultidimNewtonRaphson(f, [0.5, 0.5, 0.5], 1e-2, 10)

# ╔═╡ 61df9e6b-f366-4768-9f5b-1075557cb57a
sqrt(2)

# ╔═╡ 00f2e0d3-f24b-4bbc-8762-e681a943bb21
inv([1.2])

# ╔═╡ Cell order:
# ╟─77fd771a-9465-11ee-0c91-3b65886afe5a
# ╠═f00d9f7c-71f5-408a-95e0-94a4b53b4a33
# ╠═0ee1bb61-f6c4-46d5-845c-8f86c19da78f
# ╠═83c5cae2-06dc-4715-bf0b-e68ac00bf11c
# ╠═b0c1a729-8617-4cb0-afb9-d0f12b0d0334
# ╟─f5bae59b-ebcc-48e7-9715-28dd089f71b5
# ╠═1595c70d-38c0-4be9-bb34-f5f83183964f
# ╠═d210832b-2319-43da-adbd-f68e84d1e1ed
# ╠═a3f9ba7e-1f77-4ba6-9115-0bea29a28d10
# ╠═31679461-c0c4-4bf6-b1e8-fab11b461654
# ╠═efa90f4d-564d-4cce-b390-06f9bd13ac03
# ╠═61df9e6b-f366-4768-9f5b-1075557cb57a
# ╠═00f2e0d3-f24b-4bbc-8762-e681a943bb21
