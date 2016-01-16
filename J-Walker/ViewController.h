//
//  ViewController.h
//  J-Walker
//
//  Created by Alan Hu on 2014-12-24.
//  Copyright (c) 2014 Alan Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIImageView *student;
    NSTimer *CarMovement;
    NSTimer *CarSize;
    NSTimer *StudentMovement;
    IBOutlet UIButton *buttonLeft;
    IBOutlet UILabel *scoreBoard;
    IBOutlet UIButton *buttonRight;
    IBOutlet UIButton *startButton;
}



@end
