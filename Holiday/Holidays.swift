//
//  Holidays.swift
//  Holiday
//
//  Created by 林大屍 on 2022/5/31.
//

import Foundation


struct HolidaysResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var description: String
    var country: CountryName
    var date: DateInfo
}

struct CountryName: Decodable {
    var name: String
}

//response.holidays[0].country.name


struct DateInfo: Decodable {
    var iso: String
}

// "iso": "2019-01-04",

