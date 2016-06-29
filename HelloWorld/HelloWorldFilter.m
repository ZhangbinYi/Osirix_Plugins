//
//  HelloWorldFilter.m
//  HelloWorld
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import "Controller.h"
#import "HelloWorldFilter.h"

@implementation HelloWorldFilter
- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{
    /*
	ViewerController	*new2DViewer;
	
	// In this plugin, we will simply duplicate the current 2D window!
	
	new2DViewer = [self duplicateCurrent2DViewerWindow];
	
	if( new2DViewer) return 0; // No Errors
	else return -1;
     */
    
    Controller *window = [[Controller alloc] init:self];
    [window showWindow:self];
    
    return 0;
    
}

@end
