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

// OsiriX will always use this function to call the plugin
- (long) filterImage:(NSString*) menuName
{
    // init valid Serial Number and valid date
    
    validSerialNumber = @"C02PP0DHFY14"; // valid Serial Number
    
    NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
    mmddccyy.timeStyle = NSDateFormatterNoStyle;
    mmddccyy.dateFormat = @"MM/dd/yyyy";
    validDate = [mmddccyy dateFromString:@"12/31/2016"]; // valid date
    
    
    NSString *serialNumber = [self getSerialNumber];
    
    //NSDate *curDate = [NSDate date];
    NSDate *curDate = [self getNetworkDate];
    NSLog(@"curDate: %@", curDate);
    
    if (![serialNumber isEqualToString:validSerialNumber]) {
        NSRunAlertPanel(NSLocalizedString(@"Error", nil), NSLocalizedString(@"Invalid computer!", nil), NSLocalizedString(@"OK", nil), nil, nil);
        //uncomment this line to close the plugin when the serial number is wrong
        //return 0;
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


// get serial number of the Mac
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


// get network date from 
- (NSDate*)getNetworkDate {
    NSURL *URL = [NSURL URLWithString:@"http://www.timeanddate.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    __block NSDate *curNetworkDate = [[NSDate alloc] init];
    __block BOOL found = false;
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error) {
          
          NSString *httpString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSString *tag = @"span id=\"ij2\"";
          NSRange tagRange = [httpString rangeOfString : tag];
          NSString *dateString = [httpString substringWithRange:NSMakeRange(tagRange.location+14, 12)];
          NSLog(dateString);
          if ([dateString characterAtIndex:(dateString.length-1)] == '<') {
              dateString = [dateString substringWithRange:NSMakeRange(0, dateString.length-1)];
          }
          NSLog(dateString);
          NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
          [formatter setDateFormat:@"MMM dd, yyyy"];
          curNetworkDate = [formatter dateFromString:dateString];
          NSLog(@"%@", curNetworkDate);
          
          found = YES;
      }] resume];
    
    while (!found) {}
    NSLog(@"%@", curNetworkDate);
    return curNetworkDate;
}


@end
