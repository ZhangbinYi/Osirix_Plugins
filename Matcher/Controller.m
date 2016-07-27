//
//  Controller.m
//  Matcher
//
//  Created by WB-Vessel Wall on 7/26/16.
//
//


#import "Controller.h"
#import "MatcherFilter.h"

#import <OsiriXAPI/PluginFilter.h>
#import "OsiriXAPI/DCMPix.h"
#import "OsiriXAPI/DCMView.h"
#import "OsiriXAPI/wait.h"
#import "OsiriXAPI/DICOMExport.h"
#import "OsiriXAPI/DICOMDatabase.h"
#import "OsiriXAPI/BrowserController.h"



@implementation Controller

- (id) init: (MatcherFilter*) f {
    _filter = f;
    self = [super initWithWindowNibName:@"MatcherWindow"];
    [[self window] setDelegate:self];
    [_MatcherWindow setLevel:NSFloatingWindowLevel];
    
    return self;
}

- (IBAction)divideIntoGroups:(id)sender {
    _viewerController = _filter.curViewerController;
    //_viewerController1 = [_filter duplicateCurrent2DViewerWindow];
    //_viewerController2 = [_filter duplicateCurrent2DViewerWindow];
    
    int numGroups = _textField1.intValue;
    if (!(numGroups > 0 && numGroups <= 100)) {
        NSRunAlertPanel(NSLocalizedString(@"Invalid Number", nil), NSLocalizedString(@"Number of groups: 1 - 100.", nil), NSLocalizedString(@"OK", nil), nil, nil);
        return;
    }
    
    _numLayers = _viewerController.pixList.count / numGroups;
    
    for (int i = 0; i < numGroups; i++) {
        [self exportDICOMFileWithSeriesName:[NSString stringWithFormat:@"Data%d", i+1] from:(_numLayers*i) to:(_numLayers*(i+1)) withInterval:1];
        usleep(500000);
    }
}

/*
- (IBAction)sliderValueChanged:(id)sender {
    [_viewerController0.imageView setIndex:_slider.intValue * 3];
    [_viewerController1.imageView setIndex:_slider.intValue * 3 + 1];
    [_viewerController2.imageView setIndex:_slider.intValue * 3 + 2];
}
 */


- (void) exportDICOMFileWithSeriesName:(NSString*)seriesName from:(int)from to:(int)to withInterval:(int)interval
{
    int i, curImage;
    
    //[dcmExportWindow makeFirstResponder: nil];	// To force nstextfield validation
    //[NSApp endSheet:dcmExportWindow returnCode:[sender tag]];
    //[dcmExportWindow orderOut:sender];
    
    
    NSMutableArray *producedFiles = [NSMutableArray array];
    
    
    if( interval < 1)
        interval = 1;
    
    Wait *splash = [[Wait alloc] initWithString:NSLocalizedString(@"Creating a DICOM series", nil)];
    [splash showWindow:self];
    [[splash progress] setMaxValue: (to - from) / interval];
    [splash setCancel: YES];
    
    curImage = [_viewerController.imageView curImage];
    
    /*
    DICOMExport	*exportDCM = [[DICOMExport alloc] init];
    
    [exportDCM setSeriesNumber:5300 + [[NSCalendarDate date] minuteOfHour] + [[NSCalendarDate date] secondOfMinute]];
    
    [exportDCM setSeriesDescription: seriesName];
     */
    
    NSLog( @"export start");
    
    for (i = from ; i < to; i += interval)
    {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        BOOL export = YES;
        
        /*
        if( [[dcmSelection selectedCell] tag] == 2)	// Only ROIs & key images
        {
            NSUInteger index = 0;
            
            if( [imageView flippedData]) index = [[self fileList] count] -1 -i;
            else index = i;
            
            DicomImage *image = [[self fileList] objectAtIndex: index];
            
            export = [image.isKeyImage boolValue];
            
            if( export == NO)
            {
                if( [[self.roiList objectAtIndex: index] count] > 0)
                    export = YES;
            }
        }
         */
        
        if( export)
        {
            if( [_viewerController.imageView flippedData]) [_viewerController.imageView setIndex: (long)[_viewerController.pixList[[_viewerController curMovieIndex]] count] -1 -i];
            else [_viewerController.imageView setIndex:i];
            
            [_viewerController.imageView sendSyncMessage: 0];
            [_viewerController adjustSlider];
            
            NSDictionary* s = [_viewerController exportDICOMFileInt:0 withName:seriesName allViewers:NO];
            if( [s valueForKey: @"file"]) [producedFiles addObject: s];
        }
        
        [splash incrementBy: 1];
        
        if( [splash aborted])
            i = to;
        
        [pool release];
    }
    
    NSLog( @"export end");
    
    // Go back to initial frame
    [_viewerController.imageView setIndex: curImage];
    [_viewerController.imageView sendSyncMessage: 0];
    [_viewerController adjustSlider];
    
    [splash close];
    [splash autorelease];
    
    
    
    
    NSArray *viewers = [ViewerController getDisplayed2DViewers];
    
    for( i = 0; i < [viewers count]; i++)
        [[[viewers objectAtIndex: i] imageView] setNeedsDisplay: YES];
    
    if( [producedFiles count])
    {
        NSArray *objects = [BrowserController.currentBrowser.database addFilesAtPaths: [producedFiles valueForKey: @"file"]
                                                                    postNotifications: YES
                                                                            dicomOnly: YES
                                                                  rereadExistingItems: YES
                                                                    generatedByOsiriX: YES];
        
        objects = [BrowserController.currentBrowser.database objectsWithIDs: objects];
        
        if( [[NSUserDefaults standardUserDefaults] boolForKey: @"afterExportSendToDICOMNode"])
            [[BrowserController currentBrowser] selectServer: objects];
        
        if( [[NSUserDefaults standardUserDefaults] boolForKey: @"afterExportMarkThemAsKeyImages"])
        {
            for( DicomImage *im in objects)
                [im setValue: @YES forKey: @"isKeyImage"];
        }
    }
    
    [_viewerController adjustSlider];
}


@end