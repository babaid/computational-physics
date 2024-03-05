---
title: Numerical Differentiation
keywords: numerical integration, trapezoid, simpson
last_updated: March 5, 2024
tags: [numerical_integration]
sidebar: mydoc_sidebar
permalink: numerical_differentiation_algorithms.html
folder: cp1
---
<script src="js/code-block.js"></script>
<link rel="stylesheet" type="text/css" href="css/code-block.css">



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



<script> 


let tabData1 = [
  { name: 'Julia', content: 'forward_difference(f::Function, x, h=1e-3) = (f(x+h)-f(x))/h' },
  { name: 'Python', content: '// Python code here' },
  { name: 'Cpp', content: '// Cpp code here' }
];


document.write(createTabs(tabData1, "set1"));

</script>


Backward differences

<script>




</script>

Central differences

<script> 
let tabData3 = [
  { name: 'Julia', content: 'central_difference(f::Function, x, h=1e-3) = (f(x+h/2)-f(x-h/2))/h' },
  { name: 'Python', content: '// Python code here' },
  { name: 'Cpp', content: '// Cpp code here' }
];

document.write(createTabs(tabData3, "set3-"));

</script>


<script>

  
window.onload = function() {
  // Get all elements with class="tablinks"
  var tablinks = document.getElementsByClassName("tablinks");

  // If there are any tab links, click the first one
  if (tablinks.length > 0) {
    tablinks[0].click();
  }
};


</script>






