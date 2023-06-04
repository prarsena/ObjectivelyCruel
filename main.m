//
//  main.m
//  ObjectivelyCruel
//
//  Created by petera on 6/3/23.
//  Copyright 2023 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ObjectivelyCruelAppDelegate.h"

int main(int argc, char *argv[])
{
	ObjectivelyCruelAppDelegate *delegate = [[ObjectivelyCruelAppDelegate alloc] init];
    NSApplication *application = [NSApplication sharedApplication];
    [application setDelegate:delegate];
    [application run];
    return 0;
}
