//
//  CPRHelperFilter.h
//  CPRHelper
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>

@interface CPRHelperFilter : PluginFilter {
    NSString *validSerialNumber;
    NSDate *validDate;
}

@property (assign) ViewerController* curViewerController;

// OsiriX will always use this function to call the plugin
- (long) filterImage:(NSString*) menuName;

// get serial number of the Mac
- (NSString*)getSerialNumber;

// get network date from "http://www.timeanddate.com/"
- (NSDate*)getNetworkDate;

@end
