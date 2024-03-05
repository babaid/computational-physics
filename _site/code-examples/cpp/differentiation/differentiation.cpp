#include <iostream>
#include <functional>
#include <cmath>

double forward_difference(
  std::function<double(double)> f, double x, double h
){
  return ( f(x + h) - f(x) ) / h;
}

double central_difference(
  std::function<double(double)> f, double x, double h
){
  return ( f(x + h/2) - f(x - h/2) ) / h;
}

double extrapolated_difference(
  std::function<double(double)> f, double x, double h
){
  return (8 * ( f(x + h/4) - f(x - h/4) ) 
          - ( f(x + h/2) - f(x - h/2) ) ) / (3 * h);
}

double error(double exact, double approx){
  return std::abs(exact - approx) / exact;
}

int main(){
  std::function<double(double)> f = [](double x) { return x + std::exp(-x); };
  double x = 1.0;
  double h = 1e-6;
  
  double exact = 1.0 - 1.0 / M_E;
  double fd = forward_difference(f, x, h);
  double cd = central_difference(f, x, h);
  double ed = extrapolated_difference(f, x, h);
  
  std::cout << "Result, Error (forward difference): " 
      << fd << ", " << error(exact, fd) << '\n';
  std::cout << "Result, Error (central difference): " 
      << cd << ", " << error(exact, cd) << '\n';
  std::cout << "Result, Error (extrapolated difference): " 
      << ed << ", " << error(exact, ed) << '\n';

  return 0;
}
