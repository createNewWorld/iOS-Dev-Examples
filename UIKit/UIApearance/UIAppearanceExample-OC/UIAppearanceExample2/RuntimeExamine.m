//
//  RuntimeExamine.m
//  UIAppearanceExample2
//
//  Created by hanhui on 15/7/18.
//  Copyright © 2015年 iosdev. All rights reserved.
//

#import "RuntimeExamine.h"
#import "RoundLabel.h"
#import <objc/runtime.h>

@implementation RuntimeExamine

+ (void)examineUIAppearance {
    
    unsigned int outCount = 0;
    
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    
    id appearance = [appearanceClass performSelector:NSSelectorFromString(@"_appearanceForClass:withContainerList:") withObject:[RoundLabel class] withObject:nil];
    
    NSLog(@"_UIAppearance instance : %@", appearance);
    
    Ivar *variables = class_copyIvarList(appearanceClass, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar variable = variables[i];
        
        id value = object_getIvar(appearance, variable);
        NSLog(@"variable's name: %s, value: %@", ivar_getName(variable), value);
    }
    
    free(variables);
}

+ (void)examineAppearanceRecorder {
    
    unsigned int outCount = 0;
    
    Class recorderClass = NSClassFromString(@"_UIAppearanceRecorder");
    
    id recorder = [recorderClass performSelector:NSSelectorFromString(@"_sharedAppearanceRecorderForClass:whenContainedIn:") withObject:[RoundLabel class] withObject:nil];

    NSLog(@"_UIAppearanceRecorder instance : %@", recorder);
    
    Ivar *variables = class_copyIvarList(recorderClass, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar variable = variables[i];
        
        id value = object_getIvar(recorder, variable);
        NSLog(@"variable's name: %s, value: %@", ivar_getName(variable), value);
    }
    
    free(variables);
}

@end
