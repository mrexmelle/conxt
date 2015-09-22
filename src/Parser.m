
#import <Foundation/Foundation.h>
#import "Line.h"
#import "Parser.h"

@implementation Parser

//+ (NSArray *) parseToJava: (NSString *) aFilename
//    {
//        NSError * err;
//        NSString * fileContent = [NSString stringWithContentsOfFile:aFilename
//                                                                encoding:NSUTF8StringEncoding
//                                                                   error:&err];
//        if(fileContent==nil)
//        {
//            NSLog(@"fileContent is nil");
//            return nil;
//        }
//        else
//        {
//            NSLog(@"Success opening file - content:");
//            NSLog(@"%@\n", fileContent);
//        }
//        return nil;
//    }

- (id) init
{
    self=[super init];
    if(self!=NULL)
    {
        _lineList = [NSMutableArray new];
    }
    return self;
}

- (void) parse: (NSString *)aFilename
{
    bool success;
    
    NSURL * xmlUrl = [NSURL fileURLWithPath:aFilename];
    NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL: xmlUrl];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:true];
    success=[parser parse];
    [parser release];
    
//    NSLog(@"Enum name: %@\n", _enumName);
//    for(Line * l in _lineList)
//    {
//        NSLog(@"const - key: %@ value: %@\n", l.key, l.value);
//    }
}

- (void) writeToJava
{
    // set the file name
    NSString * filename = [NSString stringWithFormat:@"%@.java", _enumName];
    
    // write the class
    NSMutableString * javaContent = [NSMutableString string];
    NSString * enumStart = [NSString stringWithFormat:@"public final class %@\n{\n", _enumName];
    [javaContent appendString:enumStart];
    for(Line * l in _lineList)
    {
        NSString * enumLine;
        if([l.type isEqualToString:@"comment"])
        {
            enumLine = [NSString stringWithFormat:@"\t// %@\n", l.value];
        }
        else if([l.type isEqualToString:@"lf"])
        {
            enumLine = @"\n";
        }
        else
        {
            enumLine = [NSString stringWithFormat:@"\tpublic final static int %@=%@;\n", l.key, l.value];
        }
        [javaContent appendString:enumLine];
    }
    NSString * enumEnd = @"}\n";
    [javaContent appendString:enumEnd];

    [javaContent writeToFile:filename atomically:false encoding:NSStringEncodingConversionAllowLossy error:NULL];
}

- (void) writeToPy
{
    // set the file name
    NSString * filename = [NSString stringWithFormat:@"%@.py", _enumName];
    
    // write the class
    NSMutableString * javaContent = [NSMutableString string];
    NSString * enumStart = [NSString stringWithFormat:@"class %@(object):\n", _enumName];
    [javaContent appendString:enumStart];
    for(Line * l in _lineList)
    {
        NSString * enumLine;
        if([l.type isEqualToString:@"comment"])
        {
            enumLine = [NSString stringWithFormat:@"\t# %@\n", l.value];
        }
        else if([l.type isEqualToString:@"lf"])
        {
            enumLine = @"\n";
        }
        else
        {
            enumLine = [NSString stringWithFormat:@"\t%@=%@\n", l.key, l.value];
        }
        [javaContent appendString:enumLine];
    }
    NSString * enumEnd = @"\n";
    [javaContent appendString:enumEnd];
    
    [javaContent writeToFile:filename atomically:false encoding:NSStringEncodingConversionAllowLossy error:NULL];
}

- (void) parseToJava: (NSString *)aFilename
{
    [self parse:aFilename];
    [self writeToJava];
}

- (void) parseToPy: (NSString *)aFilename
{
    [self parse:aFilename];
    [self writeToPy];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Start parsing document...\n");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Finish parsing document...\n");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"enum"])
    {
        _enumName=[attributeDict objectForKey:@"name"];
    }
    else if([elementName isEqualToString:@"line"])
    {
        NSString * type=[attributeDict objectForKey:@"type"];
        NSString * key=[attributeDict objectForKey:@"key"];
        NSString * value=[attributeDict objectForKey:@"value"];
        Line * l = [[Line alloc] initAs: type withKey: key andValue: value];
        [_lineList addObject:l];
        [l release];
    }
}


@end
