//
//  PictureDetailsVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-12.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "PictureDetailsVC.h"

@implementation PictureDetailsVC
@synthesize dataArray , selectedIndex;
-(void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor appWhiteColor];
    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Images" WithDelegate:self];
    [self setUpHelpTutorialCarousel];
}

-(void)makeUIChanges
{
    pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width - 20, self.view.frame.size.height - 110)];
    pictureImageView.backgroundColor = [UIColor orangeColor];
    pictureImageView.userInteractionEnabled = YES;
    [self.view addSubview:pictureImageView];
    
    float x = 10;
    float y = CGRectGetMaxY(pictureImageView.frame) + 5;
    float width = CGRectGetWidth(pictureImageView.frame);
    // Adding bottom view
    titleView = [[UIView alloc] initWithFrame:CGRectMake(x, y , width, 40)];
    titleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleView];
    
    // Adding leftbutton
    titleLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont appHeaderFont];
    [titleView addSubview:titleLabel];
    
}


-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma  mark  ---------iCarousel SETUP METHODS  -------
- (void) setUpHelpTutorialCarousel
{

    // set up iCarousel
    carouselView = [[iCarousel alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width - 20, self.view.frame.size.height - 110)];
    [carouselView setBackgroundColor:[UIColor appWhiteColor]];
    carouselView.type = iCarouselTypeCoverFlow2;
    carouselView.dataSource = self;
    carouselView.delegate = self;
    
    
  /*  float btnWidth =  60;
    xPos  =  CGRectGetMaxX(carouselView.frame) -  btnWidth - 10;
    yPos  =   10;
    
    //  Add photo button
    UIButton *closeButton  =  [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame :CGRectMake(xPos, yPos, btnWidth, btnWidth)];
    [closeButton setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [[closeButton  imageView] setContentMode:UIViewContentModeScaleAspectFill];
    [[closeButton layer] setMasksToBounds:YES];
    [[closeButton layer] setCornerRadius:(btnWidth /2)];
    [closeButton  setBackgroundColor:[UIColor greenColor]];
    [closeButton addTarget:self action:@selector(dismissTutorialBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [carouselView addSubview:closeButton];*/
    
    [self.view addSubview:carouselView];
    
    carouselView.pagingEnabled = YES;
    [carouselView scrollToItemAtIndex:selectedIndex animated:NO];
}


# pragma  mark  ---------CAROSEL  DELEGATE  METHODS  -------

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return dataArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView * imageView;
    UILabel  *  titleLabel1;
    
    float xPos  =  0;
    float yPos  =   0;//NAVIGATION_HEIGHT + 15; //  navheight  = 65  + 15 ;
    float width  =  CGRectGetWidth(carousel.frame) ;
    float height  =  CGRectGetHeight(carousel.frame);
    
    if (view == nil) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        titleLabel1 =  [[UILabel alloc] initWithFrame:CGRectMake(10, view.frame.size.height, width, 40)];
        titleLabel1.font = [UIFont appBigFont];
        [titleLabel1 setBackgroundColor:[UIColor clearColor]];
        [titleLabel1 setTextColor:[UIColor  appThemeColor]];
        [titleLabel1 setTextAlignment:NSTextAlignmentLeft];
        [titleLabel1 setNumberOfLines:0];
        [titleLabel1 setLineBreakMode:NSLineBreakByWordWrapping];
        [titleLabel1  setTag:TITLE_TAG];
         [view  addSubview:titleLabel1];
        
        // Adding UIImageView
        
     //   imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel1.frame), view.frame.size.width - 80, view.frame.size.width - 80)];
                imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;//UIViewContentModeScaleToFill
        imageView.center = view.center;
     //   imageView.layer.cornerRadius = 15.0f;
       // imageView.layer.masksToBounds = YES;
        imageView.tag  =  IMAGEVIEW_TAG;
        [view addSubview:imageView];
        
    }
    else{
        imageView = (UIImageView *) [view  viewWithTag:IMAGEVIEW_TAG];
        titleLabel1 = (UILabel  *) [view  viewWithTag:TITLE_TAG];
    }
    AEVRData * data = [dataArray objectAtIndex:index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:data.url] placeholderImage:[UIImage loadingImage]];
 //   [imageView  setImage:[UIImage  imageNamed:[virtualTourImagesArray  objectAtIndex:index]]];
    // [titleLabel setText:[titlesArray objectAtIndex:index]];
    [titleLabel1  setText:data.title];
    
    return view;
}

@end
