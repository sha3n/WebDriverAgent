#import <Foundation/Foundation.h>

#import <WebDriverAgentLib/FBResponsePayload.h>
#import <WebDriverAgentLib/FBHTTPStatusCodes.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Class that represents WebDriverAgent JSON repsonse
 */
@interface FBResponseTextPayload : NSObject <FBResponsePayload>

/**
 Initializer for JSON respond that converts given 'dictionary' to JSON
 */
- (instancetype)initWithPlain:(NSString *)plain
                    httpStatusCode:(HTTPStatusCode)httpStatusCode;

@end

NS_ASSUME_NONNULL_END
