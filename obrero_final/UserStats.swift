//
//  UserStats.swift
//  obrero_final
//
//  Created by boubakerjouini on 22/6/2021.
//

import Foundation

struct User:Decodable {

    let username: String
    let email: String
    let firstname: String
    let lastname: String
    let phone: String
    let role : Int
    let etat : Int

}
