//
//  ProfileView.swift
//  Profile
//
//  Created by Tubagus Adhitya Permana on 20/01/23.
//

import SwiftUI

public struct ProfileView: View {
    public init() {}
    public var body: some View {
        NavigationStack {
            VStack {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 10)
                Text("Tubagus Adhitya Permana")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 10)
                Text("iOS Developer")
                    .font(.title3)
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("Profiles")
        }
    }
}
