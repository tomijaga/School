#include <stdio.h>
#include <stdlib.h>
#include "obstacles.h"
#include "display.h"


// This is a helper function that determines whether or not line segment (v1---v2) intersects line segment (v3---v4)
unsigned char linesIntersect(short v1x, short v1y, short v2x, short v2y, short v3x, short v3y, short v4x, short v4y) {
  	float uA = ((v4x-v3x)*(v1y-v3y) - (v4y-v3y)*(v1x-v3x)) / (float)(((v4y-v3y)*(v2x-v1x) - (v4x-v3x)*(v2y-v1y)));
  	float uB = ((v2x-v1x)*(v1y-v3y) - (v2y-v1y)*(v1x-v3x)) / (float)(((v4y-v3y)*(v2x-v1x) - (v4x-v3x)*(v2y-v1y)));

  	// If uA and uB are between 0-1, there is an intersection
  	if (uA > 0 && uA < 1 && uB > 0 && uB < 1) 
		return 1;

	return 0;
}


// Create a grid of vertices with a horizontal and vertical gap between them of env->gridSize pixels
void createGrid(Environment *env) {

}


// This function removes all vertices that are invalid (i.e., inside an obstacle).
void removeInvalidVertices(Environment *env) {

}


// Add diagonal edges to the graph, assuming that they don't intersect an obstacle
void addCrossEdges(Environment *env) {

}


// This procedure cleans up everything by creeing all alocated memory
void cleanupEverything(Environment *env) {

}

