//
// SCWeather.m
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

#import "SCWeather.h"

@implementation SCWeather

- (NSString *)description
{
    if (!self.weatherString) return [super description];
    return self.weatherString;
}
@end
