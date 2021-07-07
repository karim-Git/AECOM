//
//  PicturesListVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "PicturesListVC.h"
#import "PictureDetailsVC.h"

@implementation PicturesListVC
@synthesize picturesCollectionView;
-(void)viewDidLoad
{
    currentModel = [[PictureListModel alloc] init];
    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Images"];
    [ReusedMethods addBottomViewOn:self.view index:2];
    
    self.picturesCollectionView.alwaysBounceVertical = YES;
    [self.picturesCollectionView registerClass:[PictureCell class] forCellWithReuseIdentifier:@"Cell"];
    self.picturesCollectionView.backgroundColor=[UIColor blackColor];
    self.picturesCollectionView.alwaysBounceVertical = YES;
    [ReusedMethods addTableViewBackGroundColor:self.picturesCollectionView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelectorOnMainThread:@selector(loadingActivity) withObject:nil waitUntilDone:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    currentModel = [[PictureListModel alloc] init];
    currentModel.delegate = self;
    [currentModel getPhotos];
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

#pragma mark Model delegate

-(void)getPhotosSuccess
{
    [self.picturesCollectionView reloadData];
    [self hideActivity];
}
-(void)getPhotosError:(NSError *)error
{
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [currentModel numberOfSectionsInCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return [currentModel numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    AEVRData * data = [currentModel getItemAtIndexPath:indexPath];
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:data.url] placeholderImage:[UIImage loadingImage]];
    [ReusedMethods setLeftLabelBGColor:cell.leftLabel AtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (self.view.frame.size.width - 50)/2.0f;
    return CGSizeMake(width,width);
   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureDetailsVC * detailsVC = [[PictureDetailsVC alloc] init];
    detailsVC.selectedIndex = (int)indexPath.row;
    detailsVC.dataArray = [currentModel getPicturesArray];
    [self.navigationController pushViewController:detailsVC animated:YES];
}


@end
