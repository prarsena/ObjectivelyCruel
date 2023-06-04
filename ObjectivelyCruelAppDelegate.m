//
//  ObjectivelyCruelAppDelegate.m
//  ObjectivelyCruel
//
//  Created by petera on 6/3/23.
//  Copyright 2023 __MyCompanyName__. All rights reserved.
//

#import "ObjectivelyCruelAppDelegate.h"
#import "ColorPanelWindowController.h"

@implementation ObjectivelyCruelAppDelegate

@synthesize window;
@synthesize textField;
@synthesize button;
@synthesize colorButton;
@synthesize textView;
@synthesize pageHeader;
@synthesize colorPanelWindowController;
@synthesize menu;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    /* Create the menu bar */
    NSMenu *menuBar = [[NSMenu alloc] init];
    NSMenuItem *applicationMenuItem = [[NSMenuItem alloc] init];
    [menuBar addItem:applicationMenuItem];
    
    /* Add items to the menu bar */
    NSMenu *applicationMenu = [[NSMenu alloc] init];
    [applicationMenuItem setSubmenu:applicationMenu];
    
    // Add Preferences menu item
    NSMenuItem *preferencesMenuItem =
        [[NSMenuItem alloc] initWithTitle:@"Colors"
                            action:@selector(showPreferences:)
                            keyEquivalent:@","];
    [applicationMenu addItem:preferencesMenuItem];
    
    // Add Quit menu item
    NSMenuItem *quitMenuItem =
        [[NSMenuItem alloc] initWithTitle:@"Quit"
                            action:@selector(quitApplication:)
                            keyEquivalent:@"q"];
    [applicationMenu addItem:quitMenuItem];
    
    // Set the menu bar
    [[NSApplication sharedApplication] setMainMenu:menuBar];
    
    /* Create the window. It will be different depending on which OS X version. */
    NSRect windowFrame = NSMakeRect(200,200,400,300);
    NSRect headerFrame = NSMakeRect(20,230,340,50);
    self.pageHeader = [[NSTextView alloc] initWithFrame:headerFrame];
    
#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_6
    self.window = [[NSWindow alloc] initWithContentRect: windowFrame
                                              styleMask: NSTitledWindowMask |
                                                         NSClosableWindowMask |
                                                         NSResizableWindowMask
                                                backing: NSBackingStoreBuffered
                                                  defer: NO];
    self.window.title = @"Not Snow Leopard";
    self.pageHeader.string = @"My OtherApp~~!xD";
    NSLog(@"Found greater os than snow" );
#else
    self.window = [[NSWindow alloc] initWithContentRect: windowFrame
                                              styleMask:   NSTitledWindowMask |
                                                           NSResizableWindowMask |
                                                           NSMiniaturizableWindowMask |
                                                           NSClosableWindowMask
                                                backing: NSBackingStoreBuffered
                                                  defer: NO];
    self.window.title = @"Snow Leopard";
    self.pageHeader.string = @"My Snow Leopard App~~!xD";
    NSLog(@"Found os x snow" );
#endif
    
    NSColor *backgroundColor = [NSColor whiteColor];
    self.window.backgroundColor = backgroundColor;
    
    [self.pageHeader setFont:[NSFont systemFontOfSize: 24]];
    [self.pageHeader setEditable: NO];
    [self.pageHeader setSelectable: NO];
    self.pageHeader.backgroundColor = [NSColor darkGrayColor];
    [self.pageHeader setBackgroundColor: [NSColor lightGrayColor]];
    self.pageHeader.textColor = [NSColor whiteColor];
    [self.window.contentView addSubview:self.pageHeader];
    // Create the text field
    self.textField = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 70, 200, 22)];
    
    // Select color from CSS Definitions file as a String.
    //NSColor *whateverColor = [NSColor colorWithCssDefinition:@"forestgreen"];
    [self.textField setBackgroundColor: [NSColor whiteColor]];
    [self.window.contentView addSubview:self.textField];
    
    // Create the close window button without declaring it.
    NSButton *closeButton = [[NSButton alloc] initWithFrame:NSMakeRect(230, 30, 100, 32)];
    [closeButton setTitle: @"Close"];
    //closeButton.bordered = YES;
    closeButton.target = self;
    [closeButton setFont: [NSFont systemFontOfSize:14]];
    [closeButton setAction:@selector(quitApplication:)];
    [self.window.contentView addSubview:closeButton];
    
    // Create the button
    self.button = [[NSButton alloc] initWithFrame:NSMakeRect(230, 65, 100, 32)];
    self.button.title = @"Write Msg";
    [self.button setBordered: YES];
    [self.button setFont: [NSFont systemFontOfSize:14]];
    [self.button setTarget:self];
    [self.button setAction:@selector(buttonClicked:)];
    [self.window.contentView addSubview:self.button];
    
    // Create the open window button
    self.colorButton = [[NSButton alloc] initWithFrame:NSMakeRect(230, 100, 100, 32)];
    self.colorButton.title = @"Color Menu";
    [self.colorButton setBordered: YES];
    [self.colorButton setFont: [NSFont systemFontOfSize:14]];
    [self.colorButton setTarget:self];
    [self.colorButton setAction:@selector(showPreferences:)];
    [self.window.contentView addSubview:self.colorButton];
    
    self.textView = [[NSTextView alloc] initWithFrame:NSMakeRect(20, 100, 200, 22)];
    self.textView.backgroundColor = [NSColor darkGrayColor];
    self.textView.textColor = [NSColor whiteColor];
    self.textView.string = @"Hello, me!";
    [self.textView setEditable: NO];
    [self.textView setSelectable: NO];
    
    [self.window.contentView addSubview:self.textView];
    
    [self.window makeKeyAndOrderFront: NSApp];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)buttonClicked:(id)sender {
    NSString *text = self.textField.stringValue;
    NSSound *frog = [NSSound soundNamed: @"Frog"];
    NSSound *basso = [NSSound soundNamed: @"Basso"];
	
    if (text.length > 0) {
        NSLog(@"%@", text);
        [self.textView setString:[[self.textView string] stringByAppendingString:text]];
        [self.textView setString:text];
        [self.textField setStringValue:@""];
        NSBeep();
    } else {
        NSLog(@"Nothing written");
        [self.textView setString:@"Objectively cruel"];
        [frog play];
        usleep(200);
        [basso play];
    }
}

- (void)quitApplication:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (void)showPreferences:(id)sender {
    NSLog(@"Show preferences");
    
    if (!self.colorPanelWindowController) {
		NSLog(@"self is not colorPanelWind");
        self.colorPanelWindowController = [[ColorPanelWindowController alloc] initWithCustomWindow];
    }
    [self.colorPanelWindowController showWindow:self];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
