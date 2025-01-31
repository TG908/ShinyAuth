//
//  SettingsView.swift
//  Watch Extension
//
//  Created by Tim Gymnich on 19.10.20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section {
                #if os(macOS)
                Spacer()
                #endif
                HStack {
                    Image(systemName: "printer")
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .padding(4)
                        .background(
                            Rectangle()
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                                .aspectRatio(1.0, contentMode: .fit)
                        )
                    Text("Backup")
                }
                #if os(macOS)
                Spacer()
                #endif
                HStack {
                        Image(systemName: "envelope")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(
                                Rectangle()
                                    .foregroundColor(.blue)
                                    .cornerRadius(8)
                                    .aspectRatio(1.0, contentMode: .fit)
                            )

                    Text("Feedback")
                }
                #if os(macOS)
                Spacer()
                #endif
                HStack {
                        Image(systemName: "info.circle")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(
                                Rectangle()
                                    .foregroundColor(.blue)
                                    .cornerRadius(8)
                            )

                    Text("Version")
                    Spacer()
                    Text("1.0")
                        .foregroundColor(.gray)

                }
            }
            #if os(macOS)
            Spacer()
            #endif
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


