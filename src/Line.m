
#import <Foundation/Foundation.h>

#import "Line.h"

@implementation Line

-(id) initAs: (NSString *) aType withKey: (NSString *)aKey andValue: (NSString *)aValue
{
    self = [super init];
    if(self!=NULL)
    {
        _type=aType;
        _key=aKey;
        _value=aValue;
    }
    return self;
}

@end
