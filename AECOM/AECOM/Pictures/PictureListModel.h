//
//  PictureListModel.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PictureListModelDelgate
@optional
-(void)getPhotosSuccess;
-(void)getPhotosError:(NSError *)error;
@end
@interface PictureListModel : NSObject <WebServiceDelegate>
{
    NSMutableArray * picturesArray;
}
@property (strong,nonatomic) id <PictureListModelDelgate> delegate;
-(void)getPhotos;
- (NSInteger)numberOfSectionsInCollectionView;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
-(AEVRData *)getItemAtIndexPath:(NSIndexPath *)indexpath;
-(NSMutableArray *)getPicturesArray;
@end
