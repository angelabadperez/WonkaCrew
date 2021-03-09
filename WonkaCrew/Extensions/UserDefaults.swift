//
//  UserDefaults.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 9/3/21.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Keys
    
    private enum Keys {
        static let gender = "gender"
        static let professions = "professions"
    }
    
    // MARK: - Public API
    
    static var gender: Gender? {
        get {
            guard let storedValue = UserDefaults.standard.object(forKey: Keys.gender),
                  let rawValue = storedValue as? Int else {
                return nil
            }
            
            return Gender(rawValue: rawValue)
        }
        
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: Keys.gender)
        }
    }
    
    static var professions: [Profession] {
        get {
            guard let storedValue = UserDefaults.standard.array(forKey: Keys.professions) as? [Int] else {
                return []
            }
            return storedValue
                .compactMap { Profession(rawValue: $0) }
        }
        
        set {
            let rawValuesArray = newValue
                .map { $0.rawValue }
            UserDefaults.standard.setValue(rawValuesArray, forKey: Keys.professions)
        }
    }
}
