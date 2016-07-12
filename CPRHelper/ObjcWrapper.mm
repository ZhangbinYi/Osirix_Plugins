//
//  ObjcWrapper.mm
//  CPRHelper
//
//  Created by WB-Vessel Wall on 7/7/16.
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