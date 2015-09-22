
#import <Foundation/Foundation.h>

@interface Line : NSObject

-(id) initAs: (NSString *) aType withKey: (NSString *)aKey andValue: (NSString *)aValue;

    @property(nonatomic, assign) NSString * type;
	@property(nonatomic, assign) NSString * key;
	@property(nonatomic, assign) NSString * value;

@end
