//
//  Controller.m
//  CPRHelper
//
//  Created by Zhangbin Yi on 6/23/16.
//
//

#import "Controller.h"
#import "CPRHelperFilter.h"

#import <OsiriXAPI/PluginFilter.h>
#import "OsiriXAPI/DCMPix.h"
#import "OsiriXAPI/DCMView.h"

#import "OsiriXAPI/CPRController.h"
#import "OsiriXAPI/CPRTransverseView.h"
#import "OsiriXAPI/CPRView.h"
#import "OsiriXAPI/CPRCurvedPath.h"
#import "OsiriXAPI/CPRMPRDCMView.h"
#import "OsiriXAPI/N3BezierPath.h"
#import "OsiriXAPI/N3BezierCoreAdditions.h"

#import "OsiriXAPI/FlyAssistant.h"
#import "FlyAssistant2.h"





@implementation Controller

@synthesize filter = _filter;
@synthesize viewerController = _viewerController;
@synthesize cprController = _cprController;
//@synthesize cprVolumeData = _cprVolumeData;


@synthesize mprView1 = _mprView1;
@synthesize mprView2 = _mprView2;
@synthesize mprView3 = _mprView3;
@synthesize cprView = _cprView;
 

@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize imageView4 = _imageView4;
@synthesize slider2 = _slider2;
@synthesize slider3 = _slider3;
@synthesize slider4 = _slider4;
@synthesize textField1 = _textField1;

@synthesize objcWrapper = _objcWrapper;


// init the Controller instance with CPRHelperWindow
- (id) init: (CPRHelperFilter*) f
{
    _filter = f;
    self = [super initWithWindowNibName:@"CPRHelperWindow"];
    [[self window] setDelegate:self];   //In order to receive the windowWillClose notification
    
    _objcWrapper = [[ObjcWrapper alloc] init];
    
    [_vesselImageView setImageScaling: NSImageScaleProportionallyUpOrDown];
    
    // save vessel image to file
    /*
    NSData *imageData = [_vesselImageView.image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    [imageData writeToFile:@"/Users/wb-vesselwall/Documents/OsiriX Data/REPORTS/vessel.jpg" atomically:NO];
     */
    
    Resources *resourcesObject = [[Resources alloc] init];
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:resourcesObject.imageEncodedString options:0];
    NSImage *img1 = [[NSImage alloc] initWithData:decodedData];
    
    [_vesselImageView setImage:img1];
    
    return self;    
}


// open the Curved MPR window
- (IBAction)openCPRViewer:(id)sender {
    //_viewerController = [_filter duplicateCurrent2DViewerWindow];
    _viewerController = _filter.curViewerController;
    _cprController = [_viewerController openCPRViewer];
    [_viewerController place3DViewerWindow:(NSWindowController *) _cprController];
    [_cprController showWindow:self];
    
    _mprView1 = _cprController.mprView1;
    _mprView2 = _cprController.mprView2;
    _mprView3 = _cprController.mprView3;
    _cprView = _cprController.cprView;
    
}









// transverse images and glots
///////////////////////////////////////////////////////////////////////////////////////////////////



// update the transverse image on the image view
- (IBAction)updateTransverseSectionPosition:(id)sender {
    [self setTransverseSectionPosition:0.5];
    
    // ***** the following are the ways I tried to get the resource image when the plugin were running, but none of them works *****
    
    /*
    //NSString* imageName = [[NSBundle mainBundle] pathForResource:@"vessel" ofType:@"jpg"];
    //NSImage* vesselImage = [[NSImage alloc] initWithContentsOfFile:imageName];
    
    //NSImage* vesselImage = [NSImage imageNamed:@"vessel"];
    NSImage *vesselImage = [[NSImage alloc] initWithContentsOfFile:@"/Users/wb-vesselwall/Documents/Projects/Practice1/CPR001.tiff"];
    
    [_vesselImageView setImage:vesselImage];
    if (vesselImage == nil) {
        NSLog(@"vesselImage == nil\n");
    } else {
        NSLog(@"vesselImage != nil\n");
    }
     */
    
}




// given a certain step length, save all the transverse images on the current curvedPath to a folder
- (IBAction)saveTransverseImages:(id)sender {
    CPRTransverseView *middleTransverseView = _cprController.middleTransverseView;
    CPRCurvedPath *curvedPath = middleTransverseView.curvedPath;
    curvedPath.transverseSectionPosition = 0;
    
    CGFloat length = _cprController.curvedPath.bezierPath.length;
    float stepLength = 1.0f;
    if (_textFieldStepLength.floatValue > 0) {
        stepLength = _textFieldStepLength.floatValue;
    }
    int numImages = (int) (length / stepLength);
    NSString *numImagesString = [NSString stringWithFormat:@"%d  ", numImages];
    
    
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *dirURL = [[panel URLs] objectAtIndex:0];
            NSString *dirURLString = dirURL.path;
            
            for (int i = 0; i < numImages; i++) {
                NSImage *curImage = [self setTransverseSectionPosition:((1.0 * i) / numImages)];
                
                NSString *positionString = [NSString stringWithFormat:@"%f  ", ((1.0 * i) / numImages)];
                
                NSString *idxWithFormat = [NSString stringWithFormat:@"%03d", i+1];
                NSString *curFileName = [NSString stringWithFormat:[dirURLString stringByAppendingString:[NSString stringWithFormat:@"/CPR%@.tiff", idxWithFormat]]];
                NSLog(curFileName);
                [[curImage TIFFRepresentation] writeToFile:curFileName atomically:YES];
            }
        }
    }];
    
}


