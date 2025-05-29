#include "cola.h"
void cola::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

primero = 0;
ultimo = 0;
count = 0;
busy = false;
sigma = INF;
}
double cola::ta(double t) {
//This function returns a double.
return sigma;
}
void cola::dint(double t) {
sigma = INF;
busy = true;
primero = (primero + 1) % 10;
count--;
}
void cola::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition
if (x.port == 0) // Se agrega una tarea nueva
{
	if (count < 10)
	{
		queue[ultimo] = x.getDouble();
		ultimo = (ultimo + 1) % 10;
		count++;
		if (busy)
			sigma = INF;
		else
		{
			current = queue[primero];
			sigma = 0;
		}	
	}
}
else  // El procesador està libre: Desencola la siguiente tarea
{
	if (count > 0)
	{
		current = queue[primero];
		sigma = 0;	
	}
	else 
	{
		sigma = INF;
	}
	busy = false;
}
}
Event cola::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)
y = current;
return Event(&y, 0);
}
void cola::exit() {
//Code executed at the end of the simulation.

}
