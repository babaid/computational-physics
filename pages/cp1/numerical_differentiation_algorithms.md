---
title: Numerical Differentiation
keywords: numerical integration, trapezoid, simpson
last_updated: March 5, 2024
tags: [numerical_integration]
sidebar: mydoc_sidebar
permalink: numerical_differentiation_algorithms.html
folder: cp1
---


<link rel="stylesheet" type="text/css" href="css/code-block.css">
<script src="js/code-block.js"></script>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.0.0/styles/default.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/10.0.0/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>


We would like to perform $$\frac{df}{dx}$$ for a function f so that the approximation has a low error. There are three main methods. Forward, backward and central differences.

As we know from a beginner math course differentiation looks as follows:

$$f'(x) \approx \frac{f(x+h)-f(x)}{h}$$

This is what we call the forward difference.
The backwards difference is defined as

$$f'(x)  \approx \frac{f(x)-f(x-h)}{h}$$

And finally the central difference is

$$f'(x)  \approx \frac{f(x+\frac{h}{2})-f(x\frac{h}{2})}{h}$$

When taking the limit of $$h\rightarrow \infty$$ we end up with the analytical derivatives. Of course on a computer h has to be finite and greater than 0.

Expanding these approximations for small h, we can check what the error of them is. While forwards and backwards differences have a large error of $$\mathbf{O}(h)$$, while the central difference has an error of $$\mathbf{O}(h^2)$$.

The code for these is rather straight forward:

<div class="code-block">
  <div class="tabs">
    <button class="tablink" onclick="openCode(event, 'Python')">Python</button>
    <button class="tablink" onclick="openCode(event, 'Cpp')">C++</button>
    <button class="tablink defaultOpen" onclick="openCode(event, 'Julia')">Julia</button>
  </div>
  <div class="Python tabcontent">
    <pre><code class="python">
    # Python code goes here
    import numpy as np
    </code></pre>
  </div>
  <div class="Cpp tabcontent">
    <pre><code class="cpp">
    // C++ code goes here
    #include &lt;iostream&gt;

    int main(){
        return 0;
    }
    </code></pre>
  </div>
  <div class="Julia tabcontent">
    <pre><code class="julia">
    # Julia code goes here
    using LinearAlgebra
    </code></pre>
  </div>
</div>



<div class="code-block">
  <div class="tabs">
    <button class="tablink" onclick="openCode(event, 'Python')">Python</button>
    <button class="tablink" onclick="openCode(event, 'Cpp')">C++</button>
    <button class="tablink defaultOpen" onclick="openCode(event, 'Julia')">Julia</button>
  </div>
  <div class="Python tabcontent">
    <pre><code class="python">
    # Python code goes here
    </code></pre>
  </div>
  <div class="Cpp tabcontent">
    <pre><code class="cpp">
    // C++ code goes here
    </code></pre>
  </div>
  <div class="Julia tabcontent">
    <pre><code class="julia">
    # Julia code goes here
    </code></pre>
  </div>
</div>

