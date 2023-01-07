//
//  GlobalFunctions.swift
//  ChatApp
//
//  Created by Xunnun on 21/3/22.
//

import Foundation

func fileNameFrom(fileUrl: String) -> String {

    return ((fileUrl.components(separatedBy: "_").last)!.components(separatedBy: "?").first!).components(separatedBy: ".").first!
    
}
