//
//  CPRHelperFilter.m
//  CPRHelper
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import "CPRHelperFilter.h"
#import "Controller.h"


@implementation CPRHelperFilter

- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{
    // init valid Serial Number and valid date
    
    validSerialNumber = @"C02PP0DHFY14"; //
    
    NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
    mmddccyy.timeStyle = NSDateFormatterNoStyle;
    mmddccyy.dateFormat = @"MM/dd/yyyy";
    validDate = [mmddccyy dateFromString:@"7/30/2016"];
    
    
    NSString *serialNumber = [self getSerialNumber];
    NSDate *curDate = [NSDate date];
    
    
    if (![serialNumber isEqualToString:validSerialNumber]) {
        NSRunAlertPanel(NSLocalizedString(@"Error", nil), NSLocalizedString(@"Invalid computer!", nil), NSLocalizedString(@"OK", nil), nil, nil);
        return 0;
    }
    
    if ([curDate compare:validDate] == NSOrderedDescending) {
        NSString *invalidDateMessage = [NSString stringWithFormat:@"Invalid date!\nValid before %@.", validDate];
        NSRunAlertPanel(NSLocalizedString(@"Error", nil), NSLocalizedString(invalidDateMessage, nil), NSLocalizedString(@"OK", nil), nil, nil);
        return 0;
    }
    
    _curViewerController = viewerController;
    Controller *window = [[Controller alloc] init:self];
    [window showWindow:self];
    return 0;
}

- (NSString*)getSerialNumber {
    NSString *serial = nil;
    io_service_t platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault,
                                                              IOServiceMatching("IOPlatformExpertDevice"));
    if (platformExpert) {
        CFTypeRef serialNumberAsCFString =
        IORegistryEntryCreateCFProperty(platformExpert,
                                        CFSTR(kIOPlatformSerialNumberKey),
                                        kCFAllocatorDefault, 0);
        if (serialNumberAsCFString) {
            serial = CFBridgingRelease(serialNumberAsCFString);
        }
        
        IOObjectRelease(platformExpert);
    }
    return serial;
}

@end
