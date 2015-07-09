//
//  CDZWeakArray.h
//
//
//  Created by baight on 14-8-19.
//  Copyright (c) 2014年 baight. All rights reserved.
//

#import <Foundation/Foundation.h>

// 一个弱引用数据


@interface CDZWeakArray : NSObject <NSFastEnumeration>{
    NSMutableArray* _array;
    
    id __unsafe_unretained *_itemsPtr;  // 迭代时，用的指针
}

-(id)initWithCapacity:(NSUInteger)numItems;

-(void)addObject:(id)anObject;
-(void)removeObject:(id)anObject;
-(BOOL)containsObject:(id)anObject;

-(NSInteger)count;

-(id)firstObject;
-(id)lastObject;
-(id)objectAtIndex:(NSUInteger)index;

-(void)removeAllObjects;
-(void)removeLastObject;

-(void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;

@end




