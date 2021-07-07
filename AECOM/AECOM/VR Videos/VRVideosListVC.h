//
//  VRVideosListVC.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//
#define IMAGEVIEW_TAG  207
#define TITLE_TAG 208
#define VR_TYPE @"vrType"
#define VR_TYPE_VIDEO @"VR_VIDEO"
#define VR_TYPE_STILL @"VR_STILL"

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "VRVideoListModel.h"

@interface VRVideosListVC : UIViewController<iCarouselDataSource, iCarouselDelegate,VRVideoListModelDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *  expandableImageView;
    int  photoIndex;
    NSMutableArray * virtualTourImagesArray, *titlesArray;
    UILabel  * titleLabel;
    iCarousel  *  carouselView;
    VRVideoListModel * currentModel;
}

@property (strong,nonatomic)  UITableView * videosListTableView;
@end