// save one curImage with an idx number
- (void) saveTransverseImage:(NSImage*)curImage index:(int) idx; {
    
    NSString *idxWithFormat = [NSString stringWithFormat:@"%03d", idx+1];
    NSString *curFileName = [NSString stringWithFormat:@"/Users/wb-vesselwall/Documents/osirix_transverse/CPR%@.tiff", idxWithFormat];
    [[curImage TIFFRepresentation] writeToFile:curFileName atomically:YES];
}




// init the three arrays and plot the graph
- (IBAction)drawPlotWithImageView:(id)sender {
    [_objcWrapper initArrays];
    
    /*
    IplImage *cvPlotImage2 = [_objcWrapper getPlot:2];
    NSImage *plotImage2 = [self imageWithCVImage:cvPlotImage2];
    [_imageView2 setImage:plotImage2];
    _curPlotImage2 = plotImage2;
    
    IplImage *cvPlotImage0 = [_objcWrapper getPlot:0];
    NSImage *plotImage0 = [self imageWithCVImage:cvPlotImage0];
    [_imageView3 setImage:plotImage0];
    _curPlotImage0 = plotImage0;
    
    IplImage *cvPlotImage1 = [_objcWrapper getPlot:1];
    NSImage *plotImage1 = [self imageWithCVImage:cvPlotImage1];
    [_imageView4 setImage:plotImage1];
    _curPlotImage1 = plotImage1;
     */
    
    
    _slider2.floatValue = _slider2.maxValue / 2;
    _slider3.floatValue = _slider3.maxValue / 2;
    _slider4.floatValue = _slider4.maxValue / 2;
    [self sliderValueChanged:_slider2.maxValue / 2];
    
}




// move the transverseSectionPosition on the current curvedPath
- (IBAction)slider2ValueChanged:(id)sender {
    float pos = _slider2.floatValue;
    _slider3.floatValue = pos;
    _slider4.floatValue = pos;
    [self sliderValueChanged:pos];
}

- (IBAction)slider3ValueChanged:(id)sender {
    float pos = _slider3.floatValue;
    _slider2.floatValue = pos;
    _slider4.floatValue = pos;
    [self sliderValueChanged:pos];
}

- (IBAction)slider4ValueChanged:(id)sender {
    float pos = _slider4.floatValue;
    _slider3.floatValue = pos;
    _slider2.floatValue = pos;
    [self sliderValueChanged:pos];
}




// sychronize everything when slider value changed
- (void)sliderValueChanged:(float)pos {
    IplImage* cvPlotImage2 = [_objcWrapper getPlotWithLineOfIdx:2 atPosition:pos];
    NSImage *plotImage2 = [self imageWithCVImage:cvPlotImage2];
    [_imageView2 setImage:plotImage2];
    _curPlotImage2 = plotImage2;
    
    IplImage* cvPlotImage0 = [_objcWrapper getPlotWithLineOfIdx:0 atPosition:pos];
    NSImage *plotImage0 = [self imageWithCVImage:cvPlotImage0];
    [_imageView3 setImage:plotImage0];
    _curPlotImage0 = plotImage0;
    
    IplImage* cvPlotImage1 = [_objcWrapper getPlotWithLineOfIdx:1 atPosition:pos];
    NSImage *plotImage1 = [self imageWithCVImage:cvPlotImage1];
    [_imageView4 setImage:plotImage1];
    _curPlotImage1 = plotImage1;
    
    [self setTransverseSectionPosition:(pos / _slider2.maxValue)];
}






// set transverseSectionPosition to newPos and update the related images
- (NSImage*) setTransverseSectionPosition:(CGFloat)newPos {
    CPRTransverseView *middleTransverseView = _cprController.middleTransverseView;
    CPRCurvedPath *curvedPath = middleTransverseView.curvedPath;
    
    //transverseSectionPosition = MIN(MAX(_curvedPath.transverseSectionPosition + [theEvent deltaY] * .002, 0.0), 1.0);
    if ([middleTransverseView.delegate respondsToSelector:@selector(CPRViewWillEditCurvedPath:)]) {;
        [middleTransverseView.delegate CPRViewWillEditCurvedPath:middleTransverseView];
    }
    curvedPath.transverseSectionPosition = newPos;
    if ([middleTransverseView.delegate respondsToSelector:@selector(CPRViewDidEditCurvedPath:)])  {
        [middleTransverseView.delegate CPRViewDidEditCurvedPath:middleTransverseView];
    }
    [middleTransverseView _sendNewRequest];
    [middleTransverseView setNeedsDisplay:YES];
    
    _curTransverseImage = [middleTransverseView.curDCM image];
    [_imageView1 setImage:_curTransverseImage];
    
    NSString *positionStr = [NSString stringWithFormat: @"%.3lf    ", curvedPath.transverseSectionPosition];
    
    return _curTransverseImage;
}


