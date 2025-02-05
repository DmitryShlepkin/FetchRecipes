//
//  RecipeListViewModelTests.swift
//  FetchRecipes
//
//  Created by Dmitry Shlepkin on 2/3/25.
//

import Testing
import Foundation
@testable import FetchRecipes

@Suite("HomeViewModel")
struct RecipeListViewModelTests {
    
    @Test("isRecipeListValid(valid)", arguments: [
        (RecipeListMock.validList, true),
        (RecipeListMock.invalidList, false),
    ]) func testIsRecipeListValid_givenPayload_expectIsRecipeListValidToEqualExpectation(payload: Recipes, expectation: Bool) {
        let sut = RecipeListViewModel()
        #expect(sut.isRecipeListValid(payload.recipes!) == expectation)
    }
        
    @MainActor @Test("update(state:)") func testUpdateState_givenStateEqualToInitial_expectStateToBeSuccess () {
        let sut = RecipeListViewModel()
        sut.update(state: .success)
        #expect(sut.state == .success)
    }
    
    @MainActor @Test("fetchRecipeList(success)") func testFetchRecipeList_givenValidSuccessResponse_expectStateToBeSuccess () async throws {
        let networkManagerMock = NetworkManagerMock(response: RecipeListMock.validList)
        DependencyContainer.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = RecipeListViewModel()
        do {
            try await sut.fetchRecipeList()
            try await Task.sleep(for: .seconds(3))
        } catch {
            throw error
        }
        #expect(sut.state == .success)
    }
    
    @MainActor @Test("fetchRecipeList(invalid)") func testFetchRecipeList_givenInvalidSuccessResponse_expectStateToBeError () async throws {
        let networkManagerMock = NetworkManagerMock(response: RecipeListMock.invalidList)
        DependencyContainer.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = RecipeListViewModel()
        do {
            try await sut.fetchRecipeList()
            try await Task.sleep(for: .seconds(3))
        } catch {
            throw error
        }
        #expect(sut.state == .error)
    }
    
    @MainActor @Test("fetchRecipeList(empty)") func testFetchRecipeList_givenEmptySuccessResponse_expectStateToBeEmpty () async throws {
        let networkManagerMock = NetworkManagerMock(response: .init(recipes: []))
        DependencyContainer.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = RecipeListViewModel()
        do {
            try await sut.fetchRecipeList()
            try await Task.sleep(for: .seconds(3))
        } catch {
            throw error
        }
        #expect(sut.state == .empty)
    }
    
    @MainActor @Test("fetchRecipeList(error)") func testFetchRecipeList_givenErrorResponse_expectStateToBeError () async throws {
        let networkManagerMock = NetworkManagerWithErrorMock(response: .init(recipes: []))
        DependencyContainer.register(type: NetworkManagable.self, networkManagerMock, update: true)
        let sut = RecipeListViewModel()
        do {
            try await sut.fetchRecipeList()
            try await Task.sleep(for: .seconds(3))
        } catch {
            #expect(sut.state == .error)
        }
    }
    
}
