//
//  NetworkFinal.swift
//  Holiday
//
//  Created by 林大屍 on 2022/7/20.
//

import Foundation


extension Date {
    
    var thisYear: String {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return format.string(from: self)
    }
}

enum API {
//class or struct
    
    private static let API_KEY = "0660c67076ba60fc71500159812cca6afb9d36af"

    private static func getCurrentYearText() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return format.string(from: Date())
    }
    
    private static func createURL(country: String) -> URL? {
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "calendarific.com"
        componets.path = "/api/v2/holidays"
        componets.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "year", value: getCurrentYearText())
        ]
        return componets.url
    }
    
    fileprivate static func sendRequest(_ url: URL, _ completion: @escaping(Result<[HolidayDetail], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
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
    
    static func getHolidays(countryCode: String,
                            completion: @escaping(Result<[HolidayDetail], NetworkError>) -> Void)
    {
        guard let url = createURL(country: countryCode) else {
            completion(.failure(.noData))
            return
        }
        sendRequest(url, completion)
    }
}


//API.getHolidays(countryCode: "tw") { result in
//    switch
//}
