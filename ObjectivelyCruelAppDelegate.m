//
//  ObjectivelyCruelAppDelegate.m
//  ObjectivelyCruel
//
//  Created by petera on 6/3/23.
//  Copyright 2023 __MyCompanyName__. All rights reserved.
//

#import "ObjectivelyCruelAppDelegate.h"
#import "ColorPanelWindowController.h"
#import "nscolor-colorWithCssDefinition.h"
#import <Foundation/Foundation.h>

@implementation ObjectivelyCruelAppDelegate

@synthesize window;
@synthesize textField;
@synthesize button;
@synthesize colorButton;
@synthesize textView;
@synthesize pageHeader;
@synthesize subheader;
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
                            keyEquivalent:@"c"];
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
    NSRect windowFrame = NSMakeRect(0,NSMaxY([[NSScreen mainScreen] frame]),400,300);
    
    NSRect headerFrame = NSMakeRect(20,230,340,50);
	NSRect subheaderFrame = NSMakeRect(60,175,260,40);
    self.pageHeader = [[NSTextView alloc] initWithFrame:headerFrame];
    
#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_6
    self.window = [[NSWindow alloc] initWithContentRect: windowFrame
                                              styleMask: NSWindowStyleMaskTitled |
                                                           NSWindowStyleMaskClosable |
                                                           NSWindowStyleMaskResizable |
                                                           NSWindowStyleMaskMiniaturizable
                                                backing: NSBackingStoreBuffered
                                                  defer: NO];
    self.window.title = @"Not Snow Leopard";
    self.pageHeader.string = @"Not Snow Leopard";

    [self.pageHeader setAlignment: NSTextAlignmentCenter];
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
    self.pageHeader.string = @"Whoa Leopard";
    [self.pageHeader setAlignment: NSCenterTextAlignment];
    NSLog(@"Found os x snow" );
