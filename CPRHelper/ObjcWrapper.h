//
//  ObjcWrapper.h
//  CPRHelper
//
//  Created by Zhangbin Yi on 7/7/16.
//
//

#import <Foundation/Foundation.h>
#import <opencv/cv.h>

@interface ObjcWrapper : NSObject

- (void) initvectorsWithString:(NSString*)vectorString;
- (int) getSize;
- (float) getValueWithArray:(int)arrayNum atIndex:(int)idx;


- (void) printWithString:(NSString*)str;
- (IplImage*) getPlot:(int)idx;
- (void) showPlot;
- (IplImage*) getPlotWithLineOfIdx:(int)idx atPosition:(float)pos;

@end