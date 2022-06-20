//
//  Network.swift
//  Holiday
//
//  Created by 林大屍 on 2022/6/20.
//

import Foundation

enum AppError: Error {
    case transprotError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    
}

struct Network {
    let resourceURL: URL
    let baseUrl = "https://calendarific.com/api/v2/holidays"
    let API_KEY = "0660c67076ba60fc71500159812cca6afb9d36af"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "calendarific.com"
        componets.path = "/api/v2/holidays"
        
        componets.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "country", value: countryCode),
            URLQueryItem(name: "year", value: currentYear)
        ]
        
        //https://calendarific.com/api/v2/holidays?&api_key=0660c67076ba60fc71500159812cca6afb9d36af&country=it&year=2017
        
        
        let resourceString = componets.string ?? baseUrl
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
        
    }
    
    func fetchHolidays(completion: @escaping(Result<[HolidayDetail], NetworkError>) -> Void) {
        
        
        URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            if let error = error {
                completion(.failure(.transprotError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let holidaysResponse = try JSONDecoder().decode(HolidaysResponse.self, from: data)
                let holidayDetail = holidaysResponse.response.holidays
                completion(.success(holidayDetail))
                
            } catch {
                completion(.failure(.decodingError(error)))
            }
            
        }.resume()
        
        
    }
    
}
