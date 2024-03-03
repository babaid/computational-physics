### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 20f3a618-128e-424b-9b71-9144cffb3a4b
begin
	using Pkg;
	Pkg.activate(".")
	using CairoMakie, LinearAlgebra, Roots;
end

# ╔═╡ 1170d0ea-2cc9-4bd9-81bc-b7469dfec898


# ╔═╡ 684dbaab-12f6-4c31-bc37-b7bc5fda8198
begin
	data1x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
	data1 = [6.11479, 9.5277, 11.7952, 15.4111, 19.7364, 20.0077, 22.1025, 24.0462,
	                        28.6927, 27.4651, 31.3269, 36.4622, 33.2896, 38.2032, 							50.0616, 45.8442,
	                        54.7994, 55.5591, 68.2607, 56.4829]
	datasigma1= [0.271828, 0.543656, 0.815485, 1.08731, 1.35914, 1.63097, 1.9028,
	                            2.17463, 2.44645, 2.71828, 2.99011, 3.26194, 3.53377, 							3.80559, 4.07742, 4.34925, 4.62108, 4.89291, 5.16474, 5.43656]
	data2x = [0,25,50,75,100,125,150,175,200]
	datay2 = [10.6,16.0,45.0,83.5,52.8,19.9,10.8,8.25,4.7]
	data2sigma=[9.34*0.25,17.9*0.25,41.5*0.25,85.5*0.25,51.5*0.25,21.5*0.25,10.8*0.25,6.29*0.25,4.09*0.25]
	end

# ╔═╡ 303e8a1b-3731-4535-a4c1-c7b0bb6e1501
f(x, p) = p[1] .+ p[2].*x

# ╔═╡ a05f6ecc-272a-493b-a7c3-78093695a351
begin 
	X = ones(length(data1x), 2)
	X[:, 2] = data1x
	X
end

# ╔═╡ 40da0174-37cc-49fc-9f6e-d3eb00e51579
sol = inv(X'X)X'data1

# ╔═╡ ceaea350-a9f2-449c-b964-4492fce93e48
begin
	fig = Figure()
	ax = Axis(fig[1, 1])
	xs = 0:0.1:20
	l1 = lines!(ax, xs, f(xs, sol))
	sc = scatter!(ax, data1x, data1)
	errorbars!(data1x, data1, datasigma1)
	leg = Legend(fig[1, 1], [l1], ["Linear Fit"], tellheight=false, tellwidth=false, halign=:left, valign=:top)
	fig
end

# ╔═╡ f13cc2f8-bfd5-412e-b98a-9016c62438e7
md"""
# Weighted least squares
We have the standard deviations of each point and now we do a better fit. 
"""

# ╔═╡ 3638b7be-b97e-4f24-a1d3-18af212fa44b
solweighted = inv(X'*diagm(0=>datasigma1.^2)*X)X'data1

# ╔═╡ fda78d62-0790-4b88-9a71-731c4f8f13d5


# ╔═╡ e0040c1f-3eb8-409d-abc0-b7f64eb91fbf
begin
	empty!(ax)
	delete!(leg)
	lines!(ax, xs, f(xs, sol))
	scatter!(ax, data1x, data1)
	errorbars!(data1x, data1, datasigma1)
	Legend(fig[1, 1], [l1], ["Linear Fit"], tellheight=false, tellwidth=false, halign=:left, valign=:bottom)
	fig
end

# ╔═╡ c0f0d853-5e42-497f-8c5f-1028d68c5d57
s = sum((f(data1x, sol) .- data1).^2/(length(data1)-1))

# ╔═╡ 165549de-2ea3-4b23-b316-9b03c990fab7


# ╔═╡ 1b0e1053-1201-487a-b4da-c02be27d48f4
cov_mat = diag(inv(X'X)*s)

# ╔═╡ Cell order:
# ╠═20f3a618-128e-424b-9b71-9144cffb3a4b
# ╠═1170d0ea-2cc9-4bd9-81bc-b7469dfec898
# ╠═684dbaab-12f6-4c31-bc37-b7bc5fda8198
# ╠═303e8a1b-3731-4535-a4c1-c7b0bb6e1501
# ╠═a05f6ecc-272a-493b-a7c3-78093695a351
# ╠═40da0174-37cc-49fc-9f6e-d3eb00e51579
# ╠═ceaea350-a9f2-449c-b964-4492fce93e48
# ╟─f13cc2f8-bfd5-412e-b98a-9016c62438e7
# ╠═3638b7be-b97e-4f24-a1d3-18af212fa44b
# ╠═fda78d62-0790-4b88-9a71-731c4f8f13d5
# ╠═e0040c1f-3eb8-409d-abc0-b7f64eb91fbf
# ╠═c0f0d853-5e42-497f-8c5f-1028d68c5d57
# ╠═165549de-2ea3-4b23-b316-9b03c990fab7
# ╠═1b0e1053-1201-487a-b4da-c02be27d48f4
