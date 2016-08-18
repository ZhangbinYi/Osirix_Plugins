//
//  PlotManager.hpp
//  CPRHelper
//
//  Created by Zhangbin Yi on 7/7/16.
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

using namespace std;


class PlotManager {
public:
    vector<float> waVec;
    vector<float> laVec;
    vector<float> nwiVec;
    
    /*
    int numFloats = 100;
    float floatArray0[100] = {0};
    float floatArray1[100] = {0};
    float floatArray2[100] = {0};
     */

    void print(std::string& str);
    
    void initVectors(string vectorStr);
    IplImage* getFloatPlot(const float *arraySrc, int nArrayLength);
    IplImage* getPlot(int i);
    void showFloatPlot(const char *name, const float *arraySrc, int nArrayLength);
    void showPlot();
    IplImage* drawLineInPlot(IplImage* plotImage, float pos);
    IplImage* getPlotWithLine(int idx, float pos);
};

#endif /* PlotManager_h */
