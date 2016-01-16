//
//  car.m
//  J-Walker
//
//  Created by Alan Hu on 2014-12-27.
//  Copyright (c) 2014 Alan Hu. All rights reserved.
//

#import "Car.h"

@implementation Car

-(id)init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
    
}

-(void)CarMoving{
    if(arc4random() % (5+5+1) - 5 > 0) {
        _carAccel = 0;
        
    } else if(_iniSpeed < 0) {
        _carAccel = -7;
    } else {
        _carAccel = 7;
    }

    _carSpeed += _carAccel;
    _carFriction = -0.1 * _carSpeed;
    _carSpeed += _carFriction;
    _carImage.center = CGPointMake(_carImage.center.x, _carImage.center.y + _carSpeed);
    

    if (_carImage.center.y > 600) {
        _carImage.center = CGPointMake(_carImage.center.x, 0);
    } else if (_carImage.center.y < 0) {
        _carImage.center = CGPointMake(_carImage.center.x, 600);
    }
}

@end
