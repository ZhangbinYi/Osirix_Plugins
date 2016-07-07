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

- (void) printWithString:(NSString*)str
{
    std::string cpp_str([str UTF8String], [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    wrapped.print(cpp_str);
}

- (void) showPlot {
    wrapped.showPlot();
}

@end