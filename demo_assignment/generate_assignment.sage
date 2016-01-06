# Loading
load('../necessary_functions.py')

# Name your homework set
this_is = 'demo_assignment'

info = [this_is]
assignment = [info,[],[],[],[],[],[],[],[]]

# ------------------------------------------------------ #

# ------------------------------------------------------ #

# Problem 1

# Name of the function to be tested
func_name = 'lowest_common_multiple'

# Input variable names, as a string containing a tuple
inp_vars = '(n)'

# Help or hints for students
help_text ='''Project Euler Problem 5.
Given a positive integer n. Find the smallest positive number evenly divisible by all numbers from 1 to n'''

# Default answer when unimplemented
default = 0

# Number of testcases
num_tests = 20

# Generate the testcases. This is the part I always
# need to change most between problems
testcases = range(num_tests)
# for i in range(num_tests):
#     # generate your testcases somehow
#     testcases.append(testcaseinput)

# Set the likelyhood that a testcase is revealed to
# the students (on the scale 0 (never) to 1 (always))
flip = 0.5

# Maximum time allowed per testcase in seconds
timeout = 5

# How should the output given by the student be tested?
# Either

# 1) There is one correct answer and we generate them once and for all
# handler = [answer_function(*test) for test in testcases]
# The splat(*) operator is only necessary when the input has more than one var.
# Note the *test: This is to remove the parenthesis from the input variables

# 2) The output given by the student is one of many correct ouputs (think divisors)
# handler = lambda student_answer : testcase % student_answer == 0

handler = [lcm(range(1,test+1)) for test in testcases]

# Adding this problem to the problem set
assignment = add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info)

# ------------------------------------------------------ #

# Problem 2

# Name of the function to be tested
func_name = 'pythagorean_triples'

# Input variable names, as a string containing a tuple
inp_vars = '(n)'

# Help or hints for students
help_text ='''Project Euler Problem 9.
Given a positive integer n. Find a Pythagorean triple such that a+b+c=n'''

# Default answer when unimplemented
default = '(0,0,0)'

# Number of testcases
num_tests = 20

# Generate the testcases. This is the part I always
# need to change most between problems
N = 1000
sumdict = {}
for a in range(1,N):
    for b in range(a,N):
        C = a^2 + b^2
        if is_square(C):
            c = int(sqrt(C))
            summa = a+b+c
            if summa in sumdict:
                sumdict[summa].append((a*b*c))
            else:
                sumdict[summa] = [(a*b*c)]

testcases = []
for i in range(num_tests):
    # generate your testcases somehow

    testcaseinput = choice(sumdict.keys())
    testcases.append(testcaseinput)

# Set the likelyhood that a testcase is revealed to
# the students (on the scale 0 (never) to 1 (always))
flip = 0.5

# Maximum time allowed per testcase in seconds
timeout = 5

# How should the output given by the student be tested?
# Either

# 1) There is one correct answer and we generate them once and for all
# handler = [answer_function(*test) for test in testcases]
# The splat(*) operator is only necessary when the input has more than one var.
# Note the *test: This is to remove the parenthesis from the input variables

# 2) The output given by the student is one of many correct ouputs (think divisors)
# handler = lambda student_answer : testcase % student_answer == 0


handler = "lambda student_answer : student_answer[0]+student_answer[1]+student_answer[2] == testcase and student_answer[0]^2 + student_answer[1]^2 - student_answer[2]^2 == 0"

# Adding this problem to the problem set
assignment = add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info)

# ------------------------------------------------------ #

#  Problem 3

# Name of the function to be tested
func_name = 'k_digits_sum'

# Input variable names, as a string containing a tuple
inp_vars = '(L,k)'

# Help or hints for students
help_text ='''Project Euler Problem 13.
Given a list L of integers and an integer k. Find the first k digits of the sum of the elements of L.'''

# Default answer when unimplemented
default = 0

# Number of testcases
num_tests = 20

# Generate the testcases. This is the part I always
# need to change most between problems
testcases = []
for i in range(num_tests):
    # generate your testcases somehow
    l = [randint(10^25,10^30) for _ in range(randint(30,60))]
    k = randint(5,14)
    testcaseinput=(l,k)
    testcases.append(testcaseinput)

# Set the likelyhood that a testcase is revealed to
# the students (on the scale 0 (never) to 1 (always))
flip = 0.5

# Maximum time allowed per testcase in seconds
timeout = 5

# How should the output given by the student be tested?
# Either

# 1) There is one correct answer and we generate them once and for all
# handler = [answer_function(*test) for test in testcases]
# The splat(*) operator is only necessary when the input has more than one var.
# Note the *test: This is to remove the parenthesis from the input variables

# 2) The output given by the student is one of many correct ouputs (think divisors)
# handler = lambda student_answer : testcase % student_answer == 0

handler = [int(str(sum(test[0]))[0:test[1]]) for test in testcases]

# Adding this problem to the problem set
assignment = add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info)

# ------------------------------------------------------ #

# Problem 4

