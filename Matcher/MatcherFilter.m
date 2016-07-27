//
//  MatcherFilter.m
//  Matcher
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import "MatcherFilter.h"
#import "Controller.h"

@implementation MatcherFilter

- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{
    _curViewerController = viewerController;
    Controller *windowController = [[Controller alloc] init:self];
    [windowController showWindow:self];
    return 0;
}

@end
