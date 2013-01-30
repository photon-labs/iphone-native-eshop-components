//
//  PDPServiceHandler.m
//  iShop2.0
//
//  Created by PHOTON on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ServiceHandler.h"
#import "ConnectionManager.h"
#import "SharedObjects.h"
#import "DataModelEntities.h"
#import "DebugOutput.h"
#import "Constants.h"
#import "ConfigurationReader.h"

@implementation ServiceHandler

@synthesize callBackTarget ;
@synthesize callBackSelector;
@synthesize strId;
@synthesize prodId;
@synthesize productName;
@synthesize loginId;
@synthesize pwd;
@synthesize firstName;
@synthesize lastName;
@synthesize password;
@synthesize confirmPassword;
@synthesize emailAddress;
@synthesize phoneNumber;
@synthesize commentProductId;
@synthesize commentUserId;
@synthesize commentDate;
@synthesize commentRating;
@synthesize commentComment;
@synthesize commentUserName;
@synthesize loginUserId;
@synthesize loginUserName;


-(void) configService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ServerUrl" ofType:@"plist"];
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    // if(filePath)
    // {
    
    //NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@", protocol,host, port, context,kRestApi,kConfigService];
    
    ///////// Support ////////////////////////
    AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
    
    appInfoEntity.configEndpoint = urlString;
    //////////////////////////////////////////
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(configServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    // }	
	
}

-(void) configServiceDone:(NSMutableDictionary*) responseDataDict
{
	///////// Support //////////////
	NSDate *serviceCallTime = [NSDate date];
	
	AppInfoEntity *appInfoEntity = [[SharedObjects sharedInstance] appInfoEntity];
	
	appInfoEntity.serviceName = @"Config";
	
	appInfoEntity.appServiceCallTime = serviceCallTime;
	///////////////////////////////
	
	NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	NSMutableDictionary *configResponse;
	
	NSString *responseResultString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    ///////// Support //////////////
    appInfoEntity.configResponseString = responseResultString;
    
    ////////////////////////////////
    

    NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];

    configResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)data];
    
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:configResponse waitUntilDone:NO];	
}

-(void) catalogService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@", protocol,host, port, context,kRestApi,kCatalogService];         
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(catalogServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    	
}

-(void) catalogServiceDone:(NSMutableDictionary*) responseDataDict
{		
	NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
    NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    NSMutableDictionary *catalogResponse  = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)data];
	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:catalogResponse waitUntilDone:NO];	
    
  }

////To display the product details 
-(void) productDetailsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi, kCatalogService,strId];
    
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productDetailsServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
   
}

-(void) productDetailsServiceDone:(NSMutableDictionary*) responseDataDict 
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
    NSMutableDictionary *productDetailsResponse;
    
    NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];

    productDetailsResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)data];
    	
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productDetailsResponse waitUntilDone:NO];	
   
}

////To display the product 

-(void) productService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    

    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kProductService,strId];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
   		
}

-(void) productServiceDone:(NSMutableDictionary*) responseDataDict 
{
    
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	NSLog(@"Response Dict :%@", responseData);
    
    NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    NSMutableDictionary *productServiceResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)data];
    
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productServiceResponse waitUntilDone:NO];
    
}

////To display the product 
- (void) productReviewService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
	self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
     NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kProductService,strId,kreview];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productReviewServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    	
}

-(void) productReviewServiceDone:(NSMutableDictionary*) responseDataDict
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
    NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    NSMutableDictionary *productReviewResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)data];
    [self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productReviewResponse waitUntilDone:NO];

}

#pragma mark Special Products

-(void) specialProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
    self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
  
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@", protocol,host, port, context, kRestApi,kSpecialproducts];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(specialProductsServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
  
}

-(void) specialProductsServiceDone:(NSMutableDictionary*) responseDataDict 
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
	
    NSMutableDictionary *specialProductsResponse;
    NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    specialProductsResponse = [NSDictionary dictionaryWithDictionary:(NSDictionary*)data];
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:specialProductsResponse waitUntilDone:NO];	
}
-(void) searchProductsService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
    self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
    NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]]; 
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi, kProductService,ksearch,productName];
    
    NSLog(@"url string:%@", urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(searchProductsServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    	
    
}

-(void) searchProductsServiceDone:(NSMutableDictionary*) responseDataDict 
{
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
	
    NSMutableDictionary *searchProductsResponse;
	
   NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];    
	searchProductsResponse = [NSDictionary dictionaryWithDictionary:(NSDictionary*)data];
	[self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:searchProductsResponse waitUntilDone:NO];	
    
}
- (void) productReviewCommentService:(id)callBackTargetMethod: (SEL)callBackSelectorMethod
{
    self.callBackTarget = callBackTargetMethod;
	
	self.callBackSelector = callBackSelectorMethod;
    
    ConfigurationReader *configReader = [[ConfigurationReader alloc]init];
    [configReader parseXMLFileAtURL:@"phresco-env-config" environment:@"myWebservice"];
    
     NSString *protocol = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceprotocol];
    protocol = [protocol stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *host = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicehost];
    host = [host stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *port = [[configReader.stories objectAtIndex: 0] objectForKey:kwebserviceport];
    port = [port stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *context = [[configReader.stories objectAtIndex: 0] objectForKey:kwebservicecontext];
    context = [context stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@:%@/%@/%@/%@/%@/%@", protocol,host, port, context, kRestApi,kProductService,strId,kreview];
    NSLog(@"urlString %@",urlString);
    
    [[ConnectionManager sharedConnections] serviceCallWithURL:urlString 
                                                     httpBody:@"" 
                                                   httpMethod:@"GET" 
                                               callBackTarget:self 
                                             callBackSelector:@selector(productReviewCommentServiceDone:) 
                                                   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];
    
}

-(void) productReviewCommentServiceDone:(NSMutableDictionary*) responseDataDict
{
    
    NSData *responseData = [responseDataDict objectForKey:kConnectionDataReceived];
    NSMutableDictionary *productReviewCommentsResponse;
        NSData *data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    productReviewCommentsResponse =[NSDictionary dictionaryWithDictionary:(NSDictionary*)data];
    [self.callBackTarget performSelectorOnMainThread:self.callBackSelector withObject:productReviewCommentsResponse waitUntilDone:NO];	
    

}


@end
