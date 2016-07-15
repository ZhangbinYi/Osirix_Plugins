//
//  CPRHelperFilter.m
//  CPRHelper
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import "CPRHelperFilter.h"
#import "Controller.h"

@implementation CPRHelperFilter

- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{
    _curViewerController = viewerController;
    Controller *window = [[Controller alloc] init:self];
    [window showWindow:self];
    return 0;
}

@end
