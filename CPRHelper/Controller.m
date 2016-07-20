//
//  Controller.m
//  CPRHelper
//
//  Created by WB-Vessel Wall on 6/23/16.
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
 


@synthesize textView1 = _textView1;
@synthesize textView2 = _textView2;
@synthesize textView3 = _textView3;
@synthesize textView4 = _textView4;
@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize imageView4 = _imageView4;
@synthesize slider2 = _slider2;
@synthesize slider3 = _slider3;
@synthesize slider4 = _slider4;

@synthesize objcWrapper = _objcWrapper;



- (id) init: (CPRHelperFilter*) f
{
    _filter = f;
    self = [super initWithWindowNibName:@"CPRHelperWindow"];
    [[self window] setDelegate:self];   //In order to receive the windowWillClose notification
    
    _objcWrapper = [[ObjcWrapper alloc] init];
    
    return self;    
}

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


- (IBAction)changeTransverseSectionPosition:(id)sender {
    [self moveTransverseImageWithStepLength:0.01];
}





- (IBAction)saveTransverseImages:(id)sender {
    CPRTransverseView *middleTransverseView = _cprController.middleTransverseView;
    CPRCurvedPath *curvedPath = middleTransverseView.curvedPath;
    curvedPath.transverseSectionPosition = 0;
    
    for (int i = 0; i < 100; i++) {
        NSImage *curImage = [self setTransverseSectionPosition:0.01 * i];
        [self saveTransverseImage:curImage index:i];
    }
}





- (IBAction)drawPlotWithCVNamedWindow:(id)sender {
    [_objcWrapper showPlot];
}



- (IBAction)drawPlotWithImageView:(id)sender {
    [_objcWrapper initArrays];
    
    IplImage *cvPlotImage2 = [_objcWrapper getPlot:2];
    NSImage *plotImage2 = [self imageWithCVImage:cvPlotImage2];
    [_imageView2 setImage:plotImage2];
    
    IplImage *cvPlotImage0 = [_objcWrapper getPlot:0];
    NSImage *plotImage0 = [self imageWithCVImage:cvPlotImage0];
    [_imageView3 setImage:plotImage0];
    
    IplImage *cvPlotImage1 = [_objcWrapper getPlot:1];
    NSImage *plotImage1 = [self imageWithCVImage:cvPlotImage1];
    [_imageView4 setImage:plotImage1];
}





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
    
    // add this line when create a new curved path
    [_mprView2 stopCurvedPathCreationMode];
    
    CPRController *windowController = [_mprView2 windowController];
    if( windowController.curvedPathCreationMode == NO && windowController.curvedPath.nodes.count == 0)
        windowController.curvedPathCreationMode = YES;
    
    NSPoint mouseLocation = {550, 150};
    
    if (windowController.curvedPathCreationMode) {
        
        N3AffineTransform viewToDicomTransform = N3AffineTransformConcat([_mprView2 viewToPixTransform], [_mprView2 pixToDicomTransform]);
        N3Vector newCrossCenter = N3VectorApplyTransform(N3VectorMakeFromNSPoint(mouseLocation), viewToDicomTransform);
        
        [_textView3 setString:[_textView3.string stringByAppendingString:[NSString stringWithFormat:@"%f   %f   %f\n",
                                                                          newCrossCenter.x, newCrossCenter.y, newCrossCenter.z]]];
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
    
    nodeCount = [windowController.curvedPath.nodes count];
    [_textView2 setString:[_textView2.string stringByAppendingString:[NSString stringWithFormat:@"%d\n", nodeCount]]];
    
    
    
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



- (IBAction)assistedCurvedPath:(id)sender {
    
    unsigned int nodeCount1 = [_cprController.curvedPath.nodes count];
    [_textView2 setString:[_textView2.string stringByAppendingString:[NSString stringWithFormat:@"%d", nodeCount1]]];
    [_textView2 setString:[_textView2.string stringByAppendingString:@"    "]];
    
    /*
    
    if( [_cprController.curvedPath.nodes count] > 1 && [_cprController.curvedPath.nodes count] <= 5)
        [_cprController assistedCurvedPath:nil];
    else
        NSRunAlertPanel(NSLocalizedString(@"Path Assistant error", nil), NSLocalizedString(@"Path Assistant requires at least 2 points, and no more than 5 points. Use the Curved Path tool to define at least two points.", nil), NSLocalizedString(@"OK", nil), nil, nil);
     */
    
    
    int dim[3];
    NSMutableArray *pix = [_viewerController pixList:0];
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
            [_textView3 setString:[_textView3.string stringByAppendingString:[NSString stringWithFormat:@"pta: %f   %f   %f\n",
                                                                              pta.x, pta.y, pta.z]]];
            [_textView3 setString:[_textView3.string stringByAppendingString:[NSString stringWithFormat:@"ptb: %f   %f   %f\n",
                                                                              ptb.x, ptb.y, ptb.z]]];
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










////////////////////////////////////////////////////////////////////




- (void)sliderValueChanged:(float)pos {
    IplImage* cvPlotImage2 = [_objcWrapper getPlotWithLineOfIdx:2 atPosition:pos];
    NSImage *plotImage2 = [self imageWithCVImage:cvPlotImage2];
    [_imageView2 setImage:plotImage2];
    
    IplImage* cvPlotImage0 = [_objcWrapper getPlotWithLineOfIdx:0 atPosition:pos];
    NSImage *plotImage0 = [self imageWithCVImage:cvPlotImage0];
    [_imageView3 setImage:plotImage0];
    
    IplImage* cvPlotImage1 = [_objcWrapper getPlotWithLineOfIdx:1 atPosition:pos];
    NSImage *plotImage1 = [self imageWithCVImage:cvPlotImage1];
    [_imageView4 setImage:plotImage1];
    
    [self setTransverseSectionPosition:(pos / _slider2.maxValue)];

    [_textView1 setString:[_textView1.string stringByAppendingString:[NSString stringWithFormat:@"%f", _slider2.floatValue]]];
    [_textView1 setString:[_textView1.string stringByAppendingString:@"    "]];
}






- (NSImage*) setTransverseSectionPosition:(CGFloat)newPos {
    CPRTransverseView *middleTransverseView = _cprController.middleTransverseView;
    CPRCurvedPath *curvedPath = middleTransverseView.curvedPath;
    
    NSString *positionStr = [NSString stringWithFormat: @"%.3lf", curvedPath.transverseSectionPosition];
    [_textView4 setString:[_textView4.string stringByAppendingString:positionStr]];
    [_textView4 setString:[_textView4.string stringByAppendingString:@"    "]];
    
    
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
    
    NSImage *curImage = [middleTransverseView.curDCM image];
    [_imageView1 setImage:curImage];
    return curImage;
}


- (NSImage*) moveTransverseImageWithStepLength:(CGFloat)stepLength {
    CGFloat curPos = _cprController.middleTransverseView.curvedPath.transverseSectionPosition;
    return [self setTransverseSectionPosition:(curPos + stepLength)];
}



- (void) saveTransverseImage:(NSImage*)curImage index:(int) idx; {
    
    NSString *idxWithFormat = [NSString stringWithFormat:@"%03d", idx];
    NSString *curFileName = [NSString stringWithFormat:@"/Users/wb-vesselwall/Documents/osirix_transverse/CPR%@.tiff", idxWithFormat];
    [[curImage TIFFRepresentation] writeToFile:curFileName atomically:YES];
}


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


@end
