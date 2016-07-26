//
//  ViewController.m
//  SpeechAPIExample
//

#import "ViewController.h"
#import "SpeechToTextModule.h"

@interface ViewController ()<SpeechToTextModuleDelegate>  {
    SpeechToTextModule *speechToTextModule;
    BOOL isRecording;
}
@end

@implementation ViewController

-(void)initSpeech: (const char *) keyIOS
{
    GOOGLE_SPEECH_TO_TEXT_KEY = [NSString stringWithUTF8String:keyIOS];
    GOOGLE_SPEECH_TO_TEXT_LANG = @"en-US";
    speechToTextModule = [[SpeechToTextModule alloc] initWithCustomDisplay:nil];
    [speechToTextModule setDelegate:self];
    [self SendStatusToUnity: "init"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)changeLanguage:(const char *) lang
{
    GOOGLE_SPEECH_TO_TEXT_LANG = [NSString stringWithUTF8String:lang];;
}
- (void)startRecording {
    if (isRecording == NO) {        
        [speechToTextModule beginRecording];
        isRecording = YES;
        [self SendStatusToUnity: "start"];
    }
}

- (void)stopRecording {
    if (isRecording) {
        [speechToTextModule stopRecording:YES];
        isRecording = NO;
        [self SendStatusToUnity: "stop"];

    }
}

#pragma mark - SpeechToTextModuleDelegate
- (BOOL)didReceiveVoiceResponse:(NSMutableArray *)myArray {
    
    NSLog(@"data %@",myArray);
    [self stopRecording];
    NSString *result = @"";
    for (id data in myArray) {
        id tmp = data[@"transcript"];
        if ([tmp isKindOfClass:[NSNumber class]] || [tmp rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) {
            // Spell out number
            // incase user spell number
            NSNumber *resultNumber = [NSNumber numberWithInteger:[tmp integerValue]];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterSpellOutStyle];
            if (result == nil) {
                result = [formatter stringFromNumber:resultNumber];
            }
            else {
                result = [NSString stringWithFormat: @"%@,%@", result, [formatter stringFromNumber:resultNumber]];
            }
            
        } else {
            if (result == nil) {
                result = tmp;
            }
            else {
                result = [NSString stringWithFormat: @"%@,%@", result, tmp];
            }
        }
    }
    
	// callback here  
	if (result == nil) {		
		[self SendMessageToUnity: "nil"];
	}
	else {	
		[self SendMessageToUnity: [result UTF8String]];
	}

    return YES;
}

- (void)requestFailedWithError:(NSError *)error {
    
    [self SendStatusToUnity: "error"];
    // Request fail
}
- (void)dealloc {
    if (speechToTextModule) {
        [self stopRecording];
        speechToTextModule = nil;
    }
}
- (void)SendMessageToUnity:(const char *)message {
    UnitySendMessage("speechtotext", "CallbackSpeechToText", message);
}
- (void)SendStatusToUnity:(const char *)message {
    UnitySendMessage("speechtotext", "CallbackStatus", message);
}


@end
extern "C"{
    ViewController *vc = [[ViewController alloc] init];
    void _TAG_initSpeech(const char * _keyIOS){        
        [vc initSpeech:_keyIOS];
    }
    void _TAG_startRecording(){
        [vc startRecording];
    }
	void _TAG_stopRecording(){
        [vc stopRecording];
    }
    void _TAG_changeLanguage(const char * lang){
        [vc changeLanguage:lang];
    }
}
