//
//  BundlePlugin.m
//  BitBar
//
//  Created by Manu Wallner on 13.06.2016.
//  Copyright © 2016 Bit Bar. All rights reserved.
//

#import "BundlePlugin.h"

@implementation BundlePlugin

// The path will be set to the .bitbarplugin file
// To find the actual executable file we need to find the Info.plist inside
- (void)setPath:(NSString *)path {
  NSBundle *pluginBundle = [NSBundle bundleWithPath:path];
  
  NSString *infoPath = [pluginBundle pathForResource:@"Info" ofType:@"plist"];
  NSData *plistData = [NSFileManager.defaultManager contentsAtPath:infoPath];
  NSError *err;
  NSDictionary *info = (NSDictionary *)[NSPropertyListSerialization propertyListWithData:plistData
                                                                                 options:NSPropertyListImmutable
                                                                                  format:NULL
                                                                                   error:&err];
  self.refreshIntervalSeconds = [self refreshIntervalFromString:info[@"RefreshInterval"]];
  
  NSString *executablePath = [pluginBundle pathForResource:info[@"ExecutableFile"] ofType:nil];
  [super setPath:executablePath];
}

@end
