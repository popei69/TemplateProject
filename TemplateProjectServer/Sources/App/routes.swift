import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("latest") { req -> Converter in 
        let currencyRate = CurrencyRate(eur: 1.15, usd: 1.29, gbp: 1.0, sgd: 1.75)
        let converter = Converter(base: "GBP", date: "2019-01-01", rates: currencyRate)
        return converter
    }
}
