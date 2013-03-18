//
// SCYahooWeatherParser.m
// SCYahooWeather
//
// Created by sweetchili on 2011-06-25.
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

#define kSCYahooWeatherXMLKeyConditionTag   @"yweather:condition"
#define kSCYahooWeatherXMLKeyTemp           @"temp"
#define kSCYahooWeatherXMLKeyText           @"text"
#define kSCYahooWeatherXMLKeyCondition      @"code"

@interface SCYahooWeatherParser () <NSXMLParserDelegate>
@property (strong) NSDictionary *data;
@property (readwrite) NSInteger WOEID;
@property (readwrite) SCWeatherUnit unit;
@end

@implementation SCYahooWeatherParser

- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit {
    if (self = [super init]) {
        self.WOEID = WOEID;
        self.unit = unit;
    }
    return self;
}

- (SCWeather *)parse {
    NSString *URLString = [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%d&u=%@", self.WOEID, (self.unit == SCWeatherUnitCelcius) ? @"c" : @"f"];
    NSURL *URL = [[NSURL alloc] initWithString:URLString];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    xmlParser.delegate = self;
    
    SCWeather *weather = nil;
    if ([xmlParser parse]) {
        weather = [SCWeather new];
        weather.description = self.data[kSCYahooWeatherXMLKeyText];
        weather.temperature = [self.data[kSCYahooWeatherXMLKeyTemp] intValue];
        weather.condition = [self.data[kSCYahooWeatherXMLKeyCondition] intValue];
    }
    
    return weather;
}


#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:kSCYahooWeatherXMLKeyConditionTag]) self.data = attributeDict;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
}

@end
