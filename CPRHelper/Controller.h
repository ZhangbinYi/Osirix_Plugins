//
//  Controller.h
//  CPRHelper
//
//  Created by WB-Vessel Wall on 6/23/16.
//
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>
#import "CPRHelperFilter.h"
#import "OsiriXAPI/CPRTransverseView.h"

#import <opencv/cv.h>
#import "ObjcWrapper.h"



@class CPRHelperFilter;
@class ViewerController;
@class CPRController;
@class CPRTransverseView;


@interface Controller : NSWindowController {
    CPRHelperFilter *_filter;
    ViewerController *_viewerController;
    CPRController *_cprController;
    NSTextView *_textView1;
    NSTextView *_textView2;
    NSTextView *_textView3;
    NSTextView *_textView4;
    NSImageView *_imageView1;
    NSImageView *_imageView2;
    NSImageView *_imageView3;
    NSImageView *_imageView4;
    NSSlider *_slider2;
    NSSlider *_slider3;
    NSSlider *_slider4;
    
    ObjcWrapper *_objcWrapper;
}

@property (nonatomic, assign) CPRHelperFilter *filter;
@property (nonatomic, assign) ViewerController *viewerController;
@property (nonatomic, assign) CPRController *cprController;

@property (assign) IBOutlet NSTextView *textView1;
@property (assign) IBOutlet NSTextView *textView2;
@property (assign) IBOutlet NSTextView *textView3;
@property (assign) IBOutlet NSTextView *textView4;
@property (assign) IBOutlet NSImageView *imageView1;
@property (assign) IBOutlet NSImageView *imageView2;
@property (assign) IBOutlet NSImageView *imageView3;
@property (assign) IBOutlet NSImageView *imageView4;
@property (assign) IBOutlet NSSlider *slider2;
@property (assign) IBOutlet NSSlider *slider3;
@property (assign) IBOutlet NSSlider *slider4;

@property (assign) ObjcWrapper *objcWrapper;

- (id) init: (CPRHelperFilter*) f;

- (IBAction)openCPRViewer:(id)sender;
- (IBAction)testShowInfo:(id)sender;
- (IBAction)changeTransverseSectionPosition:(id)sender;
- (IBAction)saveTransverseImages:(id)sender;
- (IBAction)drawPlotWithCVNamedWindow:(id)sender;
- (IBAction)drawPlotWithImageView:(id)sender;
- (IBAction)slider2ValueChanged:(id)sender;
- (IBAction)slider3ValueChanged:(id)sender;
- (IBAction)slider4ValueChanged:(id)sender;


- (void) sliderValueChanged:(float)pos;
- (NSImage*) setTransverseSectionPosition:(CGFloat)newPos;
- (void) saveTransverseImageWithStepLength:(NSImage*)curImage index:(int)idx;
- (NSImage *)imageWithCVImage:(IplImage *)cvImage;

@end

@interface CPRTransverseView ()

- (void) _sendNewRequest;

@end




