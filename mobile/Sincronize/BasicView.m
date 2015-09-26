//
//  BasicView.m
//  Sincronize
//
//  Created by Fabio Martinez on 27/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "BasicView.h"
#import "Helper.h"

@implementation BasicView

-(void) setBackgroud{
    
    switch ([Helper screenHeight]) {
            
            // iPhone 4s
        case 480:
            [self.imgBackgroud setImage:[UIImage imageNamed:@"bg_iphone_4"]];
            break;
            
            // iPhone 5s
        case 568:
            [self.imgBackgroud setImage:[UIImage imageNamed:@"bg_iphone_5s"]];
            break;
            
            // iPhone 6
        case 667:
            [self.imgBackgroud setImage:[UIImage imageNamed:@"bg_iphone_6"]];
            break;
            
            // iPhone 6 Plus
        case 736:
            [self.imgBackgroud setImage:[UIImage imageNamed:@"bg_iphone_6p"]];
            break;
            
        default:
            // it's an iPad
            //imagemBg = [UIImage imageNamed:@"bg_face_ipad"];
            break;
    }
    
}

-(void) setLayout{
    [self setBackgroud];

}

@end
