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

@implementation SCYahooWeatherParser

- (id)initWithWOEID:(int)_WOEID weatherUnit:(SCWeatherUnit)_unit {
    self = [super init];
    
    if(self) {
        WOEID = _WOEID;
        unit = _unit;
    }
    
    return self;
}

- (SCWeather *)parse {
    NSURL *URL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%d&u=%@", WOEID, (unit == SCWeatherUnitCelcius) ? @"c" : @"f"]];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    [xmlParser setDelegate:self];
    
    SCWeather *weather = nil;
    if([xmlParser parse]) {
        weather = [[[SCWeather alloc] init] autorelease];
        weather.description = [_data objectForKey:kSCYahooWeatherXMLKeyText];
        weather.temperature = [[_data objectForKey:kSCYahooWeatherXMLKeyTemp] intValue];
        weather.condition = [[_data objectForKey:kSCYahooWeatherXMLKeyCondition] intValue];
    }
    
    return weather;
}


#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:kSCYahooWeatherXMLKeyConditionTag]) {
        if(_data) {
            [_data release];
        }
        
        _data = [attributeDict retain];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
}

@end
