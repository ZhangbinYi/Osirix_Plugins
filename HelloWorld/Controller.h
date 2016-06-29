//
//  ViewController.h
//  Practice1
//
//  Created by WB-Vessel Wall on 6/13/16.
//  Copyright © 2016 WB-Vessel Wall. All rights reserved.
//

#import <AppKit/AppKit.h>

@class HelloWorldFilter;

@interface Controller : NSWindowController
{
    HelloWorldFilter *filter;
    
    IBOutlet NSTextField *label1;
    
}


- (id) init: (HelloWorldFilter*) f;
- (IBAction)changeLabel:(id)sender;
- (IBAction)alert:(id)sender;
- (IBAction)duplicate2DViewer:(id)sender;

@end

