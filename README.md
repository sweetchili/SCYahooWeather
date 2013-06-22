## Description ##
Objective-C wrapper around Yahoo's weather service.

## Version History ##
* 0.1 (sweetchili) - Get current weather from given WOEID-code. 
* 0.2 (josh-fuggle) - Modernized the code, made the library compatible with ARC
* 0.3 (josh-fuggle) - Added support for delegation. Web requests and XML parsing will now be performed in a background thread.

## Under Development ##
* 0.4 - Support for multiple delegates. API to acquiring coordinate-based weather information.
* ### - Weather forecast

## Sample Usage ##
``` objective-c
@interface SomeClass () <SCYahooWeatherParserDelegate>
@end

@implementation SomeClass

...

- (void)someFunction {    
    static NSInteger weatherID = 1100661;
    SCYahooWeatherParser *parser = [[SCYahooWeatherParser alloc] initWithWOEID:weatherID weatherUnit:SCWeatherUnitCelcius delegate:self];
    [parser parse];
}

#pragma mark - SCYahooWeatherParserDelegate
- (void)yahooWeatherParser:(SCYahooWeatherParser *)parser recievedWeatherInformation:(SCWeather *)weather {
    NSLog(weather);
}

@end
```
