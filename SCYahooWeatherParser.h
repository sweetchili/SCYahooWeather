//
// SCYahooWeatherParser.h
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

#import <Foundation/Foundation.h>
#import "SCWeather.h"

@class SCYahooWeatherParser;

@protocol SCYahooWeatherParserDelegate
- (void)yahooWeatherParser:(SCYahooWeatherParser *)parser recievedWeatherInformation:(SCWeather *)weather;
@end

typedef void(^SCYahooWeatherInfoBlock)(SCYahooWeatherParser *parser, SCWeather *weather);


@interface SCYahooWeatherParser : NSObject

@property (readonly, weak) id <SCYahooWeatherParserDelegate> delegate;
@property (readonly, copy) SCYahooWeatherInfoBlock block;

@property (readonly) NSInteger WOEID;
@property (readonly) SCWeatherUnit unit;

#pragma mark - Initialization
#pragma mark Initialize with Delegates
- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit delegate:(id <SCYahooWeatherParserDelegate>)delegate;
+ (id)weatherParserWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit delegate:(id <SCYahooWeatherParserDelegate>)delegate;

#pragma mark Initialize with Blocks
- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit block:(SCYahooWeatherInfoBlock)block;
+ (id)weatherParserWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit block:(SCYahooWeatherInfoBlock)block;

#pragma mark - Parsing
- (void)parse;

@end


