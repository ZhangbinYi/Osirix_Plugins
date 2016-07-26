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
#import "OsiriXAPI/CPRController.h"
#import "OsiriXAPI/CPRTransverseView.h"
#import "OsiriXAPI/CPRVolumeData.h"
#import "OsiriXAPI/FlyAssistant.h"

#import <opencv/cv.h>
#import "ObjcWrapper.h"



@class CPRHelperFilter;
@class ViewerController;
@class CPRController;
@class CPRTransverseView;
@class CPRVolumeData;


@interface Controller : NSWindowController {
    CPRHelperFilter *_filter;
    ViewerController *_viewerController;
    CPRController *_cprController;
    //CPRVolumeData *cprVolumeData;
    
    CPRMPRDCMView *_mprView1;
    CPRMPRDCMView *_mprView2;
    CPRMPRDCMView *_mprView3;
    CPRView *_cprView;
    
    
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
    NSTextField *_textField1;
    
    ObjcWrapper *_objcWrapper;
}

@property (nonatomic, assign) CPRHelperFilter *filter;
@property (nonatomic, assign) ViewerController *viewerController;
@property (nonatomic, assign) CPRController *cprController;
//@property (nonatomic, assign) CPRVolumeData *cprVolumeData;

@property (nonatomic, assign) CPRMPRDCMView *mprView1;
@property (nonatomic, assign) CPRMPRDCMView *mprView2;
@property (nonatomic, assign) CPRMPRDCMView *mprView3;
@property (nonatomic, assign) CPRView *cprView;


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
@property (assign) IBOutlet NSTextField *textField1;

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
- (IBAction)invertImage:(id)sender;
- (IBAction)addNode:(id)sender;
- (IBAction)findPath:(id)sender;


- (void) sliderValueChanged:(float)pos;
- (NSImage*) setTransverseSectionPosition:(CGFloat)newPos;
//- (void) saveTransverseImageWithStepLength:(NSImage*)curImage index:(int)idx;
- (NSImage*) moveTransverseImageWithStepLength:(CGFloat)stepLength;
- (void) saveTransverseImage:(NSImage*)curImage index:(int) idx;
- (NSImage *)imageWithCVImage:(IplImage *)cvImage;

- (void) assistedCurvedPath;

@end


@interface CPRController ()

- (void)assistedCurvedPath:(NSNotification*) note;


@end




@interface CPRTransverseView ()

- (void) _sendNewRequest;

@end



@interface CPRMPRDCMView ()

- (void)drawCurvedPathInGL;
- (void)drawOSIROIs;
- (OSIROIManager *)ROIManager;
- (void)drawCircleAtPoint:(NSPoint)point pointSize:(CGFloat)pointSize;
- (void)drawCircleAtPoint:(NSPoint)point;
- (void)sendWillEditCurvedPath;
- (void)sendDidUpdateCurvedPath;
- (void)sendDidEditCurvedPath;
- (void)sendDidEditAssistedCurvedPath;
- (void)sendWillEditDisplayInfo;
- (void)sendDidEditDisplayInfo;

- (void) stopCurvedPathCreationMode;

- (void)add2DPoint: (float*) r;
@end




