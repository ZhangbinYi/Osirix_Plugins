//
//  ReportImageView.m
//  Practice1
//
//  Created by Zhangbin Yi on 8/8/16.
//  Copyright © 2016 Zhangbin Yi. All rights reserved.
//


#import "ReportImageView.h"

@implementation ReportImageView

- (void) mouseUp:(NSEvent *)theEvent {
    [self setImage:nil];
    
    //NSImage* img1 = [NSImage imageNamed:@"CPR001.tiff"];
    NSImage *img1 = [[NSImage alloc] initWithContentsOfFile:@"/Users/wb-vesselwall/Documents/OsiriX Data/REPORTS/vessel.jpg"];
    //NSImage *img1 = [[NSImage alloc] initWithData:_vesselImageData];
    
    [img1 lockFocus];
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    
    // Save the current graphics context settings
    [gc saveGraphicsState];
    
    // Set the color in the current graphics context for future draw operations
    [[NSColor blackColor] setStroke];
    [[NSColor blueColor] setFill];
    
    // Create our circle path
    NSPoint mouseLocation = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSLog(@"%f  %f", mouseLocation.x, mouseLocation.y);
    
    float diameter = self.frame.size.width / 10;
    float x = (img1.size.width * (mouseLocation.x / self.frame.size.width)) - diameter / 2;
    float y = (img1.size.height * (mouseLocation.y / self.frame.size.height)) - diameter / 2;
    
    NSRect rect = NSMakeRect(x, y, diameter, diameter);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: rect];
    
    // Outline and fill the path
    [circlePath stroke];
    [circlePath fill];
    
    // Restore the context to what it was before we messed with it
    [gc restoreGraphicsState];
    
    [img1 unlockFocus];
    
    [self setImage:img1];
    
    /*
     [NSImage imageNamed]
     is in the cache, and as long as it is in the cache it will return the cached image so what you need to do is first released the previous reference or use the object's setName method and setting to nil. Here is the documentation reference:
     
     The NSImage class may cache a reference to the returned image object for performance in some cases. However, the class holds onto cached objects only while the object exists. If the image object is subsequently released, either because its retain count was 0 or it was not referenced anywhere in a garbage-collected application, the object may be quietly removed from the cache. Thus, if you plan to hold onto a returned image object, you must retain it like you would any Cocoa object. You can clear an image object from the cache explicitly by calling the object’s setName: method and passing nil for the image name.
     */
    //[img1 setName:nil];

}


@end
