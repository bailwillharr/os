#ifndef MATH_H
#define MATH_H

typedef struct {
	float x;
	float y;
	float z;
} Vec3;

typedef struct {
	float x;
	float y;
	float z;
	float w;
} Vec4;

typedef float Mat4[4][4];

typedef Vec3 Triangle3D[3];

int abs(int a);
#endif
