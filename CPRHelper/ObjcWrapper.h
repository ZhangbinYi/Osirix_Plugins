//
//  ObjcWrapper.h
//  CPRHelper
//
//  Created by WB-Vessel Wall on 7/7/16.
//
//

#import <Foundation/Foundation.h>
#import <opencv/cv.h>

@interface ObjcWrapper : NSObject
- (void) printWithString:(NSString*)str;
- (IplImage*) getPlot;
- (void) showPlot;
- (IplImage*) getPlotWithLine:(float)pos;

@end