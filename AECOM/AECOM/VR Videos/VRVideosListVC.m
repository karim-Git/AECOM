//
//  VRVideosListVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "VRVideosListVC.h"
#import "VideoDownloadVC.h"

@implementation VRVideosListVC

-(void)viewDidLoad
{
    [self makeUIChanges];

    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Virtual Reality"];
    [ReusedMethods addBottomViewOn:self.view index:1];
    
    
//    NSInteger launchTimes = [[NSUserDefaults standardUserDefaults] integerForKey:@"HomeScreenLaunchTimes"];
//    if (!launchTimes)
//    {
//        [self setUpHelpTutorialCarousel];
//        photoIndex  =   0;
//    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    [self performSelectorOnMainThread:@selector(loadingActivity) withObject:nil waitUntilDone:YES];
    currentModel = [[VRVideoListModel alloc] init];
    currentModel.delegate = self;
    [currentModel getListOfVideos];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void)makeUIChanges
{
    float yVal = 55;
    self.videosListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, yVal, self.view.frame.size.width, self.view.frame.size.height - yVal-55)];
    self.videosListTableView.delegate = self;
    self.videosListTableView.dataSource = self;
    self.videosListTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [ReusedMethods addTableViewBackGroundColor:self.videosListTableView];
    [ReusedMethods addTableViewBackGroundColor:self.view];
    [self.view addSubview:self.videosListTableView];
   
}

# pragma  mark  ---------iCarousel SETUP METHODS  -------
- (void) setUpHelpTutorialCarousel
{
    virtualTourImagesArray  =   [[NSMutableArray alloc] initWithObjects:@"1.jpg",@"1.jpg",@"1.jpg",@"1.jpg",@"1.jpg",@"1.jpg",nil];

    float xPos  =  0;
    float yPos  =   NAVIGATION_HEIGHT + 15; //  navheight  = 65  + 15 ;
    float width  =  CGRectGetWidth(self.view.frame)  -  (2 * xPos);
    float height  =  CGRectGetHeight(self.view.frame) -  yPos;
    
    
    // set up iCarousel
    carouselView = [[iCarousel alloc] initWithFrame:CGRectMake(
                                                               xPos,
                                                               yPos,
                                                               width,
                                                               height
                                                               )];
    [carouselView setBackgroundColor:[UIColor transperantGrayColor]];
    carouselView.type = iCarouselTypeCoverFlow2;
    carouselView.dataSource = self;
    carouselView.delegate = self;
    
    
    float btnWidth =  60;
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
    [carouselView addSubview:closeButton];
    
    [self.view addSubview:carouselView];
    
    carouselView.pagingEnabled = YES;
}


# pragma  mark  ---------CAROSEL  DELEGATE  METHODS  -------

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [virtualTourImagesArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView * imageView;
    UILabel  *  titleLabel1;
    
    float xPos  =  0;
    float yPos  =   NAVIGATION_HEIGHT + 15; //  navheight  = 65  + 15 ;
    float width  =  CGRectGetWidth(self.view.frame)  -  (2 * xPos);
    float height  =  CGRectGetHeight(self.view.frame) -  yPos;
    
    if (view == nil) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        titleLabel1 =  [[UILabel alloc] initWithFrame:CGRectMake(10, 0, width, 40)];
        titleLabel1.font = [UIFont appBigFont];
        [titleLabel1 setBackgroundColor:[UIColor clearColor]];
        [titleLabel1 setTextColor:[UIColor  appThemeColor]];
        [titleLabel1 setTextAlignment:NSTextAlignmentLeft];
        [titleLabel1 setNumberOfLines:0];
        [titleLabel1 setLineBreakMode:NSLineBreakByWordWrapping];
        [titleLabel1  setTag:TITLE_TAG];
       // [view  addSubview:titleLabel1];
        
        // Adding UIImageView
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel1.frame), view.frame.size.width - 80, view.frame.size.width - 80)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.center = view.center;
        imageView.layer.cornerRadius = 15.0f;
        imageView.layer.masksToBounds = YES;
        imageView.tag  =  IMAGEVIEW_TAG;
        [view addSubview:imageView];
        
    }
    else{
        imageView = (UIImageView *) [view  viewWithTag:IMAGEVIEW_TAG];
        titleLabel1 = (UILabel  *) [view  viewWithTag:TITLE_TAG];
    }
    
    [imageView  setImage:[UIImage  imageNamed:[virtualTourImagesArray  objectAtIndex:index]]];
    // [titleLabel setText:[titlesArray objectAtIndex:index]];
    [titleLabel1  setText:[titlesArray objectAtIndex:index]];
    
    
    return view;
}
-(void)dismissTutorialBtnAction:(UIButton*)sender
{
    [carouselView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"HomeScreenLaunchTimes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
//{
//    if (option == iCarouselOptionSpacing) {
//        return value * 1.25f;
//    }
//    return value;
//}

#pragma mark UITableView methods
# pragma mark - TableView DataSource Methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentModel getTableviewRowsCount];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (AEVideoCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CustomCell"];
    AEVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AEVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
    }
    AEVRData * object = [currentModel getCellDataAtIndexPath:indexPath];
    cell.titleLabel.text = object.title;
    cell.timeLabel.text = object.duration;
    [cell.thumbNailImage sd_setImageWithURL:[NSURL URLWithString:object.thumbnail] placeholderImage:[UIImage loadingImage]];
    cell.downloadButton.tag = indexPath.row;
    [cell.downloadButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    if  ([ReusedMethods fileExistAtPathWithId:object._id])
    {
        [cell.downloadButton setTitle:@"DOWNLOADED" forState:UIControlStateNormal];
      
    }
    else
    {
        [cell.downloadButton setTitle:@"DOWNLOAD" forState:UIControlStateNormal];
    }
    if ([object.VRType isEqualToString:VR_TYPE_STILL])
    {
        [cell.videoTypeButton setTitle:@"VR" forState:UIControlStateNormal];
    }
    else
    {
        [cell.videoTypeButton setTitle:@"360" forState:UIControlStateNormal];
    }
    [cell adjustFrames];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [currentModel getHeightForRowAtIndexPath:indexPath tableView:tableView];
}

#pragma mark Tableview delegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDownloadVC * vc = [[VideoDownloadVC alloc] init];
    vc.selectedVideo = [currentModel getCellDataAtIndexPath:indexPath];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark VRModel delgate methods
-(void)getVideosSuccess
{
    [self.videosListTableView reloadData];
    [self hideActivity];
}
-(void)getVideosError:(NSError *)error
{
    [ReusedMethods showErrorAlert:error];
    [self hideActivity];
}
-(void)loadingActivity
{
    [RBAActivityLoader setupLoaderViewOnView:self.view];
    [RBAActivityLoader showLoaderOnView:self.view withTitle:@"Loading..."];
}

-(void)hideActivity
{
    [RBAActivityLoader removeLoader];
}

#pragma mark download button action
-(void)downloadButtonAction:(UIButton *)downloadButton
{
    VideoDownloadVC * vc = [[VideoDownloadVC alloc] init];
    vc.selectedVideo = [currentModel getCellDataAtIndexPath:[NSIndexPath indexPathForRow:downloadButton.tag inSection:0]];
    [self.navigationController pushViewController:vc animated:NO];
}
@end

