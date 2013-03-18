//
// SCWeather.h
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

typedef enum {
    SCWeatherUnitCelcius = 0, 
    SCWeatherUnitFahrenheit,
} SCWeatherUnit;

typedef enum {
    SCWeatherConditionTornado = 0,
    SCWeatherConditionTropicalStrom,
    SCWeatherConditionHurricane,
    SCWeatherConditionSevereThunderstroms,
    SCWeatherConditionThunderstorms,
    SCWeatherConditionMixedRaindAndSnow,
    SCWeatherConditionMixedRainAndSleet,
    SCWeatherConditionMixedSnowAndSleet,
    SCWeatherConditionFexxingDrizzle,
    SCWeatherConditionDrizzle,
    SCWeatherConditionFreezingRain,
    SCWeatherConditionShowers,
    SCWeatherConditionShowers2,
    SCWeatherConditionSnowFlurries,
    SCWeatherConditionLightSnowShowers,
    SCWeatherConditionBlowingSnow, 
    SCWeatherConditionSnow, 
    SCWeatherConditionHail,
    SCWeatherConditionSleet,
    SCWeatherConditionDust,
    SCWeatherConditionFoggy,
    SCWeatherConditionHaze,
    SCWeatherConditionSmoky,
    SCWeatherConditionBlustery,
    SCWeatherConditionWindy,
    SCWeatherConditionCold,
    SCWeatherConditionCloudy,
    SCWeatherConditionMostlyCloudyNight,
    SCWeatherConditionMostlyCloudyDay,
    SCWeatherConditionPartlyCloudyNight,
    SCWeatherConditionPartlyCloudyDay,
    SCWeatherConditionClearNight,
    SCWeatherConditionSunny,
    SCWeatherConditionFairNight,
    SCWeatherConditionFairDay,
    SCWeatherConditionMixedRainAndHail,
    SCWeatherConditionHot,
    SCWeatherConditionIsolatedThunderstorms,
    SCWeatherConditionScatteredThunderstorms,
    SCWeatherConditionScatteredThunderstorms2, 
    SCWeatherConditionScatteredShowers,
    SCWeatherConditionHeavySnow, 
    SCWeatherConditionScatteredSnowShowers,
    SCWeatherConditionHeavySnow2,
    SCWeatherConditionPartlyCloudy,
    SCWeatherConditionThundershowers,
    SCWeatherConditionSnowShowers,
    SCWeatherConditionIsolatedThundershowers,
    SCWeatherConditionNotAvailable,
} SCWeatherCondition;

@interface SCWeather : NSObject

@property (nonatomic, assign) SCWeatherCondition condition;
@property (nonatomic, assign) SCWeatherUnit unit;
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, retain) NSString *description;

@end
