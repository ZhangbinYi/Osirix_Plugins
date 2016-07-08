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
    return drawFloatGraph(arraySrc, nArrayLength);
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



