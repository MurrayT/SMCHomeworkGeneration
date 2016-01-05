︠32730b97-f01e-4993-a07e-cc6383e5893bas︠
%auto
load('demo_assignment_solutions.sage')
︡d8f07ff6-b0d6-4546-9b5c-a1d232ad8a0d︡︡{"auto":true}︡{"done":true}
︠299a1e71-6273-4d59-8c64-395d6488f8de︠
 
︡c210f479-4165-4a71-a15c-6c63e3c12f40︡
︠22112919-da8a-45ea-a467-dedb966c8447s︠

# ------------------------------------------------------------------------------------------
#
# STUDENTS:   Set "grading = False" to see if your code passes the revealed
#             testcases.
# PROFESSOR:  Remember to change "grading" to "True"!
#
grading = True
if grading:
    runfile('~/SMCHomeworkGeneration/demo_assignment/output/demo_assignment_grading_testcases.sage')
else:
    runfile('demo_assignment_revealed_testcases.sage')
runfile('~/SageTest/run_tests.sage')

testcases = TestCase.buildTestCases()

# Comment these lines if you want to run all tests.
problem_to_test = 5
testRunner([list(testcases)[problem_to_test - 1]])

# Uncomment the below line to run all tests.
# testRunner(testcases)

︡d68166f2-4cb2-4c1a-bc47-86adc7e55e93︡︡{"stdout":"Beginning tests\n---\nTesting kpoker_optimal_stack:\n","done":false}︡{"stdout":"Test 1 failed. \nTests complete: 0 of 1 passed (1 failure(s))\nTime taken for non-timeout tests: 0.0550 ms (0.0550 ms average)\n","done":false}︡{"stdout":"---\nResults:\n1 Functions tested\n0 of 1 tests passed (1 failure(s))\nSuccess rate: 0.00 %\nTotal time: 0.0550 ms. (0.0000 ms on timeouts, 0.0550 ms on completed tests)\n","done":false}︡{"done":true}
︠0c179112-e86f-45f1-9c4e-b931359818cd︠









