//
//  HPUserDefaultsManager.swift
//  HelparkIOS
//
//  Created by Hasan Ali Şişeci on 4.02.2024.
//

import Foundation

final class HPUserDefaultsManager: NSObject {
    static let shared = HPUserDefaultsManager()
    private let userDefaults: UserDefaults

    override private init() {
        userDefaults = UserDefaults.standard
    }

    // MARK: For primitive types

    func getString(key: String) -> String? {
        userDefaults.string(forKey: key)
    }

    func setString(key: String, value: String) {
        userDefaults.setValue(value, forKey: key)
    }

    func get<T>(for key: HPUserDefaultsKey) -> T? {
        let result = userDefaults.object(forKey: key.value) as? T
        return result
    }

    func set<T>(_ obj: T, for key: HPUserDefaultsKey) {
        userDefaults.set(obj, forKey: key.value)
    }

    func remove(for key: HPUserDefaultsKey) {
        userDefaults.removeObject(forKey: key.value)
    }


    func setModel<T: Encodable>(key: HPUserDefaultsKey, model: T) throws {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            throw HPUserDefaultsError.encodingFailed
        }
    }

    func getModel<T: Decodable>(_ key: HPUserDefaultsKey, _ type: T.Type) throws -> T {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            throw HPUserDefaultsError.dataNotFound
        }

        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(type, from: data)
            return model
        } catch {
            throw HPUserDefaultsError.decodingFailed
        }
    }
}
