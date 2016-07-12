//
//  PlotManager.hpp
//  CPRHelper
//
//  Created by WB-Vessel Wall on 7/7/16.
//
//

#ifndef PlotManager_h
#define PlotManager_h

#include <stdio.h>
#include <iostream>
#include <string>
#include <vector>
#include <opencv2/opencv.hpp>

#include "GraphUtils.h"

class PlotManager {
public:
    int numFloats = 100;
    float floatArray0[100] = {0};
    float floatArray1[100] = {0};
    float floatArray2[100] = {0};

    void print(std::string& str);
    
    void initArrays();
    IplImage* getFloatPlot(const float *arraySrc, int nArrayLength);
    IplImage* getPlot(int i);
    void showFloatPlot(const char *name, const float *arraySrc, int nArrayLength);
    void showPlot();
    IplImage* drawLineInPlot(IplImage* plotImage, float pos);
    IplImage* getPlotWithLine(int idx, float pos);
};

#endif /* PlotManager_h */
