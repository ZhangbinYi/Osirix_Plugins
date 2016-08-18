//
//  PlotManager.cpp
//  CPRHelper
//
//  Created by Zhangbin Yi on 7/7/16.
//
//

#include "PlotManager.h"
#include <iostream>
#include <fstream>
#include <string>

using namespace std;
using namespace cv;


void PlotManager::initVectors(string vectorStr) {
    waVec.clear();
    laVec.clear();
    nwiVec.clear();
    
    istringstream input(vectorStr);
    string waVecStr, laVecStr;
    getline(input, waVecStr);
    getline(input, laVecStr);
    istringstream waIs(waVecStr);
    istringstream laIs(laVecStr);
    
    string waFloatStr;
    while (waIs >> waFloatStr) {
        waVec.push_back(atof(waFloatStr.c_str()));
    }

    string laFloatStr;
    while (laIs >> laFloatStr) {
        laVec.push_back(atof(laFloatStr.c_str()));
    }
    
    if (waVec.size() != laVec.size()) {
        cout << "waVec.size() != laVec.size()" << endl;
    }
    
    nwiVec.resize(waVec.size());
    for (int i = 0; i < waVec.size(); i++) {
        nwiVec[i] = waVec[i] / laVec[i];
    }
    
    
    // random data
    /*
    waVec.resize(100);
    laVec.resize(100);
    nwiVec.resize(100);
    for (int i = 0; i < 100; i++) {
        waVec[i] = 4.0 + static_cast <float> (rand()) / static_cast <float> (RAND_MAX/2);
    }
    for (int i = 0; i < 100; i++) {
        laVec[i] = 1.0 + static_cast <float> (rand()) / static_cast <float> (RAND_MAX/2);
    }
    for (int i = 0; i < 100; i++) {
        nwiVec[i] = waVec[i] / laVec[i];
    }
     */
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
        int size = waVec.size();
        float waArray[size];
        std::copy(waVec.begin(), waVec.end(), waArray);
        return getFloatPlot(waArray, size);
    } else if (idx == 1) {
        int size = laVec.size();
        float laArray[size];
        std::copy(laVec.begin(), laVec.end(), laArray);
        return getFloatPlot(laArray, size);
    } else if (idx == 2) {
        int size = nwiVec.size();
        float nwiArray[size];
        std::copy(nwiVec.begin(), nwiVec.end(), nwiArray);
        return getFloatPlot(nwiArray, size);
    }
    return NULL;
}


void PlotManager::showFloatPlot(const char *name, const float *arraySrc, int nArrayLength) {
    showFloatGraph(name, arraySrc, nArrayLength);
}


void PlotManager::showPlot() {
    //showFloatPlot("Ratio Plot", floatArray2, numFloats);
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






