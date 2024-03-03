### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ fc6e6630-856a-11ee-2062-037e90333a56
using Pkg; Pkg.activate(".")

# ╔═╡ 41473adf-d5a8-457a-9af3-4ea1a897ca05
using LinearAlgebra

# ╔═╡ b6b74e6d-cceb-496b-882c-f352feb0bb30
function swap_rows!(mat, i, j)
	temp = copy(mat[i, :]);
	mat[i, :] = mat[j, :];
	mat[j, :] = temp;
	return
end

# ╔═╡ 288d0e59-fa93-4adb-8573-af13202419c8
function multiply_row_by!(mat, i, num)
	mat[i, :]*=num
end

# ╔═╡ e1042e6f-32bc-4518-8258-1e4b46146d1d
function add_row_to_another_row(mat, i, j, multiplier)
	mat[j, :] += mat[i, :]*multiplier
end

# ╔═╡ d695de6b-6ceb-42c9-b464-0d956b457cb5


# ╔═╡ d8218f77-0f25-491e-9a1e-c556442253a1
function gaussian_elimination(m)

	n, l = size(m)
	for i in 1:n
		for i in 1:n
			if m[i, i] == 0
				swap_rows!(m, i, i+1)
			end
		end
	end
			
	#elimination
	for i in 1:(n-1)
		for j in (i+1):n
			add_row_to_another_row(m, i, j, -m[j, i]/m[i, i])		
		end
	end
	
	x = copy(m[:, end])

	#back substiution
	for i in n:-1:1
		for j in (i+1):n
			x[i] = x[i] - m[i, j]*x[j]
		end
		x[i]=x[i]/m[i, i]
	end
	return x	
end

# ╔═╡ d5d3762d-457c-4919-80a6-8efd738fe260
begin
	mat = [0 3 -2 -7; -1. -1 3 -4; 2 -1 5 6]
	gaussian_elimination(mat)
end


# ╔═╡ 77bf1e40-9183-478f-875a-e14ba0db8619
mat

# ╔═╡ 4a7e6dd2-faf6-4ce9-a5fd-f7e246467ca6
gaussian_elimination(mat, b)

# ╔═╡ 3fa3175e-58ae-4093-a295-4ffb75c5adc8
for i in 3:3
	print(i)
end

# ╔═╡ Cell order:
# ╠═fc6e6630-856a-11ee-2062-037e90333a56
# ╠═41473adf-d5a8-457a-9af3-4ea1a897ca05
# ╠═b6b74e6d-cceb-496b-882c-f352feb0bb30
# ╠═288d0e59-fa93-4adb-8573-af13202419c8
# ╠═e1042e6f-32bc-4518-8258-1e4b46146d1d
# ╠═d695de6b-6ceb-42c9-b464-0d956b457cb5
# ╠═d8218f77-0f25-491e-9a1e-c556442253a1
# ╠═d5d3762d-457c-4919-80a6-8efd738fe260
# ╠═77bf1e40-9183-478f-875a-e14ba0db8619
# ╠═4a7e6dd2-faf6-4ce9-a5fd-f7e246467ca6
# ╠═3fa3175e-58ae-4093-a295-4ffb75c5adc8
