//CPP:curso2025/cola.cpp
#if !defined cola_h
#define cola_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class cola: public Simulator { 
// Declare the state,
// output variables
// and parameters
double queue[10];
int primero, ultimo, count;
int max;
double y, sigma;
bool busy;
double current;

#define INF 1e20





public:
	cola(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
