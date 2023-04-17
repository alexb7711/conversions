/*
 * This module is used to convert latitude, longitude, and elevation to
 * semi-circles. This algorithm's packing and unpacking is based off of the
 * following URL: https://www.codeproject.com/Articles/1274943/IEEE-754-Conversion
 */


#include "conversions.hpp"
#include <cstdint>

#define HALF_CIRCLE 180.0
#define MINUTE      60.0

//==============================================================================
// Conversions

float dm2semicircle (int degree, int minute)
{
  return (float)((degree + minute/MINUTE) / HALF_CIRCLE);
}

//==============================================================================
// Packing/Unpacking
uint32_t pack2uint (float f)
{
  uint32_t* i;
  i = (uint32_t*)&f;
  return *i;
}

float unpackuint(uint32_t i)
{
  float* f;
  f = (float*)&i;
  return *f;
}
