#include <stdio.h>
#include <stdlib.h>
#include "obstacles.h"
#include "display.h"

// This is a helper function that determines whether or not line segment (v1---v2) intersects line segment (v3---v4)
unsigned char linesIntersect(short v1x, short v1y, short v2x, short v2y, short v3x, short v3y, short v4x, short v4y)
{

	float uA =
		((v4x - v3x) * (v1y - v3y) - (v4y - v3y) * (v1x - v3x)) /
		(float)(((v4y - v3y) * (v2x - v1x) - (v4x - v3x) * (v2y - v1y)));
	float uB = ((v2x - v1x) * (v1y - v3y) - (v2y - v1y) * (v1x - v3x)) / (float)(((v4y - v3y) * (v2x - v1x) - (v4x - v3x) * (v2y - v1y)));

	// If uA and uB are between 0-1, there is an intersection
	if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1)
		return 1;

	return 0;
}

void mallocVertexCheck(Vertex *vertex)
{
	if (vertex == NULL)
	{
		printf("Memory allocation error\n");
		exit(0);
	}
}

Vertex *newVertex(Environment *env, short prevX, short prevY)
{
	Vertex *nextVertex = NULL;
	nextVertex = (Vertex *)malloc(sizeof(Vertex));

	mallocVertexCheck(nextVertex);

	nextVertex->x = prevX;
	nextVertex->y = prevY;
	nextVertex->lastNeighbour = NULL;
	nextVertex->lastNeighbour = NULL;
	nextVertex->nextVertex = NULL;
	return nextVertex;
}

int ceiling(int num)
{
	return num + 1;
}

void createVerticesLinkedList(Environment *env)
{
	Vertex *head = NULL;
	head = (Vertex *)malloc(sizeof(Vertex));

	if (head == NULL)
	{
		printf("Memory allocation error\n");
		exit(0);
	}

	short prevX = 0;
	short prevY = 0;

	Vertex *prevVertex = NULL;
	prevVertex = head;

	if (prevVertex == NULL)
	{
		printf("Memory allocation error\n");
		exit(0);
	}

	for (size_t row = 0; row < ceiling((ENV_HEIGHT) / env->gridSize); ++row)
	{
		for (size_t col = 0; col < ceiling(ENV_WIDTH / env->gridSize); ++col)
		{
			Vertex *nextVertex = newVertex(env, prevX, prevY);
			prevVertex->nextVertex = nextVertex;

			if (row == 0 && col == 0)
			{
				head = nextVertex;
			}

			prevVertex = nextVertex;
			prevX += env->gridSize;

			nextVertex = NULL;
			free(nextVertex);
		}
		prevX = 0;
		prevY += env->gridSize;
		// printf("gridSize for y: %d\n", prevY);
		// printf("vertex at y: %d", prevVertex->y);
	}

	env->firstVertex = head;
}

Vertex *getVertex(Environment *env, int index)
{
	if (index < 0)
	{
		return NULL;
	}

	Vertex *v = env->firstVertex;

	int i = 0;
	while (v != NULL && i < index)
	{
		// printf("vertex %d: x=%d, y=%d\n", i, v->x, v->y);
		i++;
		v = v->nextVertex;
	}

	return v;
}

Neighbour *newNeighbour(Vertex *v, Neighbour *n)
{
	Neighbour *neighbour = NULL;
	neighbour = (Neighbour *)malloc(sizeof(Neighbour));

	if (neighbour == NULL)
	{
		printf("Memory allocation error in 'newNeighbour'\n");
		exit(0);
	}
	neighbour->vertex = v;
	neighbour->next = n;

	return neighbour;
}

