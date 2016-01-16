//
//  ViewController.m
//  J-Walker
//
//  Created by Alan Hu on 2014-12-24.
//  Copyright (c) 2014 Alan Hu. All rights reserved.
//
#import "Car.h"
#import "ViewController.h"
#import "SoundPlayer.h"
int carSpeed = 10;
int carWidth = 110;
int carHeight = 50;
int studentSpeed = 0;
int studentImg = 1;
int acceleration = 6;
int friction = 2;
int amountOfCars = 1;
NSString *fileName;
NSString *frontFile = @"s";
Car *newCar[1];
NSString *carName;
int carFileCounter = 1;
NSTimer *generateRightLane;
NSTimer *generateLeftLane;
int amountOfSImg = 10;
BOOL isForward = true;
BOOL ableToRetry = false;
BOOL startGame = false;
AVAudioPlayer *audioPlayer;


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    student = [[UIImageView alloc] initWithFrame:CGRectMake(150,150,50,50)];
    student.center = CGPointMake(1, 400);
    student.image = [UIImage imageNamed: @"s1.png"];
    [self.view addSubview: student];

    
    // Create audio player object and initialize with URL to sound

    student.frame = CGRectMake(100,100,60,60);
    //[self StartGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateCars:(NSTimer*)time  {
    if (carFileCounter <= amountOfCars) { //insert amount of cars
        newCar[carFileCounter] = [[Car alloc] init];
        newCar[carFileCounter].carImage = [[UIImageView alloc] initWithFrame:CGRectMake(150,150,100,100)];
        NSString *tempCar = [@"car" stringByAppendingString:[NSString stringWithFormat:@"%d", carFileCounter]];
        carName = [tempCar stringByAppendingString:@".png"];
        newCar[carFileCounter].carImage.image = [UIImage imageNamed:carName];
        if ([[time userInfo] intValue] > 200) {
            newCar[carFileCounter].iniSpeed = 5;
             newCar[carFileCounter].carImage.center = CGPointMake([[time userInfo] intValue], 50); //230
        } else {
            newCar[carFileCounter].iniSpeed = -5;
             newCar[carFileCounter].carImage.center = CGPointMake([[time userInfo] intValue], 600);
        }
        newCar[carFileCounter].carSpeed = newCar[carFileCounter].iniSpeed ;
        [self.view addSubview: newCar[carFileCounter].carImage];
        
        newCar[carFileCounter].CarMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:newCar[carFileCounter] selector:@selector(CarMoving) userInfo:nil repeats:YES];
    carFileCounter ++;
    }
    
}

-(void)StudentMoving{
    if (studentSpeed > 0) {
        student.center = CGPointMake(student.center.x + studentSpeed, student.center.y);
        studentSpeed -= 0.1 * studentSpeed;//friction
        //making the walking animation
        NSString *temp1 = [frontFile stringByAppendingString:[NSString stringWithFormat:@"%d", studentImg]];
        fileName = [temp1 stringByAppendingString:@".png"];
        student.image = [UIImage imageNamed:fileName];
        studentImg += 1; // increment file counter
    } else if (studentSpeed < 0){
        studentImg += 1; // increment file counter
        NSString *temp1 = [frontFile stringByAppendingString:[NSString stringWithFormat:@"%d", studentImg]];
        fileName = [temp1 stringByAppendingString:@".png"];
        student.image = [UIImage imageNamed: fileName];
        UIImage *flipped = student.image;
        flipped = [UIImage imageWithCGImage:flipped.CGImage scale:flipped.scale orientation:UIImageOrientationUpMirrored];
        student.image = flipped;
        student.center = CGPointMake(student.center.x + studentSpeed, student.center.y);
        studentSpeed += 0.1 * -studentSpeed;
        //making the walking animation backwards

    } else {
        student.image = [UIImage imageNamed: @"rest.png"];
    }
    
    if(studentImg == amountOfSImg) {
        studentImg = 1;
    }
    //checking if car intersects person
   for (int i = 0; i <= carFileCounter - 1; i++) {
        if (CGRectIntersectsRect(student.frame,newCar[i].carImage.frame)) {
            [self gameOver];
        }
    }
    if (student.center.x < 0) {
        studentSpeed += acceleration;
    } else if(student.center.x > 400) {
        student.center = CGPointMake(0 + studentSpeed, student.center.y - 100);
    }
}
-(void) gameOver{
    //[audioPlayer play];
    [StudentMovement invalidate];
    scoreBoard.text = @"0";
    student.image = NULL;
    for (int i = 0; i <= carFileCounter - 1; i++) {
        [newCar[i].CarMovement  invalidate];
        newCar[i].driver = [[UIImageView alloc] initWithFrame:CGRectMake(140,140,90,90)];
        newCar[i].driver.image = [UIImage imageNamed:@"exclamation.png"];
        newCar[i].driver.center = CGPointMake(newCar[i].carImage.center.x - 100,newCar[i].carImage.center.y);
        [self.view addSubview: newCar[i].driver];
    }
    ableToRetry = true;
}

-(void) StartGame {
    carFileCounter = 1;
    generateRightLane = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(generateCars:) userInfo:@"260" repeats:YES];
    amountOfCars = 2;
    generateLeftLane = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(generateCars:) userInfo:@"100" repeats:YES];
        StudentMovement = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(StudentMoving) userInfo:nil repeats:YES];
    ableToRetry = false;

}
-(void) resetGame {
    student = [[UIImageView alloc] initWithFrame:CGRectMake(150,150,50,50)];
    student.center = CGPointMake(1, 400);
    student.image = [UIImage imageNamed: @"s1.png"];
    [self.view addSubview: student];
    for (int i = 0; i <= carFileCounter; i++) {
        newCar[i].driver.image = NULL;
        newCar[i].carImage.image = NULL;
        newCar[i].driver = NULL;
        newCar[i].carImage = NULL;
        [self.view addSubview: newCar[i].driver];
        [self.view addSubview: newCar[i].carImage];
    }
    [self StartGame];
}
- (IBAction)moveLeft:(id)sender { //go left
    if (!ableToRetry) {
        scoreBoard.text = [NSString stringWithFormat:@"%d", [scoreBoard.text intValue] - 4];
    isForward = false;
    studentSpeed -= acceleration;
    } else {
        [self resetGame];
    }
}

- (IBAction)moveRight:(id)sender {
    scoreBoard.text = [NSString stringWithFormat:@"%d", [scoreBoard.text intValue] + 10];
    isForward = true;
    studentSpeed += acceleration;
}

- (IBAction)startCommand:(id)sender {
    if(!startGame) {
        [self StartGame];
        startGame = true;
    }
    startButton.hidden=true;
    
    
}



@end
