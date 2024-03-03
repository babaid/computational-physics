### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 61f868a6-8ebd-11ee-0026-d3226f597d4e
begin
	using Pkg;
	Pkg.activate(".")
	using CairoMakie, LinearAlgebra, PlutoUI
end

# ╔═╡ 95157c1c-a777-41fa-9133-ef0c19b24e03
md"""
# Lagrange interpolation
"""

# ╔═╡ f8490e24-1b47-4357-92a6-fc3459d1a32f
function λ(i, x, roots)
	n = length(roots)
	out = 1
	for j in 1:n
		if j!=i
			out*=(x-roots[j])/(roots[i]-roots[j])
		end
	end
	return out
end

# ╔═╡ 83789126-1004-4eab-89bd-80c7239d3b04
function lagrange_polynomial(x, xs, ys)
	n = length(xs)
	out = 0	
	for i in 1:n
		out+=ys[i]*λ(i, x,  xs)
	end
	return out
end

# ╔═╡ 604e3ff5-2f84-4022-8133-ee0da69b1768
md""" 
# Piecewise linear interpolation
"""

# ╔═╡ 44b76055-e7b2-4abc-835e-cb5d5bab92ce
function find_interval(x, xs)
	#given list of x's it finds for an x the index which is right below x
	dist = argmin(floor.(abs.(xs.-x)))
	if xs[dist] >= length(xs)
		return dist-1
	end
	return dist
end

# ╔═╡ 9c5fcde5-848b-4171-a6cf-f1ffc431a5bc
function piecewise_linear(x, xs, ys)

	
	if x == xs[end]
		return ys[end]
	end

	#have to find right interval for x
	j = find_interval(x, xs)

	#per definition
	A = (xs[j+1]-x)/(xs[j+1]-xs[j])
	B = (x-xs[j])/(xs[j+1]-xs[j])
	
	return A*ys[j]+B*ys[j+1]
end

# ╔═╡ 90d0a4b3-d393-474b-8ccc-d97af38facb1
md"""
# Cubic splines
"""

# ╔═╡ dddf6439-fc8c-472b-b5c7-16eb1d0e100a
function cubic_interpolation(x, xs, ys)

	
	#last point has some problems if not returned so lets do it.
	if x == xs[end]
		return ys[end]
	end
	
	#convenience
	n = length(xs)

	#construction of system of equations
	a = [(xs[j]-xs[j-1])/6 for j in 2:(n-2)]
	b = [(xs[j+1]-xs[j-1])/3 for j in 2:(n-1)]
	c = [(xs[j+1]-xs[j])/6 for j in 2:(n-2)]

	
	yy = [(ys[j+1]-ys[j])/(xs[j+1]-xs[j]) - (ys[j]-ys[j-1])/(xs[j]-xs[j-1]) for j in 
	2:(n-1)]

	#construct matrix
	m = diagm(0=>b, 1=>a,-1=>c)
	
	#solve system of equations
	dy = m\yy

	#I chose natural boundaries which means y''_1(x) = y''_N(x)=0
	#so now we pad the solution with zeros:
	dy2 = zeros(n)
	dy2[2:n-1] =dy
	

	#find in which interval x is.
	j = find_interval(x, xs)


	#Calculate the coefficients as per definition
	A = (xs[j+1]-x)/(xs[j+1]-xs[j])
	B = (x-xs[j])/(xs[j+1]-xs[j])
	D=((B^3-B)*(xs[j+1]-xs[j])^2)/6
	C = ((A^3-A)*(xs[j+1]-xs[j])^2)/6

	#done :))
	return A*ys[j]+B*ys[j+1]+C*dy2[j]+D*dy2[j+1]
end


# ╔═╡ 6049e74f-4633-4244-938b-d26bad1545f3
md"""
So lets compare the three different types of interpolation. First we define some variables.
x_min:

$(@bind x_min PlutoUI.Slider(-15:1:14, show_value=true, default=0))

x_max: 	

$(@bind x_max PlutoUI.Slider(0:1:15, show_value=true, default=15))
"""

# ╔═╡ d8e63bc9-e40e-481d-b6db-22d599af8740
begin
	#dataset to interpolate
	xs = collect(x_min:1:x_max)
	ys = sin.(xs) ./cosh.(xs) .- exp.(-xs).*sin.(xs)
	#σ*rand(length(xs)).^5

	#continous xs for plotting the final interpolations
	ixs = collect(x_min:0.01:x_max)

	#solutions
	lg_ys = [lagrange_polynomial(el, xs, ys) for el in ixs]
	lin_pw = [piecewise_linear(x, xs, ys) for x in ixs]
	cub_pw = [cubic_interpolation(x, xs, ys) for x in ixs]
end


# ╔═╡ ad3bbe94-1bdf-4d35-8c2e-ae18863d2b05
begin
	
	fig=Figure()
	ax=Axis(fig[1, 1])
	scatter!(ax, xs, ys)
	l1 = lines!(ixs,  lg_ys)
	l2 = lines!(ixs, lin_pw)
	l3 = lines!(ixs, cub_pw)
	#ylims!(ax, (-10, 10))
	Legend(fig[1, 1], [l1, l2, l3], ["Lagrange interpolation", "Piecewise Linear Interpolation", "Cubic splines"], tellheight=false, tellwidth=false, halign=:left, valign=:top, margin=(10, 10, 10, 10))
	fig
end

# ╔═╡ f9c57fba-3ae2-4c7b-b1d9-58e8b102f3fe
md"""
Playing around a while you can se the weaknesses and strengths of these methods.
The piecewise linear function has discontinuities at the points it interpolates in between for example. 
The Lagrange interpolation works well for actual polynomials or for a few points, but as we go further away from the origin, it tends to diverge more and more between points.
The best method is obviously the cubic splines interpolation where we made sure that the function will be smooth, and do not go further than the 3rd power in x.
"""


# ╔═╡ Cell order:
# ╠═61f868a6-8ebd-11ee-0026-d3226f597d4e
# ╟─95157c1c-a777-41fa-9133-ef0c19b24e03
# ╠═f8490e24-1b47-4357-92a6-fc3459d1a32f
# ╠═83789126-1004-4eab-89bd-80c7239d3b04
# ╟─604e3ff5-2f84-4022-8133-ee0da69b1768
# ╠═44b76055-e7b2-4abc-835e-cb5d5bab92ce
# ╠═9c5fcde5-848b-4171-a6cf-f1ffc431a5bc
# ╟─90d0a4b3-d393-474b-8ccc-d97af38facb1
# ╠═dddf6439-fc8c-472b-b5c7-16eb1d0e100a
# ╟─6049e74f-4633-4244-938b-d26bad1545f3
# ╠═d8e63bc9-e40e-481d-b6db-22d599af8740
# ╟─ad3bbe94-1bdf-4d35-8c2e-ae18863d2b05
# ╟─f9c57fba-3ae2-4c7b-b1d9-58e8b102f3fe
