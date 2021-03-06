//
//  OATargetMenuViewController.m
//  OsmAnd
//
//  Created by Alexey Kulish on 29/05/15.
//  Copyright (c) 2015 OsmAnd. All rights reserved.
//

#import "OATargetMenuViewController.h"
#import "OAUtilities.h"
#import "OsmAndApp.h"
#import "Localization.h"

@implementation OATargetMenuViewControllerState

@end

@implementation OATargetMenuControlButton

@end

@interface OATargetMenuViewController ()

@end

@implementation OATargetMenuViewController

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _topToolbarType = ETopToolbarTypeFixed;
    }
    return self;
}

- (void) setLocation:(CLLocationCoordinate2D)location
{
    _location = location;
    _formattedCoords = [[[OsmAndApp instance] locationFormatterDigits] stringFromCoordinate:location];
}

- (BOOL) needAddress
{
    return YES;
}

- (NSString *) getTypeStr
{
    return [self getCommonTypeStr];
}

- (NSString *) getCommonTypeStr
{
    return OALocalizedString(@"sett_arr_loc");
}

- (NSAttributedString *) getAttributedTypeStr
{
    return nil;
}

- (NSAttributedString *) getAttributedCommonTypeStr
{
    return nil;
}

- (NSAttributedString *) getAttributedTypeStr:(NSString *)group
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:15.0];
    
    NSMutableAttributedString *stringGroup = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", group]];
    NSTextAttachment *groupAttachment = [[NSTextAttachment alloc] init];
    groupAttachment.image = [OAUtilities tintImageWithColor:[UIImage imageNamed:@"map_small_group.png"] color:UIColorFromRGB(0x808080)];
    
    NSAttributedString *groupStringWithImage = [NSAttributedString attributedStringWithAttachment:groupAttachment];
    [stringGroup replaceCharactersInRange:NSMakeRange(0, 1) withAttributedString:groupStringWithImage];
    [stringGroup addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:-2.0] range:NSMakeRange(0, 1)];
    
    [string appendAttributedString:stringGroup];
    
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
    return string;
}

- (UIColor *) getAdditionalInfoColor
{
    return nil;
}

- (NSAttributedString *) getAdditionalInfoStr
{
    return nil;
}

