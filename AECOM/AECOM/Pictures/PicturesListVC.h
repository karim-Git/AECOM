//
//  PicturesListVC.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureListModel.h"
@interface PicturesListVC : UIViewController <PictureListModelDelgate>
{
    PictureListModel * currentModel;
}
@property (strong,nonatomic) IBOutlet UICollectionView * picturesCollectionView;
@end
