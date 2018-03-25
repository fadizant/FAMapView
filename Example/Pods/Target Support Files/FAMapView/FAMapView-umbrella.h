#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FAMap.h"
#import "FAMapView.h"
#import "FAMapViewController.h"
#import "UIAlertController+FAMapAlertController.h"

FOUNDATION_EXPORT double FAMapViewVersionNumber;
FOUNDATION_EXPORT const unsigned char FAMapViewVersionString[];

