//
//  RSAppDelegate.h
//  RecieptScanner
//
//  Created by Kári Tristan Helgason on 31.5.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
