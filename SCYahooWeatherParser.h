//
// SCYahooWeatherParser.h
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

#import <Foundation/Foundation.h>
#import "SCWeather.h"

@interface SCYahooWeatherParser : NSObject

- (id)initWithWOEID:(NSInteger)WOEID weatherUnit:(SCWeatherUnit)unit;
- (SCWeather *)parse;

@property (readonly) NSInteger WOEID;
@property (readonly) SCWeatherUnit unit;

@end
