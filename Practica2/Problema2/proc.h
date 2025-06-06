//CPP:curso2025/proc.cpp
#if !defined proc_h
#define proc_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class proc: public Simulator { 
// Declare the state,
// output variables
// and parameters
double sigma;
double busy;

double y;
#define INF 1e20;
public:
	proc(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
