### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 28a29206-969d-11ee-20ca-97650e62d1fa
begin
	using Pkg
	Pkg.activate(".")
	using LinearAlgebra, PlutoLinks, CairoMakie;
end

# ╔═╡ 25703985-ba7f-407a-9d03-bb59f619f7f7
PlutoLinks.@revise using DN

# ╔═╡ 952168ce-c1fc-49e4-8fff-27ae5da00a81
md"""
# Nonlinear Least Squares

We want to minimize 

$S(\beta+\delta) \approx || \vec{y} - \vec{f}(\beta) - \mathbf{J}\vec{\delta}||^2$

The solution of the problem after approximation in $\delta$ is given as follows:

$\delta = [\mathbf{J}^T\mathbf{J}]^{-1}\mathbf{J}\cdot[\vec{y}-\vec{f}(\vec{\beta})]$

We iteratively have to calculate $\delta$ and add it to $\beta$, the program should do this either until $\beta+\delta$ converges or the number of iterations exceed maximum that we allow.

This algorithm is similar to the newton-raphson rootfinding algorithm but it is more stable. If the initial guess of parameters is good, it can find a global minimum, else it will converge to a local one.

"""

# ╔═╡ 1882bccc-a153-40dc-9954-4ca2bdddfd3a
#for testing lets define some parameters that are "supposedly true"
true_params = [0.1, 0.1, 0.5, 1.2, pi]

# ╔═╡ e86eabc3-c10a-47ab-9e9e-065f2fcb0d32
#the function we try to fit
f(x, p) = x.*p[1] .+ exp.(-p[2]*x).+p[3] .+ exp.(-p[4]*x.^2).*sin.(-p[5]*x)

# ╔═╡ 027e3c1a-042f-4909-9553-25e7438241e3
begin
	xs = collect(0:0.1:2)
	ys = f(xs, true_params)
end

# ╔═╡ 6836d19c-7613-4ff3-a215-58cebb8e558d
function jacobian(f, xs, ps)
	#f is a scalar valued function
	#xs is a vector of the input x's
	#ps are the parameters
	# f(x_i, \vec{p})
	ps = Dual.(ps, 0.0)
	j = []
	for p in ps
		#derive at p
		p.y = 1.0
		col = f(xs, ps)
		#switch off derivation
		p.y = 0.0
		#only save derivatives
		push!(j, map(x->x.y, col))
	end
	return reduce(hcat, j)
end

# ╔═╡ 5632dda1-389a-443d-9377-cfd356a5fa4e
function LevenbergMarquard(f, xs, ys, p0, damping=0.0, eps=1e-1, n_max_iters=1e2)
	n_iters=0
	p=p0.*0.0
	while (abs((sum((p.-p0).^2))) > eps) && (n_iters < n_max_iters)
		J = jacobian(f, xs, p0)
		p = p0
		dp = inv(J'J .+ damping*I(length(p0))) *J'*(ys .- f(xs, p0))
		p0 = p+dp
		n_iters+=1
	end
	println("Needed $n_iters iterations")
	return p
end

# ╔═╡ 9dbed795-a76c-4a06-ad17-f61154ad29cf
begin
	#try to play around with the intial parameters to see how it affects if there is a solution. The most problems will arise when the damping is 0.
	p0 = ones(5)*0.5
	p0[4] = 0.5
	p0[5] = 0.5
end

# ╔═╡ 83896803-6d5b-48cc-b302-e925b79b4ca0
params = LevenbergMarquard(f, xs, ys, p0, 10, 1e-6, 1e3)

# ╔═╡ a56be66f-f599-46bb-a115-ef4ea55a94b8
begin
	pltxs = 0.0:0.01:2
	fig=Figure()
	ax = Axis(fig[1, 1])
	
	
	l2 = lines!(ax, pltxs, f(pltxs, true_params), color=:blue, linewidth=15, alpha=0.3)
	l1 = lines!(ax, pltxs, f(pltxs, params), color=:red)
	sc = scatter!(ax, xs, ys, marker=:x, color=:black, markersize=20, strokewidth=1)
	
	Legend(fig[1, 1], [sc, l1, l2], ["Measurements", "Nonlinear fit", "Original function"], tellheight=false, tellwidth=false, halign=:right, valign=:bottom, margin=(10, 10, 10, 10))
	fig
end

# ╔═╡ Cell order:
# ╠═28a29206-969d-11ee-20ca-97650e62d1fa
# ╠═25703985-ba7f-407a-9d03-bb59f619f7f7
# ╟─952168ce-c1fc-49e4-8fff-27ae5da00a81
# ╠═1882bccc-a153-40dc-9954-4ca2bdddfd3a
# ╠═e86eabc3-c10a-47ab-9e9e-065f2fcb0d32
# ╠═027e3c1a-042f-4909-9553-25e7438241e3
# ╠═6836d19c-7613-4ff3-a215-58cebb8e558d
# ╠═5632dda1-389a-443d-9377-cfd356a5fa4e
# ╠═9dbed795-a76c-4a06-ad17-f61154ad29cf
# ╠═83896803-6d5b-48cc-b302-e925b79b4ca0
# ╠═a56be66f-f599-46bb-a115-ef4ea55a94b8