- (NSImage*) moveTransverseImageWithStepLength:(CGFloat)stepLength {
    CGFloat curPos = _cprController.middleTransverseView.curvedPath.transverseSectionPosition;
    return [self setTransverseSectionPosition:(curPos + stepLength)];
}





// convert IplImage* to NSImage*
- (NSImage *)imageWithCVImage:(IplImage *)iplImage {
    NSBitmapImageRep *bmp= [[NSBitmapImageRep alloc]
                            initWithBitmapDataPlanes:0
                            pixelsWide:iplImage->width
                            pixelsHigh:iplImage->height
                            bitsPerSample:iplImage->depth
                            samplesPerPixel:iplImage->nChannels
                            hasAlpha:NO isPlanar:NO
                            colorSpaceName:NSDeviceRGBColorSpace
                            bytesPerRow:iplImage->widthStep
                            bitsPerPixel:0];
    NSUInteger val[3]= {0, 0, 0};
    for(int x=0; x < iplImage->width; x++) {
        for(int y=0; y < iplImage->height; y++) {
            CvScalar scal= cvGet2D(iplImage, y, x);
            val[0]= scal.val[2];
            val[1]= scal.val[1];
            val[2]= scal.val[0];
            [bmp setPixel:val atX:x y:y];
        }
    }
    NSImage *im= [[NSImage alloc] initWithData:[bmp TIFFRepresentation]];
    return [im autorelease];
}










// find path automatically
/////////////////////////////////////////////////////////////////////////////////////////////////////



// find the path automatically (not very robust)
- (IBAction)findPath:(id)sender {
    if( [_cprController.curvedPath.nodes count] > 1 && [_cprController.curvedPath.nodes count] <= 5) {
        [self assistedCurvedPath];
    } else {
        NSRunAlertPanel(NSLocalizedString(@"Path Assistant error", nil), NSLocalizedString(@"Path Assistant requires at least 2 points, and no more than 5 points. Use the Curved Path tool to define at least two points.", nil), NSLocalizedString(@"OK", nil), nil, nil);
    }
}





