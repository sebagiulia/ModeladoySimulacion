//CPP:curso2025/gen.cpp
#if !defined gen_h
#define gen_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class gen: public Simulator { 
// Declare the state,
// output variables
// and parameters
double sigma;
double job;
double Jmin, Jmax, Tmin, Tmax;
double y;
public:
	gen(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
