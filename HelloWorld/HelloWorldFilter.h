//
//  HelloWorldFilter.h
//  HelloWorld
//
//  Copyright (c) 2016 CS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>

@interface HelloWorldFilter : PluginFilter {

}

- (long) filterImage:(NSString*) menuName;

@end