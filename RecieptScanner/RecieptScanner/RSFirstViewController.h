//
//  RSFirstViewController.h
//  RecieptScanner
//
//  Created by Kári Tristan Helgason on 31.5.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSFirstViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (void)sendImageDataToServer:(UIImage*)imageToPost;

- (IBAction)scan:(id)sender;


@end