#endif
    /* Main window color */
    NSColor *backgroundColor = [NSColor colorWithCssDefinition:@"royalblue"];
    self.window.backgroundColor = backgroundColor;
	
    /* These attributes describe the Title section of the window. */
    [self.pageHeader setFont:[NSFont systemFontOfSize:33]];
    [self.pageHeader setEditable: NO];
    [self.pageHeader setSelectable: NO];
    [self.pageHeader setBackgroundColor: [NSColor colorWithCssDefinition:@"dodgerblue"]];
    [self.pageHeader setTextColor:[NSColor colorWithCssDefinition:@"tomato"]];
    [self.window.contentView addSubview:self.pageHeader];
	
	/* Work with subheader */
	self.subheader = [[NSTextView alloc] initWithFrame:subheaderFrame];
	[self.subheader setFont:[NSFont boldSystemFontOfSize:33]];
	[self.subheader setEditable: NO];
    [self.subheader setSelectable: NO];
	[self.subheader setFont: [NSFont systemFontOfSize:14]];
    [self.subheader setBackgroundColor: [NSColor colorWithCssDefinition:@"dodgerblue"]];
    [self.subheader setTextColor:[NSColor colorWithCssDefinition:@"tomato"]];
	//[self.subheader setAlignment: NSCenterTextAlignment];
	[self.window.contentView addSubview:self.subheader];
    
    /* These attributes describe the text field, the space where a user can write. */
    self.textField = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 32, 200, 30)];
    [self.textField setBackgroundColor: [NSColor colorWithCssDefinition:@"azure"]];
    [self.textField setFont: [NSFont systemFontOfSize:14]];
    [self.textField setTextColor:[NSColor colorWithCssDefinition:@"midnightblue"]];
    [self.window.contentView addSubview:self.textField];
    
    /* These attributes describe the text view, the space where the message is displayed. */
    self.textView = [[NSTextView alloc] initWithFrame:NSMakeRect(20, 67, 200, 62)];
    self.textView.backgroundColor = [NSColor colorWithCssDefinition:@"cornsilk"];
    self.textView.textColor = [NSColor colorWithCssDefinition:@"midnightblue"];
    self.textView.string = @"Hello, me!";
    [self.textView setFont:[NSFont systemFontOfSize:25]];
    [self.textView setEditable: NO];
    [self.textView setSelectable: NO];
    [self.window.contentView addSubview:self.textView];
    
    // Create the close window button without declaring it. Also, don't display it. 
    NSButton *closeButton = [[NSButton alloc] init];
	[closeButton setTitle: @"Close"];
    closeButton.target = self;
    [closeButton setFont: [NSFont systemFontOfSize:14]];
    [closeButton setAction:@selector(quitApplication:)];
	[closeButton setKeyEquivalentModifierMask: NSCommandKeyMask];
	[closeButton setKeyEquivalent:@"w"];
    [self.window.contentView addSubview:closeButton];
    
    // Create the button
    self.button = [[NSButton alloc] initWithFrame:NSMakeRect(230, 30, 100, 32)];
    self.button.title = @"Write Msg";
    [self.button setBordered: YES];
    [self.button setFont: [NSFont systemFontOfSize:14]];
	[self.button setKeyEquivalent:@"\r"];
    [self.button setTarget:self];
    [self.button setAction:@selector(buttonClicked:)];
    [self.window.contentView addSubview:self.button];
    
    // Create the open window button
    self.colorButton = [[NSButton alloc] initWithFrame:NSMakeRect(230, 65, 100, 32)];
    self.colorButton.title = @"Color Menu";
    [self.colorButton setBordered: YES];
    [self.colorButton setFont: [NSFont systemFontOfSize:14]];
    [self.colorButton setTarget:self];
    [self.colorButton setAction:@selector(showPreferences:)];
    [self.window.contentView addSubview:self.colorButton];
	
	// Create the close window button without declaring it.
    NSButton *urlButton = [[NSButton alloc] initWithFrame:NSMakeRect(230, 100, 100, 32)];
    [urlButton setTitle: @"URL"];
    urlButton.target = self;
    [urlButton setFont: [NSFont systemFontOfSize:14]];
    [urlButton setAction:@selector(urlButtonClicked:)];
    [self.window.contentView addSubview:urlButton];
	
    
    [self.window makeKeyAndOrderFront: NSApp];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)urlButtonClicked:(id)sender {
	NSProcessInfo *myProcess = [NSProcessInfo processInfo];
    NSString *version = [myProcess operatingSystemVersionString];
    NSLog(@"%@", version);
    NSString *originalString = @"Your OS is ";
    NSString *concatedString = [originalString stringByAppendingString:version];
    
    NSLog(@"URL BUTTON");
	NSLog(@"%@", concatedString);
	
	//[self.subheader setString:[[self.textView string] stringByAppendingString:concatedString]];
	[self.subheader setString:version];

    NSURL *url = [NSURL URLWithString:@"https://example.com?param1=value1&param2=value2"];
    
    [[NSWorkspace sharedWorkspace] openURL:url];
    
    [NSApp run];
}

- (void)buttonClicked:(id)sender {
    NSString *text = self.textField.stringValue;
    
    NSSound *purr = [NSSound soundNamed: @"Purr"];
    NSSound *submarine = [NSSound soundNamed: @"Submarine"];
	
	NSArray *keys = [NSColor allKeysFromDictionary];
	BOOL colorFound = NO;
	
    if (text.length > 0) {

        [self.textView setString:[[self.textView string] stringByAppendingString:text]];
		
		for (id object in keys) {
			if ([object isKindOfClass:[NSString class]]) {
				NSString *item = (NSString *) object;
				if ([item isEqualToString:text]) {
					colorFound = YES;
					break;
				}
			}			
		} 
		
		if (colorFound){ 
			self.textView.backgroundColor = [NSColor colorWithCssDefinition:text];
		} else {
			self.textView.backgroundColor = [NSColor colorWithCssDefinition:@"mistyrose"];	
		}
		
        [self.textView setString:text];
        [self.textField setStringValue:@""];
        
        [purr play];
        usleep(200);
        usleep(200);
        [submarine play];
    } else {
        NSLog(@"Nothing written");
        [self.textView setString:@"Objectively cruel"];
        NSBeep();
    }
}

- (void)quitApplication:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (void)showPreferences:(id)sender {
    NSLog(@"Show preferences");
    
    if (!self.colorPanelWindowController) {
        self.colorPanelWindowController = [[ColorPanelWindowController alloc] initWithCustomWindow];
    }
    [self.colorPanelWindowController showWindow:self];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
