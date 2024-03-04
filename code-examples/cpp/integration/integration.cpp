#include <cmath>
#include <cstdlib>
#include <vector>
#include <utility>
#include <functional>
#include <iostream>
#include <cassert>

double compute_integral(
  size_t N, 
  const std::vector<double>& w,
  const std::vector<double>& x,
  const std::function<double(double)>& f
){
  int i; // iterator

  double integral {0.0};
  for(i=0; i<N; ++i){
    integral += w[i] * f(x[i]);
  }
  
  return integral; 
}

double error(double approx, double exac){
  return std::abs(approx - exac) / exac;
}

double trapezoidal_rule(
  size_t N, 
  const std::pair<double, double>& bounds,
  const std::function<double(double)>& f
)
{
  std::vector<double> w{}, x{};                    // weights and integration points
  double h { (bounds.second - bounds.first) / N }; // step size
  int i;                                           //iterator

  // compute weights and integration points
  for(i=0; i<N; ++i){
    w.push_back(h);
    x.push_back(bounds.first + i * h);
  }

  // last and first weight is h/2
  w[0] /= 2.0;
  w[N-1] /= 2.0;
  
  return compute_integral(N, w, x, f);
}

double simpsons_rule(
  size_t N,
  const std::pair<double, double>& bounds,
  const std::function<double(double)>& f
)
{
  assert(N%2!=0 && "The number of integration points N needs to be even for the simpson rule to work.");
  std::vector<double> w{}, x{};                     // weights and integration points
  double h { (bounds.second - bounds.first) / N };  // step size
  int i;                                            //iterator

  // compute weights and integration points
  for(i=0; i<N; ++i){
    x.push_back(bounds.first + i * h);

    if(i%2==0) w.push_back(2 * h / 3);
    else       w.push_back(4 * h / 3);
  }

  // last and first weight is h/2
  w[0] = h / 3;
  w[N-1] = h / 3;
  
  return compute_integral(N, w, x, f);
}

int main(){
  size_t N = 5001;
  auto bounds = std::make_pair(0.0, 1.0);
  std::function<double(double)> f = [](double x) { return std::exp(-x); };

  double res_trap = trapezoidal_rule(N, bounds, f);
  double res_simp = simpsons_rule(N, bounds, f);
  const double exact = 1.0 - 1.0 / M_E; 

  std::cout << "Result, Error (trapezoidal): " << res_trap
      << ", " << error(res_trap, exact) << '\n';
  std::cout << "Result, Error (simpson): " << res_simp 
      << ", " << error(res_trap, exact) << '\n';

  return 0;
}
