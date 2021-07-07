//
//  BasicGameViewController.m
//  HelloWorld
//
//  Created by Michael Fuller on 4/5/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

#import "BasicGameViewController.h"

@interface BasicGameViewController ()

@end

@implementation BasicGameViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor appWhiteColor]];
    float x = 10;
    float y = 10;
    // Adding back button
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 100, 40)];
    [backButton setTitle:@"BACK" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont appSmallFont]];
    [backButton.layer setBorderColor:[UIColor twitterBGColor].CGColor];
    backButton.layer.borderWidth = 1.0f;
    [backButton addTarget:self action:@selector(exitClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Use white color
    //[backButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]
                                forKey:@"orientation"];}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}


-(SCNScene *) generateScene {

    
    SCNScene * scene = [SCNScene scene];
    
    SCNSphere *sphere = [SCNSphere sphereWithRadius:100.0];
    SCNMaterial *material = [SCNMaterial material];
    //material.diffuse.contents = [UIImage imageNamed:@"09.jpg"];
    material.diffuse.contents = [UIImage imageWithContentsOfFile:self.videoPath];
    material.specular.contents = [UIColor whiteColor];
    material.shininess = 1.0;
    material.doubleSided = YES;
    sphere.materials = [NSArray arrayWithObject:material];

    SCNNode * spherenode = [SCNNode nodeWithGeometry:sphere];
    spherenode.categoryBitMask = 3;
    spherenode.transform = SCNMatrix4MakeTranslation( 0.0, 60.0, 0.0);
    spherenode.transform = SCNMatrix4Scale (spherenode.transform, -1, 1, 1);
    spherenode.transform =   SCNMatrix4Rotate( spherenode.transform, M_PI_2, 1.0, 0.0, 0.0);
    spherenode.transform =   SCNMatrix4Rotate( spherenode.transform, M_PI, 0.0, 0.0, 1.0);

    [scene.rootNode addChildNode:spherenode];
    
    return scene;
}

-(void) afterGenerateScene {
    SCNViewpoint * viewpoint = [self generateGhostViewpoint];
    [self.scene.rootNode addChildNode:viewpoint];
    
    [self setViewpointTo:viewpoint];

    //self.scene.background.contents = @[@"void.png",@"void.png",@"void.png",@"void.png",@"void.png",@"void.png"];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [super glkView:view drawInRect:rect];
    
    if (_requestExit) {
        [self exitLogic];
    }
}

-(void) exitClicked {
    _requestExit = YES;
}

-(void) exitLogic {
    [self setPaused:true];
    [self.navigationController popViewControllerAnimated:NO];
    //[self performSegueWithIdentifier:@"exitToHome" sender:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] < 1) return;
    
    if ([touches count] >= 3) {
        _requestExit = YES;
    }
    
    CGPoint point = [[touches anyObject] locationInView:[self view]];
    
    float adjustedX = point.x * self.nativeScale;
    float adjustedY = (self.profile.landscapeView ? self.profile.physicalHeightPX : self.profile.physicalWidthPX) - (point.y * self.nativeScale);
    
    BOOL resetView = NO;
    
    if (self.profile.basicView == YES) {
        
        BOOL inVirtualView = (adjustedX > self.profile.virtualOffsetLeft && adjustedX < self.profile.virtualOffsetLeft + self.profile.virtualWidthPX) && (adjustedY > self.profile.virtualOffsetBottom && adjustedY < self.profile.virtualOffsetBottom + self.profile.virtualHeightPX);
        
        if (self.profile.viewportCount == 1) {
            
            if (inVirtualView) {
                //forcedTapX = adjustedX - self.profile.virtualOffsetLeft;
                //forcedTayY = adjustedY - self.profile.virtualOffsetBottom;
            } else {
                resetView = YES;
            }
            
        } else {
            
            if (inVirtualView) {
                
                BOOL inLeftEye = (adjustedX > self.profile.virtualOffsetLeft && adjustedX < self.profile.virtualOffsetLeft + (self.profile.virtualWidthPX / 2)) && (adjustedY > self.profile.virtualOffsetBottom && adjustedY < self.profile.virtualOffsetBottom + self.profile.virtualHeightPX);
                if (inLeftEye) {
                    // Tap
                    //forcedTapX = adjustedX - self.profile.virtualOffsetLeft;
                    //forcedTayY = adjustedY - self.profile.virtualOffsetBottom;
                } else {
                    resetView = YES;
                }
                
            } else {
                resetView = YES;
            }
        }
    } else {
        resetView = YES;
    }
    
    if (resetView) {
        [self.profile.tracker calibrate];
    }
}

@end
