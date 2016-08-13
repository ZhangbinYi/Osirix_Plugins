//
//  ObjcWrapper.mm
//  CPRHelper
//
//  Created by Zhangbin Yi on 7/7/16.
//
//

#import <Foundation/Foundation.h>
#import "ObjcWrapper.h"
#import "PlotManager.h"


@interface ObjcWrapper () {
    PlotManager wrapped;
}
@end


@implementation ObjcWrapper


- (void) initArrays {
    wrapped.initArrays();
}

- (int)getSize {
    return wrapped.numFloats;
}


- (float) getValueWithArray:(int)arrayNum atIndex:(int)idx {
    if (arrayNum == 0) return wrapped.floatArray0[idx];
    else if (arrayNum == 1) return wrapped.floatArray1[idx];
    else if (arrayNum == 2) return wrapped.floatArray2[idx];
    return -1;
}




- (void) printWithString:(NSString*)str
{
    std::string cpp_str([str UTF8String], [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    wrapped.print(cpp_str);
}

- (IplImage*) getPlot:(int)idx {
    return wrapped.getPlot(idx);
}

- (void) showPlot {
    wrapped.showPlot();
}

- (IplImage*) getPlotWithLineOfIdx:(int)idx atPosition:(float)pos {
    return wrapped.getPlotWithLine(idx, pos);
}

@end