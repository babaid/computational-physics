### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c215cfab-24e2-4c6a-8743-3daa288ecb19
begin
	using Pkg; Pkg.activate(".")
end

# ╔═╡ 9683a43b-a49f-4b46-a4fa-736f6bbef61e
include("DualNumbers.jl")

# ╔═╡ c7086f82-b4be-44f1-b532-43501934e4f3
md""" 
# Numerical Differentiation

We would like to perform $\frac{df}{dx}$ for a function f so that the approximation has a low error. There are three main methods. Forward, backward and central differences.

As we know from a beginner math course differentiation looks as follows:

$f'(x) \approx \frac{f(x+h)-f(x)}{h}$

This is what we call the forward difference.
The backwards difference is defined as 

$f'(x) =  \approx \frac{f(x)-f(x-h)}{h}$

And finally the central difference is

$f'(x) =  \approx \frac{f(x+\frac{h}{2})-f(x\frac{h}{2})}{h}$

When taking the limit of $h\rightarrow \infty$ we end up with the analytical derivatives. Of course on a computer h has to be finite and greater than 0.

Expanding these approximations for small h, we can check what the error of them is. While forwards and backwards differences have a large error of $\mathbf{O}(h)$, while the central difference has an error of $\mathbf{O}(h^2)$.

The code for these is rather straight forward:
"""

# ╔═╡ a0265f3e-85a5-4384-8022-333de72ce8c3
forward_difference(f::Function, x, h=1e-3) = (f(x+h)-f(x))/h

# ╔═╡ 56b3e3de-9e3d-4358-bea6-18e3ed03b6fd
backward_difference(f::Function, x, h=1e-3) =  (f(x)-f(x-h))/h

# ╔═╡ f320e5af-f9b6-46f4-b854-c9f444b142fa
central_difference(f::Function, x, h=1e-3) = (f(x+h/2)-f(x-h/2))/h

# ╔═╡ b3e0d4e9-0d87-43aa-9dd1-9a82eb7ad949
md"""
# Other differentiation methods.

These numeric formulas are really useful in some cases, but sometimes there are more sofisticated approaches to deal with differentiation. For known functions we can apply the chain rule multiple times (automatic backward differentiation) and walk our way back to the first function. To make this idea reality, for each function you have to define a forward pass and a backward pass. The forward pass evaluates all the functions contained, and the backward pass calculates the gradients with respect to each variable. This is how popular ML frameworks like PyTorch work, and also most differentiable programming libraries.


## Automatic Diffrenetiation

An exotic and cool approach is automatic forward differentiation with dual numbers.
Dual numbers are pretty similar to complex numbers, but instead of an imaginary unit ($i^2 = -1$) we have a nilpotent unit $\epsilon^2 = 0$.

So a dual number can be written as $z=x+\epsilon y$. Similar to complex numbers we can derive algebraic properties of such numbers. After looking at those it is easy to see that these can be used for differentiation. 

By creating a number and setting the "imaginary" part to 1, after applying a function to this we get the function value as the real part and the numerical value of the derivative at that x value as the imaginary part. An implementation of some basic functions of dual numbers are in DualNumbers.jl, some code examples are written below.

Another cool thing about these dual numbers, and why I think they are worth mentioning, is what they actually are. They actually are the trivial case of a Grassman algebra, which is a construct used in condensed matter physics to describe creation and annihilation operators of fermions. Given that these operators anticommute one arrives at the condition that for such an algebra it must hold that  $\phi_i\cdot \phi_j = 0$ $\forall i, j$. In our case we just have one element in this set, which is $\epsilon$. 
"""

# ╔═╡ 562c3ccd-7c60-43a4-af77-0fd80f52a70a
#import may fail, play around
import .DualNumbers.Dual

# ╔═╡ 118c0e85-dfc7-4fe1-89a3-c8e731724aff
#test function
f(x) = sin(x)*exp(-0.5*x)

# ╔═╡ 540dd786-7a16-4611-8264-2165820c4ab9
#analytical derivative
g(x) = (cos(x)-0.5*sin(x))*exp(-0.5*x)

# ╔═╡ ba9c2eff-6a32-4878-ad1b-d11d8c24171a
#define point we are interested in
p = Dual(pi, 1.)

# ╔═╡ ba5bd1bb-596e-46d8-b862-95cb9de58323
md"""
We can actually use dual numbers also to create derivatives for fuctions of multiple variables, by extending $\epsilon$ to be a vector.
"""

# ╔═╡ 8d9ddc3f-a7cc-477f-aa34-4ba2fc198ce3
begin
	x = Dual(1, [1., 0., 0.])
	y = Dual(1, [0., 1., 0.])
	z = Dual(1, [0., 0., 1.])
end

# ╔═╡ 7668ed35-891d-4679-91c4-4b855d19ffd3
#some random function of 3 variables
h(x, y, z) = x*y*z + x^2 - exp(z)*x

# ╔═╡ 6af6e2d9-b769-4ae1-8f34-30d43b9a41d8
#analytic jacobian
j(x, y, z) = [y*z+2*x-exp(z), x*z, x*y-exp(z)*x]

