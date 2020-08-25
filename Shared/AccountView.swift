//
//  AccountView.swift
//  ShinyAuth
//
//  Created by Tim Gymnich on 30.6.20.
//

import SwiftUI
import KingfisherSwiftUI
import OTPKit

struct AccountView: View {
    let account: Account<TOTP>
    @State private var currentCode: String = ""
    @State private var progress: CGFloat = 0.0
    @State private var showCopiedMessage = false

    var body: some View {
        HStack(spacing: 8) {
            if let imageURL = account.imageURL {
                KFImage(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    .mask(Circle())
            } else {
                IconView(text: String(account.issuer?.prefix(2) ?? account.label.prefix(2)))
                    .frame(width: 44, height: 44)
            }

            VStack(alignment: .leading, spacing: 2) {
                if let issuer = account.issuer {
                    Text(issuer)
                        .font(.body)
                    Text(account.label)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                } else {
                    Text(account.label)
                        .font(.body)
                }
            }
            Spacer()
            VStack {
                if !showCopiedMessage {
                    GradientText(currentCode, colors: [.green, .blue], progress: progress, kerning: 1.0)
                        .font(.title3)
                        .transition(.scale)
                        .onAppear {
                            currentCode = account.otpGenerator.code().group(groupSize: 3)
                        }
                        .onReceive(account.otpGenerator.publisher) { token in
                            currentCode = token.code.group(groupSize: 3)
                            progress = -0.99
                            withAnimation(.linear(duration: token.timeRemaining)) {
                                progress = 0.99
                            }
                        }
                        .onDrag {
                            return NSItemProvider(object: account.otpGenerator.code() as NSString)
                        }
                        .onTapGesture {
                            #if os(macOS)
                            let pasteboard = NSPasteboard.general
                            pasteboard.declareTypes([.string], owner: nil)
                            pasteboard.setString(account.otpGenerator.code(), forType: .string)
                            #else
                            UIPasteboard.general.string = account.otpGenerator.code()
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.success)
                            #endif

                            withAnimation {
                                showCopiedMessage = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showCopiedMessage = false
                                }
                            }
                        }
                } else {
                    GradientText("copied!", colors: [.yellow, .red, .orange], progress: 0)
                        .font(.body)
                        .transition(.slide)
                }
            }
        }.padding(.vertical, 10)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(account: sampleAccounts[0])
    }
}
