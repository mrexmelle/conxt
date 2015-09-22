

#import <Foundation/Foundation.h>

@interface Parser : NSObject<NSXMLParserDelegate>

- (void) parseToJava: (NSString*) aFilename;
- (void) parseToPy: (NSString*) aFilename;
- (void) parseToCpp: (NSString*) aFilename;

@property(nonatomic, assign) NSString * enumName;
@property(nonatomic, assign) NSMutableArray * lineList;

@end 
