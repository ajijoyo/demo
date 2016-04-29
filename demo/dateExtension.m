//
//  dateExtension.m
//  demo
//
//  Created by Dealjava on 4/29/16.
//  Copyright © 2016 originesia. All rights reserved.
//

#import "dateExtension.h"

@implementation NSDate(dateExtension)
@dynamic toString,toStringCurrentTime;

-(NSString*)toString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MM yyyy"];
    
    return [formatter stringFromDate:self];
}

-(NSString*)toStringCurrentTime{
    if (self) {
        BOOL isINA = NO;
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:(NSCalendarUnitDay|
                                                              NSCalendarUnitHour|
                                                              NSCalendarUnitMinute)
                                                    fromDate:self
                                                      toDate:[NSDate date]
                                                     options:0];
        NSInteger dayToday = components.day;
        NSInteger hourToday = components.hour;
        NSInteger minuteToday = components.minute;
        
        NSString *kemarin = isINA ? @"kemarin" : @"yesterday" ;
        NSString *jam = isINA ? @"jam yang lalu" : @"an Hour ago" ;
        NSString *menit = isINA ? @"menit yang lalu" : @"a Minute ago" ;
        NSString *sekarang = isINA ? @"barusan" : @"now" ;
        
        NSDateFormatter *format = [NSDateFormatter new];
        format.dateFormat = @"HH:mm";
        
        if (dayToday == 1) {
            return [NSString stringWithFormat:@"%@, %@",kemarin,[format stringFromDate:self]];
        }
        if (hourToday <= 23 && hourToday > 0) {
            return [NSString stringWithFormat:@"%d %@",hourToday,jam];
        }
        if (minuteToday <= 30 && minuteToday > 0) {
            return [NSString stringWithFormat:@"%d %@",minuteToday,menit];
        }
        if (minuteToday <= 1 && minuteToday >= 0) {
            return sekarang;
        }
        format.dateFormat = @"dd/MM/YYYY HH:mm";
        return [format stringFromDate:self];
    }
    
    return @"";
}

@end
