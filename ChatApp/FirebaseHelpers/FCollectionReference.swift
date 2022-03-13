//
//  FCollectionReference.swift
//  ChatApp
//
//  Created by Xunnun on 13/3/22.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
}

func FirebaseReference(_ colllectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(colllectionReference.rawValue)
    
}
