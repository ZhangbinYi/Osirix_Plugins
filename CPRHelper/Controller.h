//
//  Controller.h
//  CPRHelper
//
//  Created by Zhangbin Yi on 6/23/16.
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
#import "ReportImageView.h"
#import "Resources.h"



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
@property (assign) IBOutlet NSTextField *textFieldStepLength;
@property (assign) IBOutlet NSImageView *vesselImageView;

@property (retain) ObjcWrapper *objcWrapper;


//@property (assign) float curTransverseSectionPosition;
@property (retain) NSImage *curTransverseImage;
@property (retain) NSImage *curPlotImage0;
@property (retain) NSImage *curPlotImage1;
@property (retain) NSImage *curPlotImage2;





- (id) init: (CPRHelperFilter*) f;


// open the Curved MPR window
- (IBAction)openCPRViewer:(id)sender;

// update the transverse image on the image view
- (IBAction)updateTransverseSectionPosition:(id)sender;

// init the three arrays and plot the graph
- (IBAction)drawPlotWithImageView:(id)sender;

// given a certain step length, save all the transverse images on the current curvedPath to a folder
- (IBAction)saveTransverseImages:(id)sender;

// segmentation process
- (IBAction)imageSegmentation:(id)sender;

// load the segmentation data file(txt), init the three vectors and draw the plot in the image views
- (IBAction)loadSegmentation:(id)sender;

// move the transverseSectionPosition on the current curvedPath
- (IBAction)slider2ValueChanged:(id)sender;
- (IBAction)slider3ValueChanged:(id)sender;
- (IBAction)slider4ValueChanged:(id)sender;


// find the path automatically (not very robust)
- (IBAction)findPath:(id)sender;

// create a PDF report with the current data and images
- (IBAction)createPDFFile:(id)sender;

// export current information to a json file (mainly the information of the curvedPath)
- (IBAction)exportJSON:(id)sender;

// import the history records and the curvedPath will be restored
- (IBAction)importJSON:(id)sender;





// transverse images and plots


// sychronize everything when slider value changed
- (void) sliderValueChanged:(float)pos;
// set transverseSectionPosition to newPos and update the related images
- (NSImage*) setTransverseSectionPosition:(CGFloat)newPos;
- (NSImage*) moveTransverseImageWithStepLength:(CGFloat)stepLength;

// save one curImage with an idx number
- (void) saveTransverseImage:(NSImage*)curImage index:(int) idx;
// convert IplImage* to NSImage*
- (NSImage*)imageWithCVImage:(IplImage *)cvImage;





// find path automatically

// main part of findPath
- (void) assistedCurvedPath;





// PDF Report


// the main method to draw and save the PDF file
- (void)createPDFFileWithRect:(CGRect)pageRect withSaveURL:(NSURL*)saveURL;
// draw text on pdfContext
- (void)drawTextWithContext:(CGContextRef)pdfContext withRect:(CGRect)textRect withFontSize:(float)fontSize withString:(NSString*)inputString;
// draw a image on pdfContext
- (void)drawImageWithContext:(CGContextRef)pdfContext withRect:(CGRect)imgRect withImage:(NSImage*)img;




// JSON

// get current local time
- (NSString*)getCurrentTime;
// parse the imported JSON string
- (void) parseJSON:(NSString*)jsonString;
// add an array of nodes to curvedPath
- (void) addNodesWithNodesArray:(NSMutableArray*)nodesArr;




// unused methods

- (IBAction)drawPlotWithCVNamedWindow:(id)sender;
- (IBAction)addNode:(id)sender;
- (IBAction)invertImage:(id)sender;
//- (void) saveTransverseImageWithStepLength:(NSImage*)curImage index:(int)idx;





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




