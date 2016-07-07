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

void PlotManager::showFloatPlot(const char *name, const float *arraySrc, int nArrayLength) {
    showFloatGraph(name, arraySrc, nArrayLength);
}

void PlotManager::showPlot() {
    float floatArray[9] = {1,8,3,6,5,4,7,2,9};
    int numFloats = 9;
    showFloatPlot("Ratio Plot",  floatArray, numFloats);
}
