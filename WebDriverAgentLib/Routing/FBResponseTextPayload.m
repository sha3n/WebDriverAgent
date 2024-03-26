/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "FBResponseTextPayload.h"

#import "FBLogger.h"
#import "NSDictionary+FBUtf8SafeDictionary.h"
#import "RouteResponse.h"

@interface FBResponseTextPayload ()

@property (nonatomic, copy, readonly) NSString *plain;
@property (nonatomic, readonly) HTTPStatusCode httpStatusCode;

@end

@implementation FBResponseTextPayload

- (instancetype)initWithPlain:(NSString *)plain
                    httpStatusCode:(HTTPStatusCode)httpStatusCode;
{
  self = [super init];
  if (self) {
    _plain = plain;
    _httpStatusCode = httpStatusCode;
  }
  return self;
}

- (void)dispatchWithResponse:(RouteResponse *)response
{
  NSStringEncoding encoding = NSUTF8StringEncoding;
  NSData *data = [self.plain dataUsingEncoding:encoding];
  [response setHeader:@"Content-Type" value:@"text/html"];
  [response setStatusCode:self.httpStatusCode];
  [response respondWithData:data];
}

@end