# ╔═╡ fde37ec4-e56d-4fc2-8ead-5f2bade2b589
h(x, y, z).y

# ╔═╡ f9e81b02-2054-483b-ae06-063f049b6dec
j(1, 1, 1)

# ╔═╡ 19f59c38-8f0a-4cf4-b5a5-b20828eb204e
#we even can do this for vector valued functions

# ╔═╡ 8faa730e-2d6b-4620-84d0-f43a8a58bae0
f(x, y, z) = [exp(-0.5*z)+x, y*z-z^3, sin(z*x)-cos(z*y)*x]

# ╔═╡ 79172022-d598-476c-9fda-0e8f0850d1b9
#put dual number in argument of f
#take the imaginary value
f(p).y

# ╔═╡ e5098c15-9ba3-4d06-89ac-6afdfeaee1ea
#central difference approach
central_difference(f, pi, 1e-2)

# ╔═╡ 94f481e1-bea4-43db-8ee2-b6da611b5a96
g(x, y, z) = [ 1 0.0 -0.5*exp(-0.5*z)*x; 
				0.0 z y-3*z^2;
				z*cos(z*x)-cos(z*y) z*x*sin(z*y) x*cos(z*x)+y*cos(z*y)*x]

# ╔═╡ 362cac6d-93f6-418d-bbd1-633238774455
#this should be exactly the same as with the dual stuff
g(pi)

# ╔═╡ d46d2793-215a-41c2-af9e-c2b733b8ff87
#check if they are close
isapprox(f(p).y, g(pi))
#so they are actually the same.

# ╔═╡ 187bc828-896b-48cc-ac5f-52202d540b28
#so what about central difference
isapprox(central_difference(f, pi, 1e-1), g(pi), rtol=1e-3)
#it is really close to the analytical value.

# ╔═╡ 38e34c8e-66bc-4d47-8091-4871eac9120f
g(1, 1, 1)

# ╔═╡ a75605d6-4201-430f-97a2-a04568e10a3e
mapreduce(permutedims, vcat, [n.y for n in f(x, y, z)])
#wow indeed the jacobian

# ╔═╡ 6a375918-3848-4806-817e-a35f0c4b8702
md"""
## Exercises

As an exercize you may want to write a function that takes a function of a vector and some parameters as an input and calculates the jacobian like shown before this cell with the previous methods (all of them). Can you also calculate a Hessian matrix in this manner? 

When does it makes sense to use just a simple finite difference method?

Think of the up and downsides of each method and try to break them.

Many times if we take measurements, we have a certain sampling rate and the data set is discrete, yet we need to calculate the slopes between points. Write down the simplest method for this and check if there are better ones. 

What else can you do with derivatives? Try to find a connection between the stuff you may want to do with them and how you would proceed in a computational manner when there is no analytic solution available.
"""

# ╔═╡ Cell order:
# ╠═c215cfab-24e2-4c6a-8743-3daa288ecb19
# ╟─c7086f82-b4be-44f1-b532-43501934e4f3
# ╠═a0265f3e-85a5-4384-8022-333de72ce8c3
# ╠═56b3e3de-9e3d-4358-bea6-18e3ed03b6fd
# ╠═f320e5af-f9b6-46f4-b854-c9f444b142fa
# ╟─b3e0d4e9-0d87-43aa-9dd1-9a82eb7ad949
# ╠═9683a43b-a49f-4b46-a4fa-736f6bbef61e
# ╠═562c3ccd-7c60-43a4-af77-0fd80f52a70a
# ╠═118c0e85-dfc7-4fe1-89a3-c8e731724aff
# ╠═540dd786-7a16-4611-8264-2165820c4ab9
# ╠═ba9c2eff-6a32-4878-ad1b-d11d8c24171a
# ╠═79172022-d598-476c-9fda-0e8f0850d1b9
# ╠═362cac6d-93f6-418d-bbd1-633238774455
# ╠═e5098c15-9ba3-4d06-89ac-6afdfeaee1ea
# ╠═d46d2793-215a-41c2-af9e-c2b733b8ff87
# ╠═187bc828-896b-48cc-ac5f-52202d540b28
# ╟─ba5bd1bb-596e-46d8-b862-95cb9de58323
# ╠═8d9ddc3f-a7cc-477f-aa34-4ba2fc198ce3
# ╠═7668ed35-891d-4679-91c4-4b855d19ffd3
# ╠═6af6e2d9-b769-4ae1-8f34-30d43b9a41d8
# ╠═fde37ec4-e56d-4fc2-8ead-5f2bade2b589
# ╠═f9e81b02-2054-483b-ae06-063f049b6dec
# ╠═19f59c38-8f0a-4cf4-b5a5-b20828eb204e
# ╠═8faa730e-2d6b-4620-84d0-f43a8a58bae0
# ╠═94f481e1-bea4-43db-8ee2-b6da611b5a96
# ╠═38e34c8e-66bc-4d47-8091-4871eac9120f
# ╠═a75605d6-4201-430f-97a2-a04568e10a3e
# ╟─6a375918-3848-4806-817e-a35f0c4b8702
