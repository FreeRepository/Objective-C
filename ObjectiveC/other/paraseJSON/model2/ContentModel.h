//
//  ContentModel.h
//  ObjectiveC
//
//  Created by hello on 2019/4/16.
//  Copyright © 2019 William. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentModel : NSObject

@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *number;
@property(nonatomic, strong)NSString *address;

-(ContentModel *)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
