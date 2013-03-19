## Description ##
Objective-C wrapper around Yahoo's weather service.

## Version History ##
* 0.1 - Get current weather from given WOEID-code. 
* 0.2 - Modernized the code, made the library compatible with ARC

## Future Releases ##
* Threading
* Delegate pattern callback (fetchWeatherForWOEID:unit:withDelegate)
* Weather forecast

## Example Usage ##
### Synchronous ###
``` objective-c
static NSInteger weatherID = 1100661;
SCYahooWeatherParser *parser = [[SCYahooWeatherParser alloc] initWithWOEID:weatherID weatherUnit:SCWeatherUnitCelcius];
SCWeather *weather = [parser parse];
self.weatherDescription = weather.description;
```

### Asynchronous ###
``` objective-c
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    static NSInteger weatherID = 1100661;
    SCYahooWeatherParser *parser = [[SCYahooWeatherParser alloc] initWithWOEID:weatherID weatherUnit:SCWeatherUnitCelcius];
    SCWeather *weather = [parser parse];
    
    @synchronized(self) {
        self.weatherDescription = weather.description;
    }
    
});
```
