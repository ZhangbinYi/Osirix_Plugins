//
//  CPRHelperFilter.h
//  CPRHelper
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>

@interface CPRHelperFilter : PluginFilter {
    
}

@property (assign) ViewerController* curViewerController;

- (long) filterImage:(NSString*) menuName;

@end