// main part of findPath
- (void) assistedCurvedPath {
    
    /*
     
     if( [_cprController.curvedPath.nodes count] > 1 && [_cprController.curvedPath.nodes count] <= 5)
     [_cprController assistedCurvedPath:nil];
     else
     NSRunAlertPanel(NSLocalizedString(@"Path Assistant error", nil), NSLocalizedString(@"Path Assistant requires at least 2 points, and no more than 5 points. Use the Curved Path tool to define at least two points.", nil), NSLocalizedString(@"OK", nil), nil, nil);
     */
    
    
    int dim[3];
    NSMutableArray *pix = [_viewerController pixList];
    DCMPix* firstObject = [pix objectAtIndex:0];
    dim[0] = [firstObject pwidth];
    dim[1] = [firstObject pheight];
    dim[2] = [pix count];
    float spacing[3];
    spacing[0]=[firstObject pixelSpacingX];
    spacing[1]=[firstObject pixelSpacingY];
    float sliceThickness = [firstObject sliceInterval];
    if( sliceThickness == 0)
    {
        NSLog(@"Slice interval = slice thickness!");
        sliceThickness = [firstObject sliceThickness];
    }
    spacing[2]=sliceThickness;
    float resamplesize=spacing[0];
    
    if(dim[0]>256 || dim[1]>256)
    {
        if(spacing[0]*(float)dim[0]>spacing[1]*(float)dim[1])
            resamplesize = spacing[0]*(float)dim[0]/256.0;
        else {
            resamplesize = spacing[1]*(float)dim[1]/256.0;
        }
        
    }
    
    NSData *volume = [_viewerController volumeData];
    
    FlyAssistant2 *assistant = [[FlyAssistant2 alloc] initWithVolume:(float*)[volume bytes] WidthDimension:dim Spacing:spacing ResampleVoxelSize:resamplesize];
    [assistant setCenterlineResampleStepLength:3.0];
    assistant.thresholdRange = _textField1.floatValue;
    
    NSMutableArray *centerline = [[NSMutableArray alloc] init];
    
    CPRVolumeData *cprVolumeData = [[CPRVolumeData alloc] initWithWithPixList:pix volume:volume];
    
    
    unsigned int nodeCount = [_cprController.curvedPath.nodes count];
    if ( nodeCount > 1)
    {
        WaitRendering* waiting = [[[WaitRendering alloc] init:NSLocalizedString(@"Finding Path...", nil)] autorelease];
        [waiting showWindow:self];
        N3AffineTransform patient2VolumeDataTransform = cprVolumeData.volumeTransform;
        N3AffineTransform volumeData2PatientTransform = N3AffineTransformInvert(patient2VolumeDataTransform);
        
        CPRCurvedPath * newCP = [[[CPRCurvedPath alloc] init] autorelease];
        N3Vector node;
        OSIVoxel * pt;
        
        for (unsigned int i = 0; i < nodeCount - 1; ++i)
        {
            N3Vector na = N3VectorApplyTransform([[_cprController.curvedPath.nodes objectAtIndex:i] N3VectorValue], patient2VolumeDataTransform);
            N3Vector nb = N3VectorApplyTransform([[_cprController.curvedPath.nodes objectAtIndex:i+1] N3VectorValue], patient2VolumeDataTransform);
            
            Point3D *pta = [[[Point3D alloc] initWithX:na.x y:na.y z:na.z] autorelease];
            Point3D *ptb = [[[Point3D alloc] initWithX:nb.x y:nb.y z:nb.z] autorelease];
            NSLog(@"pta: %f   %f   %f\n", pta.x, pta.y, pta.z);
            NSLog(@"ptb: %f   %f   %f\n", ptb.x, ptb.y, ptb.z);
            
            [centerline removeAllObjects];
            
            int err = [assistant createCenterline:centerline FromPointA:pta ToPointB:ptb withSmoothing:NO];
            if(!err)
            {
                unsigned int lineCount = [centerline count] - 1;
                for( unsigned int i = 0; i < lineCount ; ++i)
                {
                    pt = [centerline objectAtIndex:i];
                    node.x = pt.x;
                    node.y = pt.y;
                    node.z = pt.z;
                    [newCP addPatientNode:N3VectorApplyTransform(node, volumeData2PatientTransform)];
                }
            }
            else if(err == ERROR_NOENOUGHMEM)
            {
                NSRunAlertPanel(NSLocalizedString(@"32-bit", nil), NSLocalizedString(@"Path Assistant can not allocate enough memory, try to increase the resample voxel size in the settings.", nil), NSLocalizedString(@"OK", nil), nil, nil);
            }
            else if(err == ERROR_CANNOTFINDPATH)
            {
                NSRunAlertPanel(NSLocalizedString(@"Can't find path", nil), NSLocalizedString(@"Path Assistant can not find a path from A to B.", nil), NSLocalizedString(@"OK", nil), nil, nil);
            }
            else if(err==ERROR_DISTTRANSNOTFINISH)
            {
                [waiting close];
                waiting = [[[WaitRendering alloc] init:NSLocalizedString(@"Distance Transform...", nil)] autorelease];
                [waiting showWindow:self];
                
                for(unsigned int i=0; i<5; i++)
                {
                    [centerline removeAllObjects];
                    err= [assistant createCenterline:centerline FromPointA:pta ToPointB:ptb withSmoothing:NO];
                    if(err!=ERROR_DISTTRANSNOTFINISH)
                        break;
                    
                    for(unsigned int i=0;i<[centerline count] - 1;i++)
                    {
                        pt = [centerline objectAtIndex:i];
                        node.x = pt.x;
                        node.y = pt.y;
                        node.z = pt.z;
                        [newCP addPatientNode:N3VectorApplyTransform(node, volumeData2PatientTransform)];
                    }
                }
                if(err==ERROR_CANNOTFINDPATH)
                {
                    NSRunAlertPanel(NSLocalizedString(@"Can't find path", nil), NSLocalizedString(@"Path Assistant can not find a path from current location.", nil), NSLocalizedString(@"OK", nil), nil, nil);
                    [waiting close];
                    return;
                }
                else if(err==ERROR_DISTTRANSNOTFINISH)
                {
                    NSRunAlertPanel(NSLocalizedString(@"Unexpected error", nil), NSLocalizedString(@"Path Assistant failed to initialize!", nil), NSLocalizedString(@"OK", nil), nil, nil);
                    [waiting close];
                    return;
                }
            }
        }
        pt = [centerline lastObject];
        node.x = pt.x;
        node.y = pt.y;
        node.z = pt.z;
        [newCP addPatientNode:N3VectorApplyTransform(node, volumeData2PatientTransform)];
        
        
        if ([_mprView2.delegate respondsToSelector:@selector(CPRViewWillEditCurvedPath:)]) {;
            [_mprView2.delegate CPRViewWillEditCurvedPath:_mprView2];
        }
        
        _cprController.mprView2.curvedPath = newCP;
        
        if ([_mprView2.delegate respondsToSelector:@selector(CPRViewDidEditCurvedPath:)])  {
            [_mprView2.delegate CPRViewDidEditCurvedPath:_mprView2];
        }
        
        [_cprController updateCurvedPathCost];
        //[pathSimplificationSlider setDoubleValue:[pathSimplificationSlider maxValue]];
        
        _cprController.mprView1.curvedPath = _cprController.curvedPath;
        _cprController.mprView2.curvedPath = _cprController.curvedPath;
        _cprController.mprView3.curvedPath = _cprController.curvedPath;
        _cprController.cprView.curvedPath = _cprController.curvedPath;
        _cprController.topTransverseView.curvedPath = _cprController.curvedPath;
        _cprController.middleTransverseView.curvedPath = _cprController.curvedPath;
        _cprController.bottomTransverseView.curvedPath = _cprController.curvedPath;
        
        [waiting close];
    }
    else {
        NSLog(@"Not enough points to launch assistant");
    }
    
    [_cprController willChangeValueForKey: @"onSliderEnabled"];
    [_cprController didChangeValueForKey: @"onSliderEnabled"];
}















//PDF
//////////////////////////////////////////////////////////////////////////////////////////////////////////////



