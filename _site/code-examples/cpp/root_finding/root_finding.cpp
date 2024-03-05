#include <cmath>
#include <iostream>
#include <functional>
#include <cassert>
#include <utility>


double bisection_method(double x_minus, double x_plus,
            std::function<double(double)> f){
  assert(f(x_minus) * f(x_plus) < 0.0 && "For bisection to work the following"
         " needs to be fullfilled: f(x_+) > 0 and f(x_-).");
  
  double TOLERANCE = 1e-8;
  size_t MAX_STEPS = 10000;
  double x = (x_plus + x_minus) / 2;  // midpoint
  int i;                              //iterator 

  if(x_minus > x_plus) std::swap(x_minus, x_plus);
  
  for(i=0; i<MAX_STEPS; i++){

    if(std::abs(f(x)) < TOLERANCE || std::abs(x_minus - x_plus) < TOLERANCE) break;
    
    if(f(x) * f(x_plus) > 0) x_plus  = x;
    else                     x_minus = x;

    // update and increment
    x = (x_plus + x_minus) / 2;
  }
  std::cout << "Number of iterations (bisection method): " << i << '\n';

  return x;
}

double error(double e, double a){
  return std::abs(e - a) / e;
}

int main(){
  std::function<double(double)> f = [](double x) { return x * x - 2; };
  double x_m = 1.0, x_p = 3;
  
  double exact = std::sqrt(2.0);
  double bm = bisection_method(x_m, x_p, f);

  std::cout << "Root, Error (Bisection): " << bm  
    << ", " << error(exact, bm) << '\n';

  return 0;
}