# Name of the function to be tested
func_name = 'modular_sqrt'

# Input variable names, as a string containing a tuple
inp_vars = '(n,a)'

# Help or hints for students
help_text ='''Find a square root of a modulo n'''

# Default answer when unimplemented
default = '0'

# Number of testcases
num_tests = 20

# Generate the testcases. This is the part I always
# need to change most between problems
testcases = []
for i in range(num_tests):
    # generate your testcases somehow
    n = randint(1,100)
    a = Mod(randint(0,n-1),n)^2
    testcaseinput=(a,n)
    testcases.append(testcaseinput)

# Set the likelyhood that a testcase is revealed to
# the students (on the scale 0 (never) to 1 (always))
flip = 0.5

# Maximum time allowed per testcase in seconds
timeout = 5

# How should the output given by the student be tested?
# Either

# 1) There is one correct answer and we generate them once and for all
# handler = [answer_function(*test) for test in testcases]
# The splat(*) operator is only necessary when the input has more than one var.
# Note the *test: This is to remove the parenthesis from the input variables

# 2) The output given by the student is one of many correct ouputs (think divisors)
# handler = lambda student_answer : testcase % student_answer == 0

handler = "lambda student_answer: Mod(student_answer ^ 2, testcase[0]) == Mod(testcase[1],testcase[0])"

# Adding this problem to the problem set
assignment = add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info)

# ------------------------------------------------------ #

# Problem 5

# Name of the function to be tested
func_name = 'kpoker_optimal_stack'

# Input variable names, as a string containing a tuple
inp_vars = '()'

# Help or hints for students
help_text ='''Return the stackings in K-poker that are optimal for Player 1 for all cuts'''

# Default answer when unimplemented
default = '[]'

# Number of testcases
num_tests = 1

# Generate the testcases. This is the part I always
# need to change most between problems
testcases = []
# for i in range(num_tests):
#     # generate your testcases somehow

#     testcases.append(testcaseinput)

# Set the likelyhood that a testcase is revealed to
# the students (on the scale 0 (never) to 1 (always))
flip = 0

# Maximum time allowed per testcase in seconds
timeout = 5

# How should the output given by the student be tested?
# Either

# 1) There is one correct answer and we generate them once and for all
# handler = [answer_function(*test) for test in testcases]
# The splat(*) operator is only necessary when the input has more than one var.
# Note the *test: This is to remove the parenthesis from the input variables

# 2) The output given by the student is one of many correct ouputs (think divisors)
# handler = lambda student_answer : testcase % student_answer == 0

def m3p7():
    def rank(h):
        h = sorted(h)
        if h[5] - h[1] == 4:
            return (1, h[1:6][-1])
        if h[4] - h[0] == 4:
            return (1, h[0:5][-1])
        return (0, h[1:6][::-1])

    def p1_wins(s):
        return rank([s[0]] + [s[2]] + s[4:-1]) > rank([s[1]] + [s[3]] + s[4:-1])

    def p1_optimal(s):
        for i in range(len(s)):
            if not p1_wins(s[i:] + s[:i]):
                return False
        return True

    return [ [2]+list(p) for p in Permutations([3,4,5,6,7,8,9,10]) if p1_optimal([2]+list(p)) ]

handler = [m3p7()]

# Adding this problem to the problem set
assignment = add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info)

# ------------------------------------------------------ #

# # Problem 6

# # Name of the function to be tested
# func_name =

# # Input variable names, as a string containing a tuple
# inp_vars =

# # Help or hints for students
# help_text =''''''

# # Default answer when unimplemented
# default =

# # Number of testcases
# num_tests = 100

# # Generate the testcases. This is the part I always
# # need to change most between problems
# testcases = []
# for i in range(num_tests):
#     # generate your testcases somehow

#     testcases.append(testcaseinput)

# # Set the likelyhood that a testcase is revealed to
# # the students (on the scale 0 (never) to 1 (always))
# flip = 0.25

# # Maximum time allowed per testcase in seconds
# timeout = 5

# # How should the output given by the student be tested?
# # Either

# # 1) There is one correct answer and we generate them once and for all
# # handler = [answer_function(*test) for test in testcases]
# # The splat(*) operator is only necessary when the input has more than one var.
# # Note the *test: This is to remove the parenthesis from the input variables

# # 2) The output given by the student is one of many correct ouputs (think divisors)
# # handler = lambda student_answer : testcase % student_answer == 0

# handler =

# # Adding this problem to the problem set
# assignment = add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info)

# ------------------------------------------------------ #
# ------------------------------------------------------ #

# All done writing problems?
# The following will be created:

# - A folder to assign to your students, containing:
# -- A .sage file for students to write their solutions
# -- A .sagews worksheet for students to play with their solutions
# -- A .sage file containing revealed testcases

# - A folder for you, containing:
# -- A .sage file for students to write their solutions
# -- A .sagews worksheet for students to play with their solutions
# -- A. sage file containing the same revealed testcases the students get
# -- A .sage file containing all testcases to grade

create_assignment(assignment)
