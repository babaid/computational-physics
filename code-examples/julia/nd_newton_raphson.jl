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

# ╔═╡ fad8a2ea-8b96-11ee-041b-b95f2617623c
begin
	using Pkg;
	Pkg.activate(".")
	using LinearAlgebra, CairoMakie, Symbolics, PlutoUI
end

# ╔═╡ ad881d2b-54cb-4c65-b3c1-f1fbfb52bf58
function jacobian_col(f::Function, x, i, Δx=1e-3)
	#Calculates one column of the jacobian of f
	h = zeros(size(x))
	h[i] = Δx
	central = (f(x.+h/2) .- f(x.-h/2))./Δx
	return central
end

# ╔═╡ db9b7e68-ab9c-4228-b673-a0d40ca6082e
function jacobian(f::Function, x)
	#calculates the jacobian of f at x
	mat = zeros(length(x), length(x))
	for i in 1:length(x)
		mat[:, i] = jacobian_col(f, x, i)
	end
	return mat
end

# ╔═╡ febbfc6b-aec6-4ae5-b1e6-55cde81430f2
f(x) = [(x[1]-1)^2, (x[2]-x[1])^2, x[3]^2-2*x[2]-1]

# ╔═╡ 92ac4c75-55c2-4cef-80aa-e3bc476a1a1d
function finders_keepers(f, x)
	#used to look if f has roots at x
	y = f(x)
	keep = []
	for i in 1:length(y)
		if(y[i]!=0)
			push!(keep, i)
		end
	end
	keep
end
	

# ╔═╡ 349dd102-dce2-4c19-932e-5a97e36917ee
function nd_newton_raphson(f::Function, x₀, tol=1e-2, maxiters=100)
	iters = 0
	x=zeros(length(x₀))
	err = sum((x.-x₀).^2)
	while (err>tol) && (iters < maxiters)
		#check if there is already a zero.
		#if there is already a root in the x values, the matrix will become singular at that point and we cant invert it.
		#To resolve this we remove the corresponding columns and rows.
		keep = finders_keepers(f, x₀)
		
		m = -jacobian(f, x₀)
		m = m[keep, keep]
		Δx = m\((f(x₀)[keep]))
		
		x[keep] = x₀[keep]
		x₀[keep] += Δx
		
		err = sum((x.-x₀).^2)
		iters+=1
	end
	return x₀, iters
end
	

# ╔═╡ 6d5c3c52-9cf9-44e9-87fb-ff019cabc679
nd_newton_raphson(f, [0.1, 12, 1.732]);

# ╔═╡ 91a5d293-434d-4784-9602-8c489a08b36d
g(x) = [sqrt(x[1])-cos(x[2]), sin(x[1])*log(x[3])-x[2]^2, 2*x[1]+4*x[3]^2-25]

# ╔═╡ fe287637-39ec-4f12-857b-4333213eb55f

md"""
	Initial guesses:    analytical value 
x: $(@bind x  PlutoUI.Slider(0:0.01:20, show_value=true, default=0.5))-------0.58\

y: $(@bind y  PlutoUI.Slider(0:0.01:20, show_value=true, default=0.5))-------0.701\

z: $(@bind z  PlutoUI.Slider(0:0.01:20, show_value=true, default=1.0))--------2.44\

"""


# ╔═╡ 16e7872c-1bdc-4a04-8ced-32ae62b654f9
roots, iters = nd_newton_raphson(g, [x, y, z]);

# ╔═╡ e63af777-2081-487a-889e-ffe363efae0a
println("Output of Newton Raphson:  The roots are at $((round.(roots, digits=5))), 
found them after $(iters) iterations.")

# ╔═╡ Cell order:
# ╠═fad8a2ea-8b96-11ee-041b-b95f2617623c
# ╟─ad881d2b-54cb-4c65-b3c1-f1fbfb52bf58
# ╟─db9b7e68-ab9c-4228-b673-a0d40ca6082e
# ╠═febbfc6b-aec6-4ae5-b1e6-55cde81430f2
# ╟─92ac4c75-55c2-4cef-80aa-e3bc476a1a1d
# ╠═349dd102-dce2-4c19-932e-5a97e36917ee
# ╠═6d5c3c52-9cf9-44e9-87fb-ff019cabc679
# ╠═91a5d293-434d-4784-9602-8c489a08b36d
# ╟─fe287637-39ec-4f12-857b-4333213eb55f
# ╟─16e7872c-1bdc-4a04-8ced-32ae62b654f9
# ╟─e63af777-2081-487a-889e-ffe363efae0a
