## Description ##
Objective-C wrapper around Yahoo's weather service.

## Version History ##
* v0.1 - Get current weather from given WOEID-code. 
* v0.2 - Modernized the code, made the library compatible with ARC
* v0.3 - Added support for delegation. Web requests and XML parsing will now be performed in a background thread.
* [v0.3.1](https://github.com/josh-fuggle/SCYahooWeather/issues?milestone=2&page=1&state=closed) - Added support for block callbacks. Added factory methods.

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