// create a PDF report with the current data and images
- (IBAction)createPDFFile:(id)sender {
    //CGRect pageRect1 = CGRectMake(0, 0, 2550, 3300);
    //const char *filename1 = "/Users/wb-vesselwall/Documents/Projects/Practice1/Practice1/files/file1.pdf";
    //[self createPDFFileWithRect:pageRect1 withFilname:filename1];
    
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@"report1.pdf"];
    // display the panel
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            
            // the size of the PDF page
            // (x, y, width, height)
            CGRect pageRect1 = CGRectMake(0, 0, 2550, 3300);
            NSURL *saveURL = [panel URL];
            
            [self createPDFFileWithRect:pageRect1 withSaveURL:saveURL];
        }
    }];
}



// the main method to draw and save the PDF file
- (void)createPDFFileWithRect:(CGRect)pageRect withSaveURL:(NSURL*)saveURL {
    CGContextRef pdfContext;
    //CFStringRef path;
    CFURLRef url;
    url = CFBridgingRetain(saveURL);
    
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    
    //path = CFStringCreateWithCString (NULL, filename, kCFStringEncodingUTF8);
    //url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    //CFRelease (path);
    
    myDictionary = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
    pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
    CFRelease(myDictionary);
    CFRelease(url);
    pageDictionary = CFDictionaryCreateMutable(NULL, 0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    boxData = CFDataCreate(NULL,(const UInt8 *)&pageRect, sizeof (CGRect));
    CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
    CGPDFContextBeginPage (pdfContext, pageDictionary);
    
    
    CGRect titleRect = CGRectMake(1200, 3000, 900, 100);
    [self drawTextWithContext:pdfContext withRect:titleRect withFontSize:80.0f withString:@"Report"];
    
    //myDrawContent (pdfContext);
    NSString *text1 = @"Patient Info";
    CGRect textRect1 = CGRectMake(200, 2800, 900, 100);
    [self drawTextWithContext:pdfContext withRect:textRect1 withFontSize:50.0f withString:text1];
    
    
    NSString *patientName = @"******";
    int patientAge = 100;
    NSString *patientGender = @"Male";
    NSString *patientPhysician = @"******";
    
    NSString *text2 = [NSString stringWithFormat:@"Name: %@       Age: %d       Gender: %@       Physician: %@", patientName, patientAge, patientGender, patientPhysician];
    CGRect textRect2 = CGRectMake(300, 2700, 1900, 100);
    [self drawTextWithContext:pdfContext withRect:textRect2 withFontSize:40.0f withString:text2];
    
    
    //NSString *text3 = [NSString stringWithFormat:@"curTransverseSectionPosition: %f", _cprController.curvedPath.transverseSectionPosition];
    
    NSString *text3 = @"Lesion1";
    CGRect textRect3 = CGRectMake(200, 2500, 900, 100);
    [self drawTextWithContext:pdfContext withRect:textRect3 withFontSize:50.0f withString:text3];
    
    
    CGRect imgRect1 = CGRectMake(300, 2000, 400, 400);
    [self drawImageWithContext:pdfContext withRect:imgRect1 withImage:_vesselImageView.image];
    
    CGRect imgRect2 = CGRectMake(800, 2000, 400, 400);
    [self drawImageWithContext:pdfContext withRect:imgRect2 withImage:_imageView1.image];
    
    CGRect imgRect3 = CGRectMake(1300, 2000, 720, 420);
    [self drawImageWithContext:pdfContext withRect:imgRect3 withImage:[_cprController.cprView.curDCM image]];
    
    
    NSString *vesselFigText = @"Lesion Location";
    CGRect vesselFigTextRect = CGRectMake(400, 1850, 400, 100);
    [self drawTextWithContext:pdfContext withRect:vesselFigTextRect withFontSize:30.0f withString:vesselFigText];
    
    NSString *transverseFigText = @"Transverse Image";
    CGRect transverseFigTextRect = CGRectMake(900, 1850, 400, 100);
    [self drawTextWithContext:pdfContext withRect:transverseFigTextRect withFontSize:30.0f withString:transverseFigText];
    
    NSString *cprFigText = @"CPR Image";
    CGRect cprFigTextRect = CGRectMake(1550, 1850, 400, 100);
    [self drawTextWithContext:pdfContext withRect:cprFigTextRect withFontSize:30.0f withString:cprFigText];
    
    
    
    CGRect imgRect4 = CGRectMake(300, 1300, 600, 450);
    [self drawImageWithContext:pdfContext withRect:imgRect4 withImage:_imageView2.image];
    
    CGRect imgRect5 = CGRectMake(1000, 1300, 600, 450);
    [self drawImageWithContext:pdfContext withRect:imgRect5 withImage:_imageView3.image];
    
    CGRect imgRect6 = CGRectMake(1700, 1300, 600, 450);
    [self drawImageWithContext:pdfContext withRect:imgRect6 withImage:_imageView4.image];
    
    
    NSString *nwiFigText = @"Normalized Wall Index";
    CGRect nwiFigTextRect = CGRectMake(450, 1150, 400, 100);
    [self drawTextWithContext:pdfContext withRect:nwiFigTextRect withFontSize:30.0f withString:nwiFigText];
    
    NSString *waFigText = @"Wall Area";
    CGRect waFigTextRect = CGRectMake(1250, 1150, 400, 100);
    [self drawTextWithContext:pdfContext withRect:waFigTextRect withFontSize:30.0f withString:waFigText];
    
    NSString *laFigText = @"Lumen Area";
    CGRect laFigTextRect = CGRectMake(1950, 1150, 400, 100);
    [self drawTextWithContext:pdfContext withRect:laFigTextRect withFontSize:30.0f withString:laFigText];
    
    
    int size = [_objcWrapper getSize];
    int idx = _cprController.curvedPath.transverseSectionPosition * size;
    
    float nwi = [_objcWrapper getValueWithArray:2 atIndex:idx];
    float wa = [_objcWrapper getValueWithArray:0 atIndex:idx];
    float la = [_objcWrapper getValueWithArray:1 atIndex:idx];
    
    NSString *dataText = [NSString stringWithFormat:@"Normalized Wall Index: %f \nWall Area: %f \nLumen Area: %f", nwi, wa, la];
    CGRect dataTextRect = CGRectMake(300, 700, 900, 400);
    [self drawTextWithContext:pdfContext withRect:dataTextRect withFontSize:50.0f withString:dataText];
    
    
    CGPDFContextEndPage (pdfContext);
    CGContextRelease (pdfContext);
    CFRelease(pageDictionary);
    CFRelease(boxData);
}




// draw text on pdfContext
- (void)drawTextWithContext:(CGContextRef)pdfContext withRect:(CGRect)textRect withFontSize:(float)fontSize withString:(NSString*)inputString {
    
    // Set the text matrix.
    CGContextSetTextMatrix(pdfContext, CGAffineTransformIdentity);
    
    // Create a path which bounds the area where you will be drawing text.
    // The path need not be rectangular.
    CGMutablePathRef textPath = CGPathCreateMutable();
    
    // In this simple example, initialize a rectangular path.
    CGPathAddRect(textPath, NULL, textRect);
    
    CFStringRef textString = (__bridge CFStringRef)inputString;
    // Create a mutable attributed string with a max length of 0.
    // The max length is a hint as to how much internal storage to reserve.
    // 0 means no hint.
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    
    // Copy the textString into the newly created attrString
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), textString);
    
    
    /*
     // Create a color that will be added as an attribute to the attrString.
     CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
     CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
     CGColorRef red = CGColorCreate(rgbColorSpace, components);
     CGColorSpaceRelease(rgbColorSpace);
     
     // Set the color of the first 12 chars to red.
     CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red);
     */
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)@"Helvetica", fontSize, nil);
    CFAttributedStringSetAttribute(attrString,CFRangeMake(0, inputString.length),kCTFontAttributeName,font);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRelease(attrString);
    
    // Create a frame.
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), textPath, NULL);
    
    // Draw the specified frame in the given context.
    CTFrameDraw(frame, pdfContext);
    
    CFRelease(frame);
    CFRelease(textPath);
    CFRelease(framesetter);
    
}



// draw a image on pdfContext
- (void)drawImageWithContext:(CGContextRef)pdfContext withRect:(CGRect)imgRect withImage:(NSImage*)img {
    
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)[img TIFFRepresentation], NULL);
    CGImageRef imgRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    CGContextDrawImage(pdfContext, imgRect, imgRef);
}









//exportJSON & importJSON
////////////////////////////////////////////////////////////////////////////////////////////


// export current information to a json file (mainly the information of the curvedPath)
- (IBAction)exportJSON:(id)sender {
    NSArray *nodes = _cprController.curvedPath.nodes;
    NSMutableArray *nodesArr = [[NSMutableArray alloc] init];
    
    for (NSValue *nodeValue in nodes) {
        N3Vector node = [nodeValue N3VectorValue];
        NSArray *nodeArr = @[@(node.x), @(node.y), @(node.z)];
        [nodesArr addObject:nodeArr];
    }
    NSDictionary *inventory = @{@"patientID" : @"00001",
                                @"time" : [self getCurrentTime],
                                @"nodes" : nodesArr,
                                @"curTransverseSectionPosition" : @(_cprController.curvedPath.transverseSectionPosition)
                                };
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inventory options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:@"record1.txt"];
    // display the panel
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *saveURL = [panel URL];
            [jsonString writeToURL:saveURL atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
        }
    }];
}

// import the history records and the curvedPath will be restored
- (IBAction)importJSON:(id)sender {
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  openURL = [[panel URLs] objectAtIndex:0];
            NSString *jsonString = [[NSString alloc] initWithContentsOfURL:openURL encoding:NSUTF8StringEncoding error:nil];
            [self parseJSON:jsonString];
        }
    }];
    
}


// get current local time
- (NSString*)getCurrentTime {
    NSLocale* currentLocale = [NSLocale currentLocale];
    [[NSDate date] descriptionWithLocale:currentLocale];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *curTime = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",curTime);
    return curTime;
}


// parse the imported JSON string
- (void) parseJSON:(NSString*)jsonString {
    NSError* error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonDict = [NSJSONSerialization
                              JSONObjectWithData:jsonData
                              options:kNilOptions
                              error:&error];
    NSMutableArray *nodesArr = jsonDict[@"nodes"];
    [self addNodesWithNodesArray:nodesArr];
}


