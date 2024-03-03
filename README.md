# Computational Physics Introduction

The topics covered in this repository are the following:

    1. Basics of numerical programming (representation, precision, stability, complexity)
    2. Differentiation (Forward, Backward, Central, Dual Numbers)
    3. Integration (Trapezoid, Simpson, etc.))
    4. Linear Algebra (Gauss elimination, LU, SVD)
    5. Root finding (Bisection, NR)
    6. Data fitting and interpolation (Splines, Least squares, etc..)
    7. Ordinary Differential Equations
    8. Partial Differential Equations

My aim behind this repo is to provide an overview/course that has a better structure and better focus on actual algrithms than the computational physics course at TUM.
While covering the same topics the course nor the exercises have not been updated in years. The original course also tries to force physics students to learn C, who inherently have little to no experience in clean and structured software engineering, resulting in both discouragement and really badly written C/C++ code among scientists.

The real goal behind an introductory course to computational physics should be to encourage and teach the combination of algorithmic thinking in science. With that in mind I encourage you to use any programming language (that makes sense) to develop the algorithms showed, as one of the most effective tools of a physicist is adaptation, knowing the strenghts and weaknesses of each method used. 

# Some suggestions regarding programming languages.

Some people like to start off with C/C++. This requires a lot more dedication than most languages as it is really error prone and low level in the beginning. Until you really know what you are doing the computational physics course could be over. So if you have the time, learn it long before and then it is going to be fine. You should still learn it some time if pursuing a computational physics carreer, but do not loose the focus on what *this* course is about (hint: It is not called "Introduction to C++ Programming").

A very good language to understand numerical stability and also do linear algebra stuff is matlab. I personally dont like it but you do you.

Python is the language used today by most ( so sad :((( ) computational scientist. Some software engineers don't even consider it as a language. You should be able to formulate any of your algorithms in it because of its popularity.

Large parts of the course will be written in Julia, for multiple reasons, some of them are: interoperaility with jupyter notebooks, inbuilt mathematical stuff, better packaging system than python. And it is fast. 

Some other things around programming and IT: you should be proficient with to actally get things done fast is how to use linux and bash scripting. The toolset that you get with that is just beyond powerful.




# Important Links 

- [Gaussian elimination](https://sites.engineering.ucsb.edu/~hpscicom/projects/gauss/introge.pdf)

- [Linear Algebra Algorithms](https://johnfoster.pge.utexas.edu/numerical-methods-book/LinearAlgebra_LU.html)

- [SVD algorithms](https://www.cs.utexas.edu/users/inderjit/public_papers/HLA_SVD.pdf)

- [Numerical integration](https://www.sfu.ca/math-coursenotes/Math%20158%20Course%20Notes/sec_Numerical_Integration.html)

- [Optimization and root finding](https://people.duke.edu/~ccc14/sta-663/MultivariateOptimizationAlgortihms.html)

- [Game engines and floating point numbers](https://fabiensanglard.net/)

- [Cubic splines](https://blog.timodenk.com/cubic-spline-interpolation/index.html)
