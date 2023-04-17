#include"../src/conversions.hpp"

#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace ::testing;

//===============================================================================
// TESTS

//-------------------------------------------------------------------------------
//
TEST(ConversionTest, DM2Semicircle)
{
  EXPECT_THAT(dm2semicircle(5,3), AllOf(Ge(5.04/180.0),Le(5.06/180.0)));
  EXPECT_THAT(dm2semicircle(4, 5), AllOf(Ge(4.08/180.0),Le(4.09/180.0)));
  return;
}

//-------------------------------------------------------------------------------
//
TEST(ConversionTest, Packsemi)
{
  EXPECT_EQ(pack2uint(dm2semicircle(5,3)), 1021695172);
  EXPECT_EQ(pack2uint(dm2semicircle(4,5)), 1018811976);
  return;
}

//-------------------------------------------------------------------------------
//
TEST(ConversionTest, Unpacksemi)
{

  EXPECT_THAT(unpackuint(1021695172), AllOf(Ge(0.0280555561),Le(0.0280555564)));
  EXPECT_THAT(unpackuint(1018811976), AllOf(Ge(0.0226851850),Le(0.0226851854)));
  return;
}

//===============================================================================
// RUN TESTS
int main(int argc, char** argv)
{
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
