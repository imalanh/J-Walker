//
//  car.h
//  J-Walker
//
//  Created by Alan Hu on 2014-12-27.
//  Copyright (c) 2014 Alan Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *driverName;

@interface Car : NSObject
@property int carSpeed;
@property int iniSpeed;
@property IBOutlet UIImageView* carImage;
@property NSTimer *CarMovement;
@property float carAccel;
@property int carFriction;
@property IBOutlet UIImageView* driver;

-(void)CarMoving;
@end
