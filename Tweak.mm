//Created by canshe(canshe@126.com) on 2014.12.16
//Thanks to Jiva DeVoe for "RIButtonItem" and "UIAlertView+Blocks".


#import "SpringBoard/SBLockScreenFullscreenBulletinViewController.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"

static UIAlertView *alert;
static BOOL hasPressLockButton = false;

%hook SBLockScreenFullscreenBulletinViewController

- (void)loadView
{
    
    %orig();
    NSString * alarmTitle = (NSString *) [self.bulletinItem title];
    {
        hasPressLockButton = false;
        RIButtonItem *snoozeItem = [RIButtonItem item];
        snoozeItem.label = @"Snooze";
        snoozeItem.action = ^
        {
            [self performSnoozeAction];
            hasPressLockButton = true;
        };
        
        RIButtonItem *stopItem = [RIButtonItem item];
        stopItem.label = @"OK";
        stopItem.action = ^
        {
            
            [self performUnlockAction];
            hasPressLockButton = true;
        };
        
        alert = [[UIAlertView alloc] initWithTitle:alarmTitle
                                                        message:nil
                                               cancelButtonItem:snoozeItem
                                               otherButtonItems:stopItem,nil];
        [alert show];
        [alert release];
    }

}

- (void)lockButtonPressed:(id)arg1
{
    @try
    {
        
        if(alert != nil && hasPressLockButton == false)
        {
            [alert dismissWithClickedButtonIndex:0
                                animated:YES];
            
            hasPressLockButton = true;
        }
        else
        {
            %orig(arg1);
        }
    }
    @catch (NSException *e)
    {
        
    }
}
%end