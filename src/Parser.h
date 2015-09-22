

#import <Foundation/Foundation.h>

@interface Parser : NSObject<NSXMLParserDelegate>

- (void) parse: (NSString *)aFilename;
- (void) writeToJava;
- (void) writeToPy;
- (void) parseToJava: (NSString*) aFilename;
- (void) parseToPy: (NSString*) aFilename;

@property(nonatomic, assign) NSString * enumName;
@property(nonatomic, assign) NSMutableArray * lineList;

@end 
