//
//  ProfileManagerCore.swift
//  FNP
//
//  Created by Andrey Chernyshev on 09.07.2021.
//

import RxSwift

final class ProfileManagerCore {
    enum Constants {
        static let cachedReferencesKey = "profile_manager_core_cached_references_key"
    }
}

// MARK: Study
extension ProfileManagerCore {
    func set(level: Int? = nil,
             assetsPreferences: [Int]? = nil,
             testMode: Int? = nil,
             examDate: String? = nil,
             testMinutes: Int? = nil,
             testNumber: Int? = nil,
             testWhen: [Int]? = nil,
             notificationKey: String? = nil) -> Single<Void> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetRequest(userToken: userToken,
                                 level: level,
                                 assetsPreferences: assetsPreferences,
                                 testMode: testMode,
                                 examDate: examDate,
                                 testMinutes: testMinutes,
                                 testNumber: testNumber,
                                 testWhen: testWhen,
                                 notificationKey: notificationKey)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { _ in Void() }
    }
}

// MARK: Test Mode
extension ProfileManagerCore {
    func obtainTestMode() -> Single<TestMode?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetTestModeRequest(userToken: userToken)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map(GetTestModeResponseMapper.map(from:))
    }
}

// MARK: References
extension ProfileManagerCore {
    func retrieveReferences(forceUpdate: Bool) -> Single<[Reference]> {
        guard forceUpdate else {
            return getCachedReferenced()
        }
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: GetReferencesRequest())
            .map(GetReferencesResponseMapper.map(from:))
    }
    
    private func write(references: [Reference]) -> Single<[Reference]> {
        Single<[Reference]>
            .create { event in
                guard let data = try? JSONEncoder().encode(references) else {
                    event(.success(references))
                    return Disposables.create()
                }
                
                UserDefaults.standard.setValue(data, forKey: Constants.cachedReferencesKey)
                
                event(.success(references))
                
                return Disposables.create()
            }
    }
    
    private func getCachedReferenced() -> Single<[Reference]> {
        Single<[Reference]>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.cachedReferencesKey),
                    let references = try? JSONDecoder().decode([Reference].self, from: data)
                else {
                    event(.success([]))
                    return Disposables.create()
                }
                
                event(.success(references))
                
                return Disposables.create()
            }
    }
}
