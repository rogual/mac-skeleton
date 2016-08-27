#import <Cocoa/Cocoa.h>

NSString *getAppName() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}

void initMenu() {
    NSString *appName = getAppName();

    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];
    id appMenu = [[NSMenu new] autorelease];
    id quitTitle = [@"Quit " stringByAppendingString:appName];
    id quitMenuItem = [[[NSMenuItem alloc] initWithTitle:quitTitle
        action:@selector(terminate:) keyEquivalent:@"q"] autorelease];
    [appMenu addItem:quitMenuItem];
    [appMenuItem setSubmenu:appMenu];
}

void initWindow() {
    NSString *appName = getAppName();

    id window = [[[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 200, 200)
        styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:NO]
            autorelease];
    [window cascadeTopLeftFromPoint:NSMakePoint(20,20)];
    [window setTitle:appName];
    [window makeKeyAndOrderFront:nil];
}

int main()
{
    [NSAutoreleasePool new];
    [NSApplication sharedApplication];

    initMenu();
    initWindow();

    [NSApp activateIgnoringOtherApps:YES];
    [NSApp run];
}
