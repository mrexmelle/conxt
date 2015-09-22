
#import "Parser.h"

#define VERSION "0.1.0"

int main(int argc, char * argv [])
{
    if(argc == 2)
    {
        // handle version
        if(strcmp(argv[1], "--version")==0)
        {
            printf("Version %s\n", VERSION);
            return 0;
        }
        else
        {
            printf("Usage: %s <filename> --target-lang=<target_language>\n", argv[0]);
            return -1;
        }
    }
    else if(argc < 3)
    {
        printf("Usage: %s <filename> --target-lang=<target_language>\n", argv[0]);
        return -1;
    }
    
    // get target-lang
    const char * filename=argv[1];
    int argv2ValueStart=0;
    int i, j;
    for(i=0; i<strlen(argv[2]); i++)
    {
        if(argv[2][i]=='=')
        {
            if(argv[2][i+1]=='\0')
            {
                printf("Error: target-lang not specified\n");
                return -2;
            }
            
            argv2ValueStart=i+1;
            break;
        }
    }
    const char * targetLang=argv[2]+argv2ValueStart;
    
    printf("target-lang=%s\n", targetLang);
    
    @autoreleasepool
    {
        NSString * filename=[NSString stringWithUTF8String:argv[1]];
        Parser * p = [Parser new];
        
        if(strcasecmp(targetLang, "java")==0)
        {
            [p parseToJava:filename];
        }
        else if(strcasecmp(targetLang, "python")==0)
        {
            [p parseToPy:filename];
        }
        else if(strcasecmp(targetLang, "c++")==0)
        {
            [p parseToCpp:filename];
        }
    }
    
	return 0;
}
