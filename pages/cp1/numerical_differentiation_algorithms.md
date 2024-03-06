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
""script src="js/code-block.js">script
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




<!DOCTYPE html>
<html>
<head>
    <style>
        .tab { cursor: pointer; padding: 10px; border: 1px solid #ccc; display: inline-block; }
        .active { background-color: #ddd; }
        .code-block { border: 1px solid #ccc; padding: 10px; margin-top: 10px; }
    </style>
</head>
<body>

<h2>Code Block 1</h2>

<div class="tabs">
    <div class="tab active" onclick="changeTab(this, 'python')">Python</div>
    <div class="tab" onclick="changeTab(this, 'javascript')">JavaScript</div>
    <div class="tab" onclick="changeTab(this, 'java')">Java</div>
</div>

<div class="code-block">
    <pre class="python">
    def hello_world():
        print("Hello, world!")
    </pre>
    <pre class="javascript" style="display: none;">
    function helloWorld() {
        console.log("Hello, world!");
    }
    </pre>
    <pre class="java" style="display: none;">
    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello, World!");
        }
    }
    </pre>
</div>

<h2>Code Block 2</h2>

<div class="tabs">
    <div class="tab active" onclick="changeTab(this, 'python')">Python</div>
    <div class="tab" onclick="changeTab(this, 'javascript')">JavaScript</div>
    <div class="tab" onclick="changeTab(this, 'java')">Java</div>
</div>

<div class="code-block">
     <pre class="python">
    def hello_world():
        print("Hello, world!")
    </pre>
    <pre class="javascript" style="display: none;">
    function helloWorld() {
        console.log("Hello, world!");
    }
    </pre>
    <pre class="java" style="display: none;">
    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello, World!");
        }
    }
    </pre>
</div>

<script>
    function changeTab(tab, language) {
        var tabs = tab.parentNode.getElementsByClassName('tab');
        for (var i = 0; i < tabs.length; i++) {
            tabs[i].className = tabs[i].className.replace(' active', '');
        }
        var codeBlocks = tab.parentNode.nextElementSibling.getElementsByTagName('pre');
        for (var i = 0; i < codeBlocks.length; i++) {
            codeBlocks[i].style.display = codeBlocks[i].className === language ? 'block' : 'none';
        }
        tab.className += ' active';
    }
</script>

</body>
</html>

