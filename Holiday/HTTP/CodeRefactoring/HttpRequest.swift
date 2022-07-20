//
//  HolidayRq2.swift
//  Holiday
//
//  Created by 林大屍 on 2022/6/14.
//

import Foundation


enum NetworkError: Error {
    case transprotError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    
}

struct HttpRequest {
    let resourceURL: URL
    let baseUrl = "https://calendarific.com/api/v2/holidays"
    let API_KEY = "0660c67076ba60fc71500159812cca6afb9d36af"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)        
        
        let resourceString = baseUrl + "?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getMethod(completion: @escaping(Result<[HolidayDetail], NetworkError>) -> Void) {
        
    //    guard let url = URL(string: "https://calendarific.com/api/v2/holidays?&api_key=0660c67076ba60fc71500159812cca6afb9d36af&country=it&year=2017") else {
    //        print("cannot create URL")
    //        return
    //    }
        
//        let request = URLRequest(url: url)
        
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

