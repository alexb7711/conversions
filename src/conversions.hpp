#ifndef CONVERSIONS_H
#define CONVERSIONS_H

#include<cstdint>

float dm2semicircle(int degree, int minute);
uint32_t pack2uint (float f);
float unpackuint(uint32_t i);

#endif
