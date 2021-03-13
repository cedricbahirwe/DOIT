//
//  HomeView.swift
//  Mobile
//
//  Created by Cédric Bahirwe on 21/02/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: MainViewModel
    @State private var showFilter: Bool = false
    
    @State private var username: String = TODOSession.shared.toDoUser?.name ?? ""
    @State private var showUserNameAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    Color.darkBlue
                        .ignoresSafeArea()
                        .frame(height: size.height/3)
                        .colorScheme(.light)
                    Color(.systemBackground)
                }
                
                VStack(spacing: 0) {
                    HStack {
                        Image("IW_logo")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Spacer()
                        NavigationLink(
                            destination: TaskDetailsView(),
                            isActive: $vm.goToTaskDetails
                        ) { }
                        
                        HStack(spacing: 20) {
                            if vm.isSearching {
                                TextField("Search a task", text: $vm.searchText.onChange({ text in
                                    if text.count >= 3 {
                                        vm.searchedEvents = vm.tasks.filter({$0.title.lowercased().contains(text.lowercased())})
                                    } else {
                                        vm.searchedEvents = vm.tasks
                                    }
                                }))
                                .foregroundColor(.white)
                                .font(.montSerrat(.regular))
                                .padding(.leading,5)
                                .frame(height: 30)
                            }
                            
                            Image(systemName: vm.isSearching ? "plus" : "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(5)
                                .frame(width: 28, height: 28)
                                .rotationEffect(.degrees(vm.isSearching ? 45 : 0))
                                .padding(.trailing, 5)
                                .onTapGesture {
                                    vm.filterOption = nil
                                    vm.isSearching.toggle()
                                    if vm.isSearching {
                                        vm.searchText = ""
                                    }
                                }
                        }
                        .foregroundColor(.white)
                        .frame(height: 32)
                        .border(vm.isSearching ? Color.white : Color.clear)
                        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.5))
                        
                        
                        Button(action: {
                            showFilter.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3.decrease")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 25)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(5)
                    .padding(.horizontal)
                    
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Welcome")
                                    .font(.montSerrat(.bold, size: 20))
                                HStack(spacing: 3) {
                                    Text(username)
                                        .font(.montSerrat(.bold, size: 24))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)
                                    
                                    Button(action: {
                                        showUserNameAlert.toggle()
                                    }) {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .foregroundColor(Color(.systemBackground))
                                            .padding(6)
                                            .frame(width: 20, height: 20)
                                            .background(Color.darkBlue)
                                            .clipShape(Circle())
                                            .padding(8)
                                    }
                                }
                            }
                            .padding(.top)
                            
                            if !vm.isSearching {
                                VStack(spacing: 20) {
                                    HStack(spacing: 20) {
                                        GridItemView(title: "\(vm.totalTasks)", subtitle: "Total Tasks")
                                        GridItemView(title: "\(vm.activeTasks)", subtitle: "Active Tasks")
                                    }
                                    
                                    HStack(spacing: 20) {
                                        GridItemView(title: "\(vm.doneTasks)", subtitle: "Tasks Done")
                                        GridItemView(title: "\(vm.activeHighPriorityTasks)", subtitle: "Active High Priority")
                                    }
                                }
                                .padding(.top)
                            }
                            VStack(spacing: 5) {
                                if vm.tasks.isEmpty {
                                    VStack(spacing: 0) {
                                        Text("NOTHING HERE")
                                            .font(.montSerrat(.bold))
                                        
                                        Text("Just like your crush's replies")
                                            .font(.montSerrat(.bold, size: 16))
                                            .foregroundColor(.lightBlue)
                                        
                                        NavigationLink(destination: NewTaskView()) {
                                            Text("START WITH A NEW TASK")
                                                .font(.montSerrat(.bold, size: 10))
                                                .foregroundColor(Color(.systemBackground))
                                                .padding(.vertical, 12)
                                                .padding(.horizontal, 24)
                                                .background(Color.darkBlack)
                                                .cornerRadius(5)
                                        }
                                        .padding(.top, 25)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                } else {
                                    TasksList()
                                }
                                
                            }
                            .overlay(
                                NavigationLink(destination: NewTaskView()) {
                                    Image(systemName: "plus")
                                        .imageScale(.medium)
                                        .foregroundColor(.white)
                                        .frame(width: 50, height: 50)
                                        .background(Color.darkBlue)
                                        .clipShape(Circle())
                                        .shadow(color: .black, radius: 3, x: 0.0, y: 3)
                                        .colorScheme(.light)
                                        .padding(.bottom, 10)
                                }
                                , alignment: .bottomTrailing
                            )
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color(.systemBackground)
                                .ignoresSafeArea(.all, edges: .bottom)
                                .onTapGesture {
                                    showFilter = false
                                }
                        )
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                        .ignoresSafeArea(.keyboard)
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("FILTER BY PRIORITY")
                                .font(.montSerrat(.bold, size: 12))
                                .padding(.bottom, 6)
                            Button(action: {
                                withAnimation {
                                    vm.filterOption = nil
                                }
                            }) {
                                Text("All")
                                    .font(.montSerrat(.bold, size: 12))
                                    .foregroundColor(.lightBlue)
                                    .padding(2)
                            }
                            
                            
                            Button(action: {
                                withAnimation {
                                    vm.filterOption = TaskPriority.low
                                }
                            }) {
                                Text("Low Priority")
                                    .font(.montSerrat(.bold, size: 12))
                                    .foregroundColor(.lightBlue)
                                    .padding(2)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    vm.filterOption = TaskPriority.medium
                                }
                            }) {
                                Text("Medium Priority")
                                    .font(.montSerrat(.bold, size: 12))
                                    .foregroundColor(.lightBlue)
                                    .padding(2)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    vm.filterOption = TaskPriority.high                                }
                            }) {
                                Text("High Priority")
                                    .font(.montSerrat(.bold, size: 12))
                                    .foregroundColor(.lightBlue)
                                    .padding(2)
                            }
                            
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .scaleEffect(showFilter ? 1 : 0.1, anchor: .topTrailing)
                        .padding(.trailing, 20)
                        .opacity(showFilter ? 1 : 0.0)
                        .animation(.default)
                    }
                }

                AlertFiedView(isPresented: $showUserNameAlert, username: $username)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MainViewModel())
        //            .environment(\.colorScheme, .dark)
    }
}

