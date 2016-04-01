
#import <getopt.h>

#import "Parser.h"

#define VERSION "0.1.1"

extern void print_usage(void);
extern void print_version(void);

static char * gAppName=NULL;

int main(int argc, char * argv [])
{
    // store the app name
    gAppName=argv[0];
    
    // handle missing parameter
    if(argc==1)
    {
        print_usage();
        return -1;
    }
    
    // handle version
    if(argc == 2)
    {
        if(strcmp(argv[1], "--version")==0 || strcmp(argv[1], "-v")==0)
        {
            print_version();
            return 0;
        }
        else
        {
            print_usage();
            return -1;
        }
    }
    
    // store the input file
    const char * inputFile=argv[1];

    // construct long options
    const struct option long_opts [] =
    {
        {"target-lang", required_argument, NULL, 0},
    };
    
    // for target-lang variable
    char * targetLang=(char*)(malloc(256));
    memset(targetLang, 0x0, 256);
        
    while(1)
    {
        int long_opt_index;
        int opt=getopt_long(argc-1, &argv[1], "l:", long_opts, &long_opt_index);
        if(opt==-1)
        {
            print_usage();
            break;
        }
            
        // if argument is acceptable
        if(opt==0)
        {
            if(long_opt_index==0)
            {
                // get target-lang
                strcpy(targetLang, optarg);
                break;
            }
        }
        else if(opt=='l')
        {
            // get target-lang
            strcpy(targetLang, optarg);
            break;
        }
    }
    
    if(strcmp(targetLang, "")==0)
    {
        return -2;
    }
    
    @autoreleasepool
    {
        NSString * filename=[NSString stringWithUTF8String:inputFile];
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
        else
        {
            printf("%s: Target language unsupported.\n", gAppName);
        }
    }
    
	return 0;
}

void print_usage()
{
    printf("Usage: %s <filename> --target-lang=<target_language>\n", gAppName);
}

void print_version()
{
    printf("%s version %s\n", gAppName, VERSION);
}
