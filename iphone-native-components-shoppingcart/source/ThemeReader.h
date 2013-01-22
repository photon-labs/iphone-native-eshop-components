//
//  ThemeReader.h
//  LoginComponent
//
//  Created by Rojaramani on 07/01/13.
//  Copyright (c) 2013 Photon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeReader : NSObject {
    
    NSMutableDictionary* dataDictionary ;
}

-(NSMutableDictionary*)loadDataFromPlist:(NSString*)key;

@end
