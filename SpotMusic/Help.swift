//
//  Help.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//

import Foundation

let clientID = "19705411f2bd4583a2538641ef7c4856"
let clientSecretID = "4695bf2c0a5545cf9c4e78188cf44a3d"
let token = "BQCcMVD4ueJCKFOFYLXsyW8-Ba8xyN5WOW0rptilpjQLbb-M43PIzpFgTfol4m8J3JbpyPs5T-21QBmLYI0cUNj88jDksiM4Hre93mKqsO3rpUHeyH0"
let host = "api.spotify.com"


let data = "\(clientID):\(clientSecretID)"
let encoded = data.data(using: .utf8)?.base64EncodedString()




//print(encoded!)
