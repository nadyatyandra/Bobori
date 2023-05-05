//
//  EditProfileViewModel.swift
//  Mini1
//
//  Created by Nadya Tyandra on 23/04/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    func nameIsEmpty(name: String) -> Bool {
        if name.isEmpty {
            return true
        }
        return false
    }
}
