

import Foundation

struct WeatherData: Decodable {
    let now: Double?
    let nowDt: String?
    let info: Info
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecasts]?
}

struct Info: Decodable {
    let n: Bool?
    let geoid: Double?
    let lat: Double?
    let lon: Double?
}

struct GeoObject: Decodable {
    let locality: Locality?
}

struct Locality: Decodable {
    let id: Double?
    let name: String?
}

struct Fact: Decodable {
    let temp: Double
    var stringTemp: String {
        String(format: "%.0f", temp)
    }
    
    let feelsLike: Double
    var feelsLikeString: String {
        String(format: "%.0f", feelsLike)
    }
    
    let icon: String?
    
    let condition: String?
    var conditionString: String {
        switch condition {
        case "clear":
            return "ясно"
        case "partly-cloudy":
            return "малооблачно"
        case "cloudy":
            return "облачно с прояснениями"
        case "overcast":
            return "пасмурно"
        case "drizzle":
            return "морось"
        case "light-rain":
            return "небольшой дождь"
        case "rain":
            return "дождь"
        case "moderate-rain":
            return "умеренно сильный дождь"
        case "heavy-rain":
            return "сильный дождь"
        case "continuous-heavy-rain":
            return "длительный сильный дождь"
        case "showers":
            return "ливень"
        case "wet-snow":
            return "дождь со снегом"
        case "light-snow":
            return "небольшой снег"
        case "snow":
            return "снег"
        case "snow-showers":
            return "снегопад"
        case "hail":
            return "град"
        case "thunderstorm":
            return "гроза"
        case "thunderstorm-with-rain":
            return "дождь с грозой"
        case "thunderstorm-with-hail":
            return "гроза с градом"
        default:
            return ""
        }
    }
    
    let windSpeed: Double
    var windSpeedString: String {
        String(format: "%.0f", windSpeed)
    }
    
    let pressureMm: Double
    var pressureMmString: String {
        String(format: "%.0f", pressureMm)
    }
    
    let humidity: Double
    var humidityString: String {
        String(format: "%.0f", humidity)
    }
    
    let season: String?
    var seasonString: String {
        switch season {
        case "summer":
            return "лето"
        case "autumn":
            return "осень"
        case "winter":
            return "зима"
        case "spring":
            return "весна"
        default:
            return ""
        }
    }
}

struct Forecasts: Decodable {
    let date: String?
    let dateTs: Double?
    let sunrise: String?
    let sunset: String?
    let parts: Part?
}

struct Part: Decodable {
    let day: Day?
}

struct Day: Decodable {
    let tempAvg: Double
    var tempAvgString: String {
        String(format: "%.0f", tempAvg)
    }
    let icon: String?
}


