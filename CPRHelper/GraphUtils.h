
#ifndef GRAPH_UTILS_H
#define GRAPH_UTILS_H

/*
#ifdef __cplusplus
extern "C"
{
#endif
 */

// Allow 'bool' variables in both C and C++ code.
#ifdef __cplusplus
#else
	typedef int bool;
	#define true (1)
	#define false (0)
#endif

#ifdef __cplusplus
    #define DEFAULT(val) = val
#else
    #define DEFAULT(val)
#endif

#include <opencv2/opencv.hpp>


#if !defined(__cplusplus)
#define MONExternC extern
#else
#define MONExternC extern "C"
#endif

//------------------------------------------------------------------------------
// Graphing functions
//------------------------------------------------------------------------------

// Draw the graph of an array of floats into imageDst or a new image, between minV & maxV if given.
// Remember to free the newly created image if imageDst is not given.
IplImage* drawFloatGraph(const float *arraySrc, int nArrayLength, IplImage *imageDst DEFAULT(0), float minV DEFAULT(0.0), float maxV DEFAULT(0.0), int width DEFAULT(0), int height DEFAULT(0), char *graphLabel DEFAULT(0), bool showScale DEFAULT(true));

// Display a graph of the given float array.
// If background is provided, it will be drawn into, for combining multiple graphs using drawFloatGraph().
// Set delay_ms to 0 if you want to wait forever until a keypress, or set it to 1 if you want it to delay just 1 millisecond.
void showFloatGraph(const char *name, const float *arraySrc, int nArrayLength, int delay_ms DEFAULT(500), IplImage *background DEFAULT(0));

// Simple helper function to easily view an image, with an optional pause.
void showImage(const IplImage *img, int delay_ms DEFAULT(0), char *name DEFAULT(0));

// Call 'setGraphColor(0)' to reset the colors that will be used for graphs.
void setGraphColor(int index DEFAULT(0));
// Specify the exact color that the next graph should be drawn as.
void setCustomGraphColor(int R, int B, int G);


/*
#if defined (__cplusplus)
}
#endif
*/
 
#endif //end GRAPH_UTILS