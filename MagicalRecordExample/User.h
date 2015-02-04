//
//  User.h
//  MagicalRecordExample
//
//  Created by moyan on 15-2-4.
//  Copyright (c) 2015年 moyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * name;

@end