- (UIImage *) getAdditionalInfoImage
{
    return nil;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _navBar.hidden = YES;
    _actionButtonPressed = NO;
    
    if ([self hasTopToolbarShadow])
    {
        // drop shadow
        [self.navBar.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.navBar.layer setShadowOpacity:0.3];
        [self.navBar.layer setShadowRadius:3.0];
        [self.navBar.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    }
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) buttonBackPressed:(id)sender
{
    if (self.topToolbarType == ETopToolbarTypeFloating)
    {
        if (self.delegate)
            [self.delegate requestHeaderOnlyMode];
    }

    [self backPressed];
}

- (IBAction) buttonOKPressed:(id)sender
{
    _actionButtonPressed = YES;
    [self okPressed];
}

- (IBAction) buttonCancelPressed:(id)sender
{
    _actionButtonPressed = YES;
    if (self.topToolbarType == ETopToolbarTypeFloating)
    {
        if (self.delegate)
            [self.delegate requestHeaderOnlyMode];
    }
    [self cancelPressed];
}

- (void) backPressed
{
    // override
}

- (void) okPressed
{
    // override
}

- (void) cancelPressed
{
    // override
}

- (BOOL) hasContent
{
    return YES; // override
}

- (CGFloat) contentHeight
{
    return 0.0; // override
}

- (void) setContentBackgroundColor:(UIColor *)color
{
    _contentView.backgroundColor = color;
}

- (BOOL) hasInfoView
{
    return [self hasInfoButton] || [self hasRouteButton];
}

- (BOOL) hasInfoButton
{
    return [self hasContent] && ![self isLandscape];
}

- (BOOL) hasRouteButton
{
    return YES;
}

- (BOOL) showTopControls
{
    if (self.delegate)
        return ![self.delegate isInFullMode] && ![self.delegate isInFullScreenMode] && self.topToolbarType != ETopToolbarTypeFixed;
    else
        return NO;
}

- (BOOL) supportMapInteraction
{
    return NO; // override
}

- (BOOL) showNearestWiki;
{
    return NO; // override
}

- (BOOL) supportFullMenu
{
    return YES; // override
}

- (BOOL) supportFullScreen
{
    return YES; // override
}

- (void) goHeaderOnly
{
    // override
}

- (void) goFull
{
    // override
}

- (void) goFullScreen
{
    // override
}

- (BOOL) hasTopToolbar
{
    return NO; // override
}

- (BOOL) shouldShowToolbar
{
    return NO; // override
}

- (BOOL) hasTopToolbarShadow
{
    return YES;
}

- (void) setTopToolbarType:(ETopToolbarType)topToolbarType
{
    _topToolbarType = topToolbarType;
}

- (void) applyTopToolbarTargetTitle
{
    if (self.delegate)
        self.titleView.text = [self.delegate getTargetTitle];
}

- (void) setTopToolbarAlpha:(CGFloat)alpha
{
    if ([self hasTopToolbar])
    {
        switch (self.topToolbarType)
        {
            case ETopToolbarTypeFloating:
            case ETopToolbarTypeMiddleFixed:
                if (self.navBar.alpha != alpha)
                    self.navBar.alpha = alpha;
                break;
                
            case ETopToolbarTypeFixed:
                [self applyGradient:self.topToolbarGradient topToolbarType:ETopToolbarTypeFixed alpha:alpha];
                self.navBar.alpha = 1.0;
                break;

            default:
                break;
        }
    }
}

- (void) setMiddleToolbarAlpha:(CGFloat)alpha
{
    if ([self hasTopToolbar])
    {
        CGFloat backButtonAlpha = alpha;
        if (self.topToolbarType != ETopToolbarTypeFloating)
            backButtonAlpha = 0;
        
        if (self.buttonBack.alpha != backButtonAlpha)
            self.buttonBack.alpha = backButtonAlpha;
        
        if (self.topToolbarType == ETopToolbarTypeMiddleFixed)
        {
            if (alpha < 1)
            {
                [self applyGradient:self.topToolbarGradient topToolbarType:ETopToolbarTypeMiddleFixed alpha:1.0];
                self.navBar.alpha = alpha;
            }
            else
            {
                [self applyGradient:self.topToolbarGradient topToolbarType:ETopToolbarTypeFixed alpha:alpha - 1.0];
                self.navBar.alpha = 1.0;
            }
        }
    }
}

- (void) applyGradient:(BOOL)gradient alpha:(CGFloat)alpha
{
    [self applyGradient:gradient topToolbarType:self.topToolbarType alpha:alpha];
}

- (void) applyGradient:(BOOL)gradient topToolbarType:(ETopToolbarType)topToolbarType alpha:(CGFloat)alpha
{
    if (self.titleGradient && gradient)
    {
        _topToolbarGradient = YES;
        switch (topToolbarType)
        {
            case ETopToolbarTypeFixed:
                self.titleGradient.alpha = 1.0 - alpha;
                self.navBarBackground.alpha = alpha;
                self.titleGradient.hidden = NO;
                self.navBarBackground.hidden = NO;
                break;
                
            case ETopToolbarTypeMiddleFixed:
                self.titleGradient.alpha = alpha;
                self.navBarBackground.alpha = 0;
                self.titleGradient.hidden = NO;
                self.navBarBackground.hidden = YES;
                break;
                
            default:
                break;
        }
    }
    else
    {
        _topToolbarGradient = NO;
        self.titleGradient.alpha = 0.0;
        self.titleGradient.hidden = YES;
        self.navBarBackground.alpha = 1.0;
        self.navBarBackground.hidden = NO;
    }
}

- (BOOL) disablePanWhileEditing
{
    return NO; // override
}

- (BOOL) supportEditing
{
    return NO; // override
}

- (void) activateEditing
{
    // override
}

- (BOOL) commitChangesAndExit
{
    return YES; // override
}

- (BOOL) preHide
{
    return YES; // override
}

- (id) getTargetObj
{
    return nil; // override
}

- (OATargetMenuViewControllerState *)getCurrentState
{
    return nil; // override
}

- (BOOL) isLandscape
{
    return DeviceScreenWidth > 470.0 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

- (BOOL) hasControlButtons
{
    return self.leftControlButton || self.rightControlButton;
}

- (void) leftControlButtonPressed;
{
    // override
}

- (void) rightControlButtonPressed;
{
    // override
}

@end