void getObsVertexPoints(short *obx, short *oby, short *ob2x, short *ob2y, Obstacle *ob, int type)
{

	switch (type)
	{
	case 1:
		*obx = ob->x;
		*oby = ob->y;
		*ob2x = ob->x + ob->w;
		*ob2y = ob->y;
		break;

	case 2:
		*obx = ob->x + ob->w;
		*oby = ob->y;
		*ob2x = ob->x + ob->w;
		*ob2y = ob->y - ob->h;
		break;

	case 3:
		*obx = ob->x + ob->w;
		*oby = ob->y - ob->h;
		*ob2x = ob->x;
		*ob2y = ob->y - ob->h;
		break;

	case 4:
		*obx = ob->x;
		*oby = ob->y - ob->h;
		*ob2x = ob->x;
		*ob2y = ob->y;
		break;
	default:
		printf("Error in getObsVertexPoints:\n");
		printf("'type' has to be between 1 - 4:\n");
		exit(0);
		break;
	}
}

int validateNeighbour(Environment *env, Vertex *v, Neighbour *n)
{
	if (n->vertex == NULL)
	{
		return 0;
	}
	if (v == NULL)
	{
		return 0;
	}

	int i = 0;
	for (int i = 0; i < env->numObstacles; i++)
	{
		Obstacle ob = env->obstacles[i];

		for (int type = 1; type <= 4; type++)
		{
			short obX = 0;
			short obY = 0;
			short obX2 = 0;
			short obY2 = 0;

			getObsVertexPoints(&obX, &obY, &obX2, &obY2, &ob, type);

			int intersection = linesIntersect(v->x, v->y, n->vertex->x, n->vertex->y, obX, obY, obX2, obY2);

			// printf("type = %d\n", type);
			// printf("vertex x = %d, y = %d\n", v->x, v->y);
			// printf("neighbour x = %d, y = %d\n", n->vertex->x, n->vertex->y);

			// printf("ob1 x = %d, y = %d\n", obX, obY);
			// printf("ob2 x = %d, y = %d\n\n", obX2, obY2);

			if (intersection)
			{

				return 0;
			}
		}
	}

	return 1;
}

// Create a grid of vertices with a horizontal and vertical gap between them of env->gridSize pixels
void createGrid(Environment *env)
{
	int rowNum = ceiling((ENV_HEIGHT) / env->gridSize);
	int colNum = ceiling((ENV_WIDTH) / env->gridSize);

	createVerticesLinkedList(env);

	Vertex *v = env->firstVertex;

	short prevY = 0;
	for (size_t row = 0; row < rowNum; row++)
	{
		for (size_t col = 0; col < colNum; col++)
		{
			Neighbour *neighbours = NULL;
			Vertex *upperVertex = getVertex(env, col + colNum);
			Neighbour *upperNeighbour = newNeighbour(upperVertex, NULL);
			Neighbour *rightNeighbour = newNeighbour(v->nextVertex, NULL);

			// if (col == 7)
			// {
			// 	printf("row = %zu, col = %zu\n", row, col);
			// 	printf("upper vertex x = %d, y = %d\n", upperVertex->x, upperVertex->y);
			// 	printf("upper neighbour x = %d, y = %d\n", upperNeighbour->vertex->x, upperNeighbour->vertex->y);
			// }

			// printf("row = %zu, col = %zu\n", row, col);

			if ((col + 1) % colNum == 0)
			{
				if (validateNeighbour(env, v, upperNeighbour))
					neighbours = upperNeighbour;
			}
			else
			{
				if (validateNeighbour(env, v, upperNeighbour))
				{
					neighbours = upperNeighbour;
				}

				if (validateNeighbour(env, v, rightNeighbour))
				{
					if (neighbours == NULL)
					{
						neighbours = rightNeighbour;
					}
					else
					{
						neighbours->next = rightNeighbour;
					}
				}
			}

			v->firstNeighbour = neighbours;

			v = v->nextVertex;

			// free(neighbours);
			// free(upperNeighbour);
			// free(rightNeighbour);
		}
		prevY += 50;
	}

	for (size_t i = 0; i < env->numObstacles; i++)
	{
		printf("ob x = %d, ob y = %d\n", env->obstacles[i].x, env->obstacles[i].y);
	}
}

