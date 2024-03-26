#import "OTExtendCommands.h"
#import "XCUIDevice+FBHelpers.h"
#import "FBRouteRequest.h"
#import "FBResponsePayload.h"
#import "RouteResponse.h"

@class RouteResponse;
@class FBRouteRequest;

NSString *template = @"<!DOCTYPE html>"
@"<html lang=\"en\">"
@"<head>"
@"    <meta charset=\"UTF-8\">"
@"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
@"    <title>Document</title>"
@"</head>"
@"<style>"
@"    #url {"
@"        line-height: 50px;"
@"        text-decoration: none;"
@"        display: inline-block;"
@"        height: inherit;"
@"        width: 350px;"
@"        background-color: #123343;"
@"        text-align: center;"
@"        color: white;"
@"        height: 300px;"
@"        line-height: 300px;"
@"    }"
@"</style>"
@"<body>"
@"    <a id=\"url\" href=\"[link]\">[label]</a>"
@"</body>"
@"</html>";

NSString *linkholder = @"[link]";
NSString *labelholder = @"[label]";

NSString *thereIsARole = @"ROLEHERE";
NSString *thereIsNoRole = @"NOROLE";

@implementation OTExtendCommands

#pragma mark - <OTExtendCommands>

static NSString *roleLink = @"";

+ (NSArray *)routes
{
  return
  @[
    [[FBRoute GET:@"/set-role/:roleLink"].withoutSession respondWithTarget:self action:@selector(handleSetRole:)],
    [[FBRoute GET:@"/set-role*"] respondWithTarget:self action:@selector(handleSetRole:)],
    [[FBRoute GET:@"/get-role"].withoutSession respondWithTarget:self action:@selector(handleGetRole:)],
    [[FBRoute GET:@"/get-role"] respondWithTarget:self action:@selector(handleGetRole:)],
  ];
}

#pragma mark - Commands

+ (id<FBResponsePayload>)handleSetRole:(FBRouteRequest *)request
{
  NSString *linkParam = request.parameters[@"roleLink"];
  if (linkParam) {
    NSString *link = [linkParam stringByRemovingPercentEncoding];
    roleLink = link;
  }
  return FBResponseWithObject(roleLink);
}

+ (id<FBResponsePayload>)handleGetRole:(FBRouteRequest *)request
{
  NSString *label = nil;
  if (roleLink && roleLink.length > 0) {
    label = thereIsARole;
  } else {
    label = thereIsNoRole;
  }
  NSString *resultString = [template stringByReplacingOccurrencesOfString:labelholder withString:label];
  resultString = [resultString stringByReplacingOccurrencesOfString:linkholder withString:roleLink];
  return FBResponseWithPlain(resultString);
}

@end
