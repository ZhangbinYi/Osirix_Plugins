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



@implementation Controller

@synthesize filter = _filter;
@synthesize viewerController = _viewerController;
@synthesize cprController = _cprController;
@synthesize textView1 = _textView1;
@synthesize textView2 = _textView2;
@synthesize textView3 = _textView3;
@synthesize textView4 = _textView4;
@synthesize imageView1 = _imageView1;

- (id) init: (CPRHelperFilter*) f
{
    _filter = f;
    self = [super initWithWindowNibName:@"CPRHelperWindow"];
    [[self window] setDelegate:self];   //In order to receive the windowWillClose notification
    return self;    
}

- (IBAction)openCPRViewer:(id)sender {
    _viewerController = [_filter duplicateCurrent2DViewerWindow];
    _cprController = [_viewerController openCPRViewer];
    [_viewerController place3DViewerWindow:(NSWindowController *) _cprController];
    [_cprController showWindow:self];
}

- (IBAction)dcmPixListSize:(id)sender {
    
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
    
    [_imageView1 setImage:image1];
    
}




- (IBAction)changeTransverseSectionPosition:(id)sender {
    CPRTransverseView *middleTransverseView = _cprController.middleTransverseView;
    CPRCurvedPath *curvedPath = middleTransverseView.curvedPath;
    
    NSString *positionStr = [NSString stringWithFormat: @"%.3lf", curvedPath.transverseSectionPosition];
    [_textView3 setString:[_textView3.string stringByAppendingString:positionStr]];
    [_textView3 setString:[_textView3.string stringByAppendingString:@"    "]];

    
    //transverseSectionPosition = MIN(MAX(_curvedPath.transverseSectionPosition + [theEvent deltaY] * .002, 0.0), 1.0);
    if ([middleTransverseView.delegate respondsToSelector:@selector(CPRViewWillEditCurvedPath:)]) {
        [_textView4 setString:[_textView4.string stringByAppendingString:@"CPRViewWillEditCurvedPath    "]];
        [middleTransverseView.delegate CPRViewWillEditCurvedPath:middleTransverseView];
    }
    curvedPath.transverseSectionPosition += 0.01;
    if ([middleTransverseView.delegate respondsToSelector:@selector(CPRViewDidEditCurvedPath:)])  {
        [_textView4 setString:[_textView4.string stringByAppendingString:@"CPRViewDidEditCurvedPath    "]];
        [middleTransverseView.delegate CPRViewDidEditCurvedPath:middleTransverseView];
    }
    [middleTransverseView _sendNewRequest];
    [middleTransverseView setNeedsDisplay:YES];
    
    NSImage *image1 = [middleTransverseView.curDCM image];
    [_imageView1 setImage:image1];
    
    NSString *sizeStr2 = [NSString stringWithFormat: @"%.3f", curvedPath.transverseSectionPosition];
    
    NSString * result1 = [[curvedPath valueForKey:@"description"] componentsJoinedByString:@""];
    
    //[_label3 setStringValue:[_label3.stringValue stringByAppendingString:result2]];
    
    
}




@end