int isInvalidVertex(Environment *env, Vertex **v)
{
	for (int i = 0; i < env->numObstacles; i++)
	{
		Obstacle ob = env->obstacles[i];

		short y = (*v)->y - (ob.y - ob.h);
		short x = (*v)->x - ob.x;

		if (y >= 0 && y <= ob.h && x >= 0 && x <= ob.w)
		{
			return 1;
		}
	}

	return 0;
}

void removeVertice(Vertex **v)
{

	printf("vert x=%d, y=%d\n", (*v)->x, (*v)->y);

	Vertex *next = (*v)->nextVertex;
	(*v)->x = next->x;
	(*v)->y = next->y;
	(*v)->nextVertex = next->nextVertex;
	(*v)->firstNeighbour = next->firstNeighbour;
	(*v)->lastNeighbour = next->lastNeighbour;

	printf("new vert x=%d, y=%d\n", (*v)->x, (*v)->y);
}

// This function removes all vertices that are invalid (i.e., inside an obstacle).
void removeInvalidVertices(Environment *env)
{

	Vertex *v = env->firstVertex;
	short i = 0;
	while (v != NULL)
	{
		while (isInvalidVertex(env, &v))
		{
			removeVertice(&v);
		}

		v = v->nextVertex;
		i++;
	}
}

int validateDiagonalNeighbour(Environment *env, Vertex *v, Neighbour *n)
{

	if (v == NULL || n->vertex == NULL)
	{
		return 0;
	}

	if ((v->x + env->gridSize == n->vertex->x || v->x - env->gridSize == n->vertex->x) &&
		(v->y + env->gridSize == n->vertex->y))
	{
		return validateNeighbour(env, v, n);
	}

	return 0;
}

// Add diagonal edges to the graph, assuming that they don't intersect an obstacle
void addCrossEdges(Environment *env)
{
	int rowNum = ceiling((ENV_HEIGHT) / env->gridSize);
	int colNum = ceiling((ENV_WIDTH) / env->gridSize);

	Vertex *v = env->firstVertex;

	int i = 0;
	while (v != NULL)
	{
		int row = i / colNum;

		printf("vertex x=%d, y=%d\n", v->x, v->y);

		Neighbour *neighbours = NULL;
		Vertex *diagonalVertex = getVertex(env, (row + 1) * colNum);
		Neighbour *leftDiagonal = newNeighbour(diagonalVertex, NULL);
		Neighbour *rightDiagonal = newNeighbour(diagonalVertex, NULL);

		for (size_t i = 0; i < colNum; i++)
		{
			if (validateDiagonalNeighbour(env, v, leftDiagonal) || leftDiagonal->vertex == NULL)
			{
				break;
			}

			leftDiagonal->vertex = leftDiagonal->vertex->nextVertex;
		}

		for (size_t i = 0; i < colNum; i++)
		{
			if (validateDiagonalNeighbour(env, v, rightDiagonal) || rightDiagonal->vertex == NULL)
			{
				break;
			}

			rightDiagonal->vertex = rightDiagonal->vertex->nextVertex;
		}

		if (leftDiagonal->vertex != NULL)
		{
			neighbours = leftDiagonal;
		}

		if (rightDiagonal->vertex != NULL)
		{
			if (leftDiagonal->vertex == NULL)
			{
				neighbours = rightDiagonal;
			}
			else
			{
				neighbours->next = rightDiagonal;
			}
		}

		if (v->firstNeighbour != NULL)
		{
			Neighbour *fnPtr = v->firstNeighbour;

			while (fnPtr->next != NULL)
			{
				fnPtr = fnPtr->next;
			}

			fnPtr->next = neighbours;
		}
		else
		{
			v->firstNeighbour = neighbours;
		}
		v = v->nextVertex;
		i++;
	}
}

// This procedure cleans up everything by creeing all alocated memory
void cleanupEverything(Environment *env)
{
	Vertex *v = env->firstVertex;
	Vertex *temp = v;

	while (v != NULL)
	{
		temp = v->nextVertex;
		free(v);
		v = temp;
	}
	// free(env->obstacles);

	free(env);
}
