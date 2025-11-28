# Testing Infrastructure

This directory contains all the tests for the Orbiq application, organized by test type.

## Directory Structure

- `unit/` - Unit tests for business logic, use cases, and utility functions
- `widget/` - Widget tests for UI components
- `integration/` - Integration tests that test multiple components working together
- `mocks/` - Mock implementations for testing

## Test Types

### Unit Tests
Unit tests focus on testing individual functions, classes, or methods in isolation. They should:
- Test business logic
- Test use cases
- Test utility functions
- Mock external dependencies

### Widget Tests
Widget tests focus on testing the UI components of the application. They should:
- Test widget rendering
- Test user interactions
- Test state changes in response to user actions
- Test widget composition

### Integration Tests
Integration tests focus on testing how multiple components work together. They should:
- Test the interaction between layers (data, domain, presentation)
- Test complete user flows
- Test API integrations
- Test database operations

## Running Tests

To run all tests:
```bash
flutter test
```

To run a specific test file:
```bash
flutter test test/unit/example_test.dart
```

To run tests with coverage:
```bash
flutter test --coverage
```

## Best Practices

1. **Name tests descriptively**: Use clear, descriptive names that explain what is being tested
2. **Follow the AAA pattern**: Arrange, Act, Assert
3. **Keep tests independent**: Each test should be able to run independently
4. **Use setUp and tearDown**: Use these methods to prepare and clean up test environments
5. **Mock external dependencies**: Use mocks to isolate the code being tested
6. **Test edge cases**: Test both expected and unexpected inputs
7. **Keep tests fast**: Avoid unnecessary delays or complex setups