//
//  ColorPanelWindowController.m
//  ObjectivelyCruel
//
//  Created by Peter Arsenault on 6/3/23.
//

#import "ColorPanelWindowController.h"
#import "nscolor-colorWithCssDefinition.h"
#include <AvailabilityMacros.h>
#include <Availability.h>

@implementation ColorPanelWindowController

- initWithWindow {
    
    NSRect windowFrame = NSMakeRect(200,200,1020,600);

#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_6
    NSWindow *colorPanelWindow = [[NSWindow alloc] initWithContentRect: windowFrame
                                              styleMask: NSWindowStyleMaskTitled |
                                                           NSWindowStyleMaskResizable |
                                                           NSWindowStyleMaskClosable
                                                backing: NSBackingStoreBuffered
                                                  defer: NO];
    NSLog(@"Found greater os than snow" );
#else
    NSWindow *colorPanelWindow = [[NSWindow alloc] initWithContentRect: windowFrame
                                              styleMask:   NSTitledWindowMask |
                                                           NSResizableWindowMask |
                                                           NSMiniaturizableWindowMask |
                                                           NSClosableWindowMask
                                                backing: NSBackingStoreBuffered
                                                  defer: NO];
    NSLog(@"Found os x snow" );
#endif

    self = [super initWithWindow:colorPanelWindow];
    if (self) {
        [colorPanelWindow setTitle:@"Color Panel"];
        
        NSArray *keys = [NSColor allKeysFromDictionary];

        CGFloat yOffset = 5.0;
        CGFloat xOffset = 5.0;
        NSInteger i = 0;

        for (id object in keys) {
            
            NSTextView *textView =
                [[NSTextView alloc] initWithFrame:CGRectMake(xOffset, yOffset, 120, 20)];
            textView.string = object;
            
            NSColor *cssColorRepresentation = [NSColor colorWithCssDefinition:object];
            textView.backgroundColor = cssColorRepresentation;
            
            yOffset += textView.frame.size.height + 10;
            if ((i + 1) % 20 == 0) {
                xOffset += 130.0;
                yOffset = 5.0;
            }
            i++;
            
            [self.window.contentView addSubview:textView];
        }
        
        // Create the button
        self.button = [[NSButton alloc] initWithFrame:NSMakeRect(920, 100, 80, 32)];
        self.button.title = @"Close";
        [self.button setBordered: YES];
        [self.button setFont: [NSFont systemFontOfSize:14]];
        [self.button setTarget:self];
        [self.button setAction:@selector(closeWindow:)];
        [self.window.contentView addSubview:self.button];
    }
    return self;
}

- (void) closeWindow:(id)sender {
    NSLog(@"Close");
    [self close];
}

@end
