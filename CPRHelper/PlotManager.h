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
    void print(std::string& str);
    void showFloatPlot(const char *name, const float *arraySrc, int nArrayLength);
    void showPlot();
};

#endif /* PlotManager_h */
