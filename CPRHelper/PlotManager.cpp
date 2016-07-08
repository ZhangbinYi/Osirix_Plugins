//
//  PlotManager.cpp
//  CPRHelper
//
//  Created by WB-Vessel Wall on 7/7/16.
//
//

#include "PlotManager.h"

using namespace std;
using namespace cv;


void PlotManager::print(string& str) {
    cout << str << endl;
}

IplImage* PlotManager::getFloatPlot(const float *arraySrc, int nArrayLength) {
    setCustomGraphColor(60, 60, 255);
    return drawFloatGraph(arraySrc, nArrayLength, NULL, 0, 0, 400, 300);
}

IplImage* PlotManager::getPlot() {
    return getFloatPlot(floatArray, numFloats);
}


void PlotManager::showFloatPlot(const char *name, const float *arraySrc, int nArrayLength) {
    showFloatGraph(name, arraySrc, nArrayLength);
}


void PlotManager::showPlot() {
    showFloatPlot("Ratio Plot", floatArray, numFloats);
}


IplImage* PlotManager::drawLineInPlot(IplImage* plotImage, float pos) {
    int width = plotImage->width;
    int height = plotImage->height;
    cvLine(plotImage, cvPoint(width * pos / 100, 0), cvPoint(width * pos / 100, height), CV_RGB(255,60,40));
    return plotImage;
}

IplImage* PlotManager::getPlotWithLine(float pos) {
    IplImage *plotImage = getPlot();
    plotImage = drawLineInPlot(plotImage, pos);
    return plotImage;
}






