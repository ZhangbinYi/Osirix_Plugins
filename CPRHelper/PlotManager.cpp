//
//  PlotManager.cpp
//  CPRHelper
//
//  Created by Zhangbin Yi on 7/7/16.
//
//

#include "PlotManager.h"

using namespace std;
using namespace cv;


void PlotManager::initArrays() {
    for (int i = 0; i < 100; i++) {
        floatArray0[i] = 4.0 + static_cast <float> (rand()) / static_cast <float> (RAND_MAX/2);
    }
    for (int i = 0; i < 100; i++) {
        floatArray1[i] = 1.0 + static_cast <float> (rand()) / static_cast <float> (RAND_MAX/2);
    }
    for (int i = 0; i < 100; i++) {
        floatArray2[i] = floatArray1[i] / floatArray0[i];
    }
}



void PlotManager::print(string& str) {
    cout << str << endl;
}

IplImage* PlotManager::getFloatPlot(const float *arraySrc, int nArrayLength) {
    setCustomGraphColor(60, 60, 255);
    return drawFloatGraph(arraySrc, nArrayLength, NULL, 0, 0, 400, 300);
}

IplImage* PlotManager::getPlot(int idx) {
    if (idx == 0) {
        return getFloatPlot(floatArray0, numFloats);
    } else if (idx == 1) {
        return getFloatPlot(floatArray1, numFloats);
    } else if (idx == 2) {
        return getFloatPlot(floatArray2, numFloats);
    }
}


void PlotManager::showFloatPlot(const char *name, const float *arraySrc, int nArrayLength) {
    showFloatGraph(name, arraySrc, nArrayLength);
}


void PlotManager::showPlot() {
    showFloatPlot("Ratio Plot", floatArray2, numFloats);
}


IplImage* PlotManager::drawLineInPlot(IplImage* plotImage, float pos) {
    int width = plotImage->width;
    int height = plotImage->height;
    int b = width * 0.05;
    cvLine(plotImage, cvPoint(b + (width - 2 * b) * pos / 100, 0), cvPoint(b + (width - 2 * b) * pos / 100, height), CV_RGB(255,60,40));
    return plotImage;
}

IplImage* PlotManager::getPlotWithLine(int idx, float pos) {
    IplImage *plotImage = getPlot(idx);
    plotImage = drawLineInPlot(plotImage, pos);
    return plotImage;
}






