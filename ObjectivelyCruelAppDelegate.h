//
//  ObjectivelyCruelAppDelegate.h
//  ObjectivelyCruel
//
//  Created by petera on 6/3/23.
//  Copyright 2023 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ObjectivelyCruelAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSTextField *textField;
    
    NSButton *button;
    NSButton *colorButton;
    
    NSTextView *textView;
    NSTextView *pageHeader;
	NSTextView *subheader;
	
	NSWindowController *colorPanelWindowController;
	NSMenu *menu;
}

@property (assign) NSWindow *window;
@property (assign) NSTextField *textField;
@property (assign) NSButton *button;
@property (assign) NSButton *colorButton;
@property (assign) NSTextView *textView;
@property (assign) NSTextView *pageHeader;
@property (assign) NSTextView *subheader;


@property (assign) NSWindowController *colorPanelWindowController;
@property (assign) NSMenu *menu;

- (void)urlButtonClicked:(id)sender;
- (void)buttonClicked:(id)sender;
- (void)showPreferences:(id)sender;
- (void)quitApplication:(id)sender;

@end
