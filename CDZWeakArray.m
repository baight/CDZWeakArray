//
//  CDZWeakArray.m
//  
//
//  Created by zhengchen2 on 14-8-19.
//  Copyright (c) 2014年 Leo Chain. All rights reserved.
//

#import "CDZWeakArray.h"

@interface CDZWeakReferences : NSObject
@property (nonatomic, assign) id object;
-(id)initWithObject:(id)object;
@end


@implementation CDZWeakArray

-(id)init{
    self = [super init];
    if(self){
        _array = [[NSMutableArray alloc]init];
    }
    return self;
}

-(id)initWithCapacity:(NSUInteger)numItems{
    self = [super init];
    if(self){
        _array = [[NSMutableArray alloc]initWithCapacity:numItems];
    }
    return self;
}

-(void)addObject:(id)anObject{
    CDZWeakReferences* weakReferences = [[CDZWeakReferences alloc]initWithObject:anObject];
    [_array addObject:weakReferences];
}

-(BOOL)containsObject:(id)anObject{
    for(CDZWeakReferences* weakReferences in _array){
        if(weakReferences.object == anObject){
            return YES;
        }
    }
    return FALSE;
}

-(void)removeObject:(id)anObject{
    NSMutableArray* removeArray = nil;
    for(CDZWeakReferences* weakReferences in _array){
        if(weakReferences.object == anObject){
            if(removeArray == nil){
                removeArray = [[NSMutableArray alloc]init];
            }
            [removeArray addObject:weakReferences];
        }
    }
    for(CDZWeakReferences* weakReferences in removeArray){
        [_array removeObject:weakReferences];
    }
}

-(void)removeAllObjects{
    [_array removeAllObjects];
}
-(void)removeLastObject{
    [_array removeLastObject];
}
-(id)firstObject{
    return [[_array firstObject] object];
}
-(id)lastObject{
    return [[_array lastObject] object];
}
-(id)objectAtIndex:(NSUInteger)index{
    return [[_array objectAtIndex:index] object];
}
-(NSInteger)count{
    return [_array count];
}

#pragma mark - NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len{
    
    NSUInteger retCount = [_array countByEnumeratingWithState:state objects:buffer count:len];
    
    if(_itemsPtr){
        free(_itemsPtr);
        _itemsPtr = nil;
    }
    if(retCount > 0){
        _itemsPtr = (id __unsafe_unretained *)malloc(sizeof(id __unsafe_unretained*)*retCount);
        for (int i=0; i<retCount; i++) {
            CDZWeakReferences* object = state->itemsPtr[i];
            _itemsPtr[i] = [object object];
        }
        state->itemsPtr = _itemsPtr;
    }
    return retCount;
}

@end

@implementation CDZWeakReferences
-(id)initWithObject:(id)object{
    self = [super init];
    if(self){
        self.object = object;
    }
    return self;
}
@end