// add an array of nodes to curvedPath
- (void) addNodesWithNodesArray:(NSMutableArray*)nodesArr {
    _mprView2 = _cprController.mprView2;
    
    // add this line when creating a new curved path
    [_mprView2 stopCurvedPathCreationMode];
    
    CPRController *windowController = [_mprView2 windowController];
    if( windowController.curvedPathCreationMode == NO && windowController.curvedPath.nodes.count == 0)
        windowController.curvedPathCreationMode = YES;
    
    if (windowController.curvedPathCreationMode) {
        
        if ([_mprView2.delegate respondsToSelector:@selector(CPRViewWillEditCurvedPath:)]) {;
            [_mprView2.delegate CPRViewWillEditCurvedPath:_mprView2];
        }
        for (int i = 0; i < nodesArr.count; i++) {
            N3Vector nodeVec = N3VectorMake([nodesArr[i][0] doubleValue], [nodesArr[i][1] doubleValue], [nodesArr[i][2] doubleValue]);
            [_mprView2.curvedPath addPatientNode:nodeVec];
        }
        
        if ([_mprView2.delegate respondsToSelector:@selector(CPRViewDidEditCurvedPath:)])  {
            [_mprView2.delegate CPRViewDidEditCurvedPath:_mprView2];
        }
        [_mprView2 setNeedsDisplay:YES];
        
        // Center the views to the last point
        //[windowController CPRView:_mprView2 setCrossCenter:newCrossCenter];
    }
}


















// unused methods



/*
- (IBAction)testShowInfo:(id)sender {
    
    //NSUInteger size = [_cprController.topTransverseView.dcmPixList count];
    CPRTransverseView *middleTransverseView = _cprController.middleTransverseView;
    NSMutableArray *middleDCMPixList = middleTransverseView.dcmPixList; // 1
    DCMPix *middleCurDCM = middleTransverseView.curDCM;
    NSArray *middleCurPixArray = middleCurDCM.pixArray; // 2
    NSArray *middleDCMFilesList = middleTransverseView.dcmFilesList; // 3
    NSMutableArray *pixList = _viewerController.pixList;  // 4
    
    CPRView *cprView = _cprController.cprView;
    DCMPix *cprCurDCM = cprView.curDCM;
    NSArray *cprCurPixArray = cprCurDCM.pixArray; // 5
    
    
    NSInteger size1 = [middleDCMPixList count];
    NSInteger size2 = [middleCurPixArray count];
    NSInteger size3 = [middleDCMFilesList count];
    NSInteger size4 = [pixList count];
    NSInteger size5 = [cprCurPixArray count];
    
    NSString *sizeStr1 = [NSString stringWithFormat: @"%ld", (long)size1];
    NSString *sizeStr2 = [NSString stringWithFormat: @"%ld", (long)size2];
    NSString *sizeStr3 = [NSString stringWithFormat: @"%ld", (long)size3];
    NSString *sizeStr4 = [NSString stringWithFormat: @"%ld", (long)size4];
    NSString *sizeStr5 = [NSString stringWithFormat: @"%ld", (long)size5];
    
    NSString * result1 = [[middleDCMPixList valueForKey:@"description"] componentsJoinedByString:@""];
    NSString * result2 = [[middleCurPixArray valueForKey:@"description"] componentsJoinedByString:@""];
    NSString * result3 = [[middleDCMFilesList valueForKey:@"description"] componentsJoinedByString:@""];
    NSString * result4 = [[pixList valueForKey:@"description"] componentsJoinedByString:@""];
    NSString * result5 = [[cprCurPixArray valueForKey:@"description"] componentsJoinedByString:@""];
    
    NSImage *image1 = [middleCurDCM image];
    
    [_textView1 setString:[_textView1.string stringByAppendingString:sizeStr2]];
    [_textView2 setString:[_textView2.string stringByAppendingString:result2]];
    [_textView2 setString:[_textView2.string stringByAppendingString:@"\n\n"]];
    
    //[_imageView1 setImage:image1];
    
}
 */








- (IBAction)drawPlotWithCVNamedWindow:(id)sender {
    [_objcWrapper showPlot];
}





- (IBAction)invertImage:(id)sender {
    long			i, x, z;
    float			*fImage;
    unsigned char   *rgbImage;
    
    
    // Display a waiting window
    id waitWindow = [_viewerController startWaitWindow:@"Inverting..."];
    
    // Contains a list of DCMPix objects: they contain the pixels of current series
    //NSArray		*pixList = [viewerController pixList: z];
    DCMPix		*curPix;
    
    // Loop through all images contained in the current series
    
    //curPix = [pixList objectAtIndex: i];
    curPix = _cprView.curDCM;
    
    // fImage is a pointer on the pixels, ALWAYS represented in float (float*) or in ARGB (unsigned char*)
    
    if( [curPix isRGB])
    {
        rgbImage = (unsigned char*) [curPix fImage];
        
        x = [curPix pheight] * [curPix pwidth] / 4;
        
        while ( x-- > 0)
        {
            rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            
            rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            
            rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            
            rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
            *rgbImage = 255-*rgbImage;		rgbImage++;
        }
    }
    else
    {
        
        fImage = [curPix fImage];
        
        x = [curPix pheight] * [curPix pwidth]/4;
        
        while ( x-- > 0)
        {
            *fImage = -*fImage;
            fImage++;
            *fImage = -*fImage;
            fImage++;
            *fImage = -*fImage;
            fImage++;
            *fImage = -*fImage;
            fImage++;
        }
    }
    
    // Close the waiting window
    [_viewerController endWaitWindow: waitWindow];
    
    // Update the current displayed WL & WW : we just inverted the image -> invert the WL !
    {
        
        float wl, ww;
        
        [_cprView getWLWW: &wl :&ww];
        if( [curPix isRGB]) wl = 255-wl;
        else wl = -wl;
        [_cprView setWLWW: wl :ww];
    }
    // We modified the pixels: OsiriX please update the display!
    [_viewerController needsDisplayUpdate];
}











