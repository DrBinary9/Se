#!/bin/bash

# Function to perform the test
run_test() {
    expected="$1"
    operation="$2"
    result=$(echo "$operation" | bc)

    if [ "$result" == "$expected" ]; then
        echo "Test passed: $operation = $result"
    else
        echo "Test failed: $operation = $result, expected $expected"
    fi
}

# Begin tests
echo "Running conformance tests for the calculator..."

# Test cases
run_test "5" "2 + 3"
run_test "1" "3 - 2"
run_test "6" "2 * 3"
run_test "2" "6 / 3"
run_test "0" "3 - 3"
run_test "9" "3 + 3 + 3"
run_test "4" "12 / 3"
run_test "15" "5 * 3"

# Additional edge cases
run_test "0" "0 * 5"
run_test "1" "5 / 5"
run_test "10" "5 + 5"
run_test "1" "5 % 2"

# Division by zero test (expect an error)
division_by_zero=$(echo "scale=2; 1 / 0" | bc 2>&1)
if [[ "$division_by_zero" == *"Divide by zero"* ]]; then
    echo "Test passed: Division by zero correctly handled"
else
    echo "Test failed: Division by zero not handled correctly"
fi

echo "Conformance tests completed."

