//
//  CityListModelController.swift
//  Testcity
//
//  Created by Brunya on 01.04.2021.
//

import Foundation
import CoreLocation

final class CityListModelController {
    // MARK: Private Props
    private let key = "ecc52302-c850-495d-a05b-9ffc176e4e92"
    
    // MARK: Public Props
    let cities: [City] = [
        .init(name: "Moscow", location: .init(latitude: 55.7558, longitude: 37.6178)),
        .init(name: "Saint Petersburg", location: .init(latitude: 59.9500, longitude: 30.3167)),
        .init(name: "Samara", location: .init(latitude: 53.1833, longitude: 50.1167)),
        .init(name: "Nizhniy Novgorod", location: .init(latitude: 56.3269, longitude: 44.0075)),
        .init(name: "Sochi", location: .init(latitude: 43.5853, longitude: 39.7203)),
        .init(name: "Yekaterinburg", location: .init(latitude: 56.8356, longitude: 60.6128)),
        .init(name: "Novosibirsk", location: .init(latitude: 55.0333, longitude: 82.9167)),
        .init(name: "Kazan", location: .init(latitude: 55.7908, longitude: 49.1144)),
        .init(name: "Ryazan", location: .init(latitude: 54.6167, longitude: 39.7167)),
        .init(name: "Bryansk", location: .init(latitude: 53.2500, longitude: 34.3667)),
    ]
    private(set) var weatherInfo: [String: WeatherInfo] = [:]
    
    // MARK: Public Methods
    func loadWeatherInfo(then completion: @escaping ([String: WeatherInfo]) -> Void) {
        let group = DispatchGroup()
        
        for city in cities {
            group.enter()
            getWeather(for: city) { [weak self] (weatherInfo) in
                guard let self = self else { return }
                
                self.weatherInfo[city.name] = weatherInfo
                
                group.leave()
            }
        }
        
        
        group.notify(queue: .global(qos: .userInitiated)) {
            completion(self.weatherInfo)
        }
    }
}

extension CityListModelController {
    struct City {
        let name: String
        let location: CLLocationCoordinate2D
    }
}

extension CityListModelController {
    struct WeatherInfo: Decodable {
        struct Fact: Decodable {
            let temp: Int
            let pressureMM: Int
            let windSpeed: Double
            let feelsLike: Int
            let humidity: Int
            
            private enum CodingKeys: String, CodingKey {
                case temp
                case pressureMM = "pressure_mm"
                case windSpeed = "wind_speed"
                case feelsLike = "feels_like"
                case humidity
            }
        }
        let fact: Fact
    }
}

extension CityListModelController {
    private func getWeather(for city: City, then completion: @escaping (WeatherInfo) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.weather.yandex.ru"
        components.path = "/v2/forecast"
        components.queryItems = [
            .init(name: "lat", value: "\(city.location.latitude)"),
            .init(name: "lon", value: "\(city.location.longitude)"),
        ]
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(key, forHTTPHeaderField: "X-Yandex-API-Key")
        
        let task = URLSession
            .shared
            .dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Client error: \(error)")
                }
                
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, !(200...299 ~= httpResponse.statusCode) {
                    print("Server error with response: \(httpResponse)")
                }
                
                guard let data = data else {
                    print("Unknown error. No data...")
                    return
                }
                
                
                do {
                    let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
                    completion(weatherInfo)
                }
                catch {
                    print("JSON decode error: \(error)")
                }
            }
        task.resume()
    }
}


// Main for (*1 *2 ... *5) for end

// *1

// *2

// *3
