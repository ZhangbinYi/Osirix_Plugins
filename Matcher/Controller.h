//
//  Controller.h
//  Matcher
//
//  Created by WB-Vessel Wall on 7/26/16.
//
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>
#import "MatcherFilter.h"
#import "OsiriXAPI/CPRController.h"
#import "OsiriXAPI/CPRTransverseView.h"
#import "OsiriXAPI/CPRVolumeData.h"


@class ViewerController;




@interface Controller : NSWindowController


@property (assign) IBOutlet NSWindow *MatcherWindow;
@property (assign) IBOutlet NSSlider *slider;
@property (assign) IBOutlet NSTextField *textField1;


@property (nonatomic, assign) MatcherFilter *filter;
@property (nonatomic, assign) ViewerController *viewerController;
//@property (nonatomic, assign) ViewerController *viewerController1;
//@property (nonatomic, assign) ViewerController *viewerController2;

@property (nonatomic, assign) int numLayers;

- (id) init: (MatcherFilter*) f;


- (IBAction)divideIntoGroups:(id)sender;


- (void) exportDICOMFileWithSeriesName:(NSString*)seriesName from:(int)from to:(int)to withInterval:(int)interval;

@end
