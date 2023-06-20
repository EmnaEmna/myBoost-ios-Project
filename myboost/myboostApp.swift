//
//  myboostApp.swift
//  myboost
//
//  Created by Mac2021 on 13/3/2023.
//
//github access token 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
import SwiftUI

@main
struct loginApp: App {
    private let defaults = UserDefaults.standard

    var body: some Scene {
        WindowGroup {
            
           if(defaults.string(forKey: "token") == nil)
                      {
            WelcomeScreenView()

                      }else
                      {
                          HomeView()
                      }
            //ContentView()
        }
    }
}
