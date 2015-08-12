//
//  DDCollectionViewFlowLayout.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-10.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  DDCollectionViewFlowLayout;

@protocol DDCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@required
/**
 *  number of column in section protocol delegate methods
 *
 *  @param collectionView collectionView
 *  @param layout         DDCollectionViewFlowLayout
 *  @param sectionIndex   section index
 *
 *  @return number of column
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
                     layout:(DDCollectionViewFlowLayout *)layout
   numberOfColumnsInSection:(NSInteger)section;

@end


@interface DDCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<DDCollectionViewDelegateFlowLayout> delegate;

@property (nonatomic) BOOL enableStickyHeaders; //Defalut is NO, set it's YES will sticky the section header.

@end
