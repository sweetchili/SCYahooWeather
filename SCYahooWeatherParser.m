//
// SCYahooWeatherParser.m
// SCYahooWeather
//
// Version History
// ----
//  * 0.1 (2011-06-25): created by sweetchili
//  * 0.2 (2013-03-18): upgraded to support ARC by josh-fuggle
//  * 0.3 (2013-03-18): added support for delegation by josh-fuggle
// 
// This file is part of SCYahooWeather.
//
// SCYahooWeather is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// SCYahooWeather is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SCYahooWeather.  If not, see <http://www.gnu.org/licenses/>.
//

#import "SCYahooWeatherParser.h"

#define kSCYahooWeatherRequestURL           @"http://weather.yahooapis.com/forecastrss?w=%d&u=%@"

#define kSCYahooWeatherXMLKeyConditionTag   @"yweather:condition"
#define kSCYahooWeatherXMLKeyTemp           @"temp"
#define kSCYahooWeatherXMLKeyText           @"text"
#define kSCYahooWeatherXMLKeyCondition      @"code"

@interface SCYahooWeatherParser () <NSXMLParserDelegate>
@property (weak, readwrite) id <SCYahooWeatherParserDelegate> delegate;
@property (copy, readwrite) SCYahooWeatherInfoBlock block;
@property (strong) NSDictionary *data;
@property (readwrite) NSInteger WOEID;
@property (readwrite) SCWeatherUnit unit;
// keep a strong reference to self while parsing is underway
@property (strong) SCYahooWeatherParser *selfReference;
@end

@implementation SCYahooWeatherParser

#pragma mark - Initialization
#pragma mark Initialize with Delegates
- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit delegate:(id <SCYahooWeatherParserDelegate>)delegate
{
    if (self = [super init]) {
        self.WOEID = WOEID;
        self.unit = unit;
        self.delegate = delegate;
        self.selfReference = self;
    }
    return self;
}

+ (id)weatherParserWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit delegate:(id <SCYahooWeatherParserDelegate>)delegate
{
    return [[SCYahooWeatherParser alloc] initWithWOEID:WOEID weatherUnit:unit delegate:delegate];
}

#pragma mark Initialize with Blocks
- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit block:(SCYahooWeatherInfoBlock)block
{
    if (self = [super init]) {
        self.WOEID = WOEID;
        self.unit = unit;
        self.block = block;
        self.selfReference = self;
    }
    return self;
}

+ (id)weatherParserWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit block:(SCYahooWeatherInfoBlock)block
{
    return [[SCYahooWeatherParser alloc] initWithWOEID:WOEID weatherUnit:unit block:block];
}


#pragma mark - Parsing
- (void)parse
{
    NSString *URLString = [NSString stringWithFormat:kSCYahooWeatherRequestURL, self.WOEID, [self weatherUniString]];
    NSURL *URL = [[NSURL alloc] initWithString:URLString];
    
    // Begin parsing in a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
        xmlParser.delegate = self;
        
        [xmlParser parse];
    });
}

#pragma mark NSXMLParser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    if(![elementName isEqualToString:kSCYahooWeatherXMLKeyConditionTag]) return;
    
    SCWeather *weather = [SCWeather new];
    weather.weatherString = attributeDict[kSCYahooWeatherXMLKeyText];
    weather.temperature = [attributeDict[kSCYahooWeatherXMLKeyTemp] intValue];
    weather.condition = [attributeDict[kSCYahooWeatherXMLKeyCondition] intValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // If the client chose delegates as the primary callback
        if (self.delegate) {
            [self.delegate yahooWeatherParser:self recievedWeatherInformation:weather];
        }
        
        // If the client chose blocks as the callback
        if (self.block) {
            self.block(self, weather);
        }
        
    });
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    // Weather parse is no longer required
    self.selfReference = nil;
}


#pragma mark - Helper Methods
- (NSString *)weatherUniString
{
    return (self.unit == SCWeatherUnitCelcius ? @"c" : @"f");
}

@end