- (IBAction)addNode:(id)sender {
    _mprView2 = _cprController.mprView2;
    
    
    // test //
    
    /*
    if (!_mprView2.curvedPath) {
        [_textView2 setString:[_textView2.string stringByAppendingString:@"_mprView2.curvedPath == nil\n"]];
    } else {
        [_textView2 setString:[_textView2.string stringByAppendingString:@"_mprView2.curvedPath != nil\n"]];
    }
    NSArray* nodes = _mprView2.curvedPath.nodes;
    if (!nodes) {
        [_textView2 setString:[_textView2.string stringByAppendingString:@"nodes == nil\n"]];
    } else {
        [_textView2 setString:[_textView2.string stringByAppendingString:@"nodes != nil\n"]];
    }
    int nodeCount = nodes.count;
    NSValue *pointValue1 = nodes[0];
    N3Vector point1 = pointValue1.N3VectorValue;
    [_textView2 setString:[_textView2.string stringByAppendingString:[NSString stringWithFormat:@"nodes.count: %d\n", nodeCount]]];
    [_textView2 setString:[_textView2.string stringByAppendingString:[NSString stringWithFormat:@"%f  %f  %f\n", point1.x, point1.y, point1.z]]];
     */
    
    // end test //
    
    
    
    // add this line when creating a new curved path
    [_mprView2 stopCurvedPathCreationMode];
    
    CPRController *windowController = [_mprView2 windowController];
    if( windowController.curvedPathCreationMode == NO && windowController.curvedPath.nodes.count == 0)
        windowController.curvedPathCreationMode = YES;
    
    NSPoint mouseLocation = {550, 150};
    
    if (windowController.curvedPathCreationMode) {
        
        N3AffineTransform viewToDicomTransform = N3AffineTransformConcat([_mprView2 viewToPixTransform], [_mprView2 pixToDicomTransform]);
        N3Vector newCrossCenter = N3VectorApplyTransform(N3VectorMakeFromNSPoint(mouseLocation), viewToDicomTransform);
        
        //[_textView3 setString:[_textView3.string stringByAppendingString:[NSString stringWithFormat:@"%f   %f   %f\n", newCrossCenter.x, newCrossCenter.y, newCrossCenter.z]]];
        /*
         [_mprView2 sendWillEditCurvedPath];
         
         //[_curvedPath addNode:mouseLocation transform:viewToDicomTransform];
         
         N3Vector node = N3VectorMake(20, 10, 10);
         [_curvedPath addPatientNode:node];
         
         [_mprView2 sendDidUpdateCurvedPath];
         [_mprView2 sendDidEditCurvedPath];
         [_mprView2 setNeedsDisplay:YES];
         */
        
        if ([_mprView2.delegate respondsToSelector:@selector(CPRViewWillEditCurvedPath:)]) {;
            [_mprView2.delegate CPRViewWillEditCurvedPath:_mprView2];
        }
        N3Vector node1 = N3VectorMake(50, 0, 0);
        N3Vector node2 = N3VectorMake(0, 50, 0);
        N3Vector node3 = N3VectorMake(0, 0, 50);
        [_mprView2.curvedPath addPatientNode:node1];
        [_mprView2.curvedPath addPatientNode:node2];
        [_mprView2.curvedPath addPatientNode:node3];
        
        if ([_mprView2.delegate respondsToSelector:@selector(CPRViewDidEditCurvedPath:)])  {
            [_mprView2.delegate CPRViewDidEditCurvedPath:_mprView2];
        }
        [_mprView2 setNeedsDisplay:YES];
        
        // Center the views to the last point
        //[windowController CPRView:_mprView2 setCrossCenter:newCrossCenter];
    }
    
    
    
    // mouseUp
    /*
     [NSObject cancelPreviousPerformRequestsWithTarget: windowController selector:@selector(delayedFullLODRendering:) object: nil];
     
     windowController.lowLOD = NO;
     
     [_mprView2 restoreCamera];
     
     [windowController propagateWLWW: _mprView2];
     for( ROI *r in _mprView2.curRoiList)
     {
     if( [r type] == t2DPoint && r.parentROI == nil)
     {
     float location[ 3];
     [_mprView2.pix convertPixX: r.rect.origin.x pixY: r.rect.origin.y toDICOMCoords: location pixelCenter: YES];
     [_mprView2 add2DPoint: location];
     }
     }
     [_mprView2 detect2DPointInThisSlice];
     */
}





@end
