//
//  UIAlertController+FAMapAlertController.h
//  FAMapView
//
//  Created by Fadi Abuzant on 3/24/18.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (FAMapAlertController)

@property (nonatomic, strong) UIWindow *alertWindow;

- (void)show;
- (void)show:(BOOL)animated;


@end
