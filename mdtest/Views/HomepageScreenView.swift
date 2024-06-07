//
//  HomepageScreenView.swift
//  mdtest
//
//  Created by Rifqi Alhakim Hariyantoputera on 07/06/24.
//

import SwiftUI

struct HomepageScreenView: View {
    @StateObject private var vm = HomepageScreenViewModel()
    
    var body: some View {
        ScrollView {
            if vm.users.isEmpty {
                VStack(alignment: .center) {
                    Text("No Data to show.")
                        .font(.system(.subheadline, weight: .medium))
                        .foregroundStyle(Color(UIColor.secondaryLabel))
                }
            } else {
                ForEach(vm.tempUsers, id:\.self) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.photoURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                            default:
                                Image(systemName: "rectangle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .foregroundStyle(Color(UIColor.secondaryLabel))
                            }
                        }
                        .frame(width: 75, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.secondaryLabel))
                                .padding(-2)
                        )
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(user.name)
                                .font(.system(.title3, weight: .bold))
                                .foregroundStyle(Color(UIColor.label))
                                .padding(.bottom, 5)
                            Text(user.email)
                                .font(.system(.body, weight: .medium))
                                .foregroundStyle(Color(UIColor.secondaryLabel))
                                .padding(.bottom, 5)
                            HStack(spacing: 0) {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(user.isEmailVerified ? Color(UIColor.green) : Color(UIColor.red))
                                Text(user.isEmailVerified ? " Email Verified" : " Email not Verified")
                                    .font(.system(.callout))
                                    .foregroundStyle(Color(UIColor.secondaryLabel))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 10)
                    .padding(.bottom, 10)
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Homepage")
        .searchable(text: $vm.searchText)
        .padding(.all)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    
                    Button {
                        vm.showActionSheet = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
            }
        }
        .confirmationDialog("Filter User", isPresented: $vm.showActionSheet) {
            ForEach(UserFilterCategory.allCases, id:\.self) { item in
                Button {
                    vm.selectedFilter = item
                } label: {
                    Text(item.description)
                }
            }
        }
        .onAppear {
            if vm.isAuth != AuthManager.shared.isAuth {
                vm.isAuth = AuthManager.shared.isAuth
            }
        }
        .alert(vm.alertMessage, isPresented: $vm.isShowingAlert) {
            if vm.alertMessage.contains("Fetch User failed") {
                Button("Retry") {
                    vm.fetchUsers()
                }
                Button("Offline Mode") {
                    vm.isShowingAlert = false
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomepageScreenView()
    }
}
