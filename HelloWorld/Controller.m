//
//  ViewController.m
//  Practice1
//
//  Created by WB-Vessel Wall on 6/13/16.
//  Copyright © 2016 WB-Vessel Wall. All rights reserved.
//

#import "Controller.h"
#import "HelloWorldFilter.h"

@implementation Controller

- (id) init: (HelloWorldFilter*) f
{
    filter = f;
    self = [super initWithWindowNibName:@"Window"];
    [[self window] setDelegate:self];   //In order to receive the windowWillClose notification
    return self;
}

- (IBAction)changeLabel:(id)sender {
    [label1 setStringValue:[label1.stringValue stringByAppendingString:@" Hello!"]];
}

- (IBAction)alert:(id)sender {
    NSAlert *myAlert = [NSAlert alertWithMessageText:@"Hello World!"
                                       defaultButton:@"Hello"
                                     alternateButton:nil
                                         otherButton:nil
                           informativeTextWithFormat:@"hahahaha"];
    [myAlert runModal];
}

- (IBAction)duplicate2DViewer:(id)sender {
    ViewerController *new2DViewer;
    
    // duplicate the current 2D window
    
    new2DViewer = [filter duplicateCurrent2DViewerWindow];
}

@end
