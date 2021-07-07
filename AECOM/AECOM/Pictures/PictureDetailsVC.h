//
//  PictureDetailsVC.h
//  AECOM
//
//  Created by Kareem on 2016-01-12.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureDetailsVC : UIViewController <iCarouselDataSource,iCarouselDelegate>
{
    UIView * titleView;
    UILabel * titleLabel;
    UIButton * leftButton , * rightButton;
    UIImageView * pictureImageView;
        iCarousel  *  carouselView;
}
@property (strong,nonatomic) NSMutableArray * dataArray;
@property (assign) int selectedIndex;
@end
