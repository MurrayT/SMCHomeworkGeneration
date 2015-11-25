#!/usr/bin/env python

import os
import errno
import shutil
import itertools
import ast
from uuid import uuid4

MARKERS = {'cell':u"\uFE20", 'output':u"\uFE21"}

top_stub = """'''
Group Members
=============
Group member 1's id:
Group member 2's id:
'''

"""

def uuid():
    return unicode(uuid4())

def write_sagews(input_cells, filename):
    '''
    Writes a sage worksheet with the given cells to filename'''
    out = u""
    for x in input_cells:
        input = unicode(x, encoding='utf8')
        modes = u''
        if '%auto' in input:
            modes += u'a'
        if '%hide' in input:
            modes += u'i'
        if '%hideall' in input:
            modes += u'o'
        out += MARKERS['cell'] + uuid() + modes + MARKERS['cell'] + u'\n'
        out += input
        out += u'\n' + MARKERS['output'] + uuid() + MARKERS['output'] + u'\n'
    open(filename,'wb').write(out.encode('utf8'))

def make_sure_path_exists(path):
    '''
    Check if the directory at path exists,
    if not, create it

    Source: http://stackoverflow.com/questions/273192/in-python-check-if-a-directory-exists-and-create-it-if-necessary
    '''
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise
    return path

def add_to_set(assignment,func_name, inp_vars, help_text, default, flip, testcases, timeout, handler, info):

    print "Adding %s to assignment" % func_name
    assignment[1].append(func_name)
    assignment[2].append(inp_vars)
    assignment[3].append(help_text)
    assignment[4].append(default)
    assignment[5].append(flip)
    assignment[6].append(testcases)
    assignment[7].append(timeout)
    assignment[8].append(handler)


    return assignment # Where is hw_set defined, should we instead pass it as argument?

def create_assignment(assignment):
    information = assignment[0]
    assignment_name = information[0]

    output_dir = make_sure_path_exists("output")

    all_function_names = assignment[1]
    all_input_vars = assignment[2]
    all_help_texts = assignment[3]
    all_defaults = assignment[4]
    all_flips = assignment[5]
    all_testcases = assignment[6]
    all_timeouts = assignment[7]
    all_handlers = assignment[8]

    # Start by creating the solutions file.
    print "Creating Solutions file"
    solutions_file = open(output_dir+"/%s_solutions.sage" % assignment_name ,"w")

    solutions_file.write(top_stub)

    for (function_name,input_vars,help_text,default) in itertools.izip(all_function_names, all_input_vars,all_help_texts,all_defaults):
        solutions_file.write('def %s%s:\n' % (function_name, input_vars))
        solutions_file.write('    \'\'\'%s\n    \'\'\'\n' % help_text)
        solutions_file.write('    return %s\n\n' % default)
    solutions_file.close()

    # Then create the playground worksheet
    print "Creating Playground file"
    testing_cell = '''
# ------------------------------------------------------------------------------------------
#
# STUDENTS:   Set "grading = False" to see if your code passes the revealed
#             testcases.
# PROFESSOR:  Remember to change "grading" to "True"!
#
grading = False
if grading:
    runfile('~/SMCAssignmentGeneration/{}/{}_grading_testcases.sage')
else:
    runfile('{}_revealed_testcases.sage')
runfile('~/SageTest/run_tests.sage')

testRunner(TestCase.buildTestCases())
'''.format(assignment_name,assignment_name,assignment_name)

    load_cell = "%%auto\nload('%s_solutions.sage')" % assignment_name

    write_sagews([load_cell, " ",testing_cell],output_dir+"/%s_playground.sagews" % assignment_name )

    # Now create the test cases
    print "Creating testcase files"
    grading = open(output_dir+'/%s_grading_testcases.sage' % assignment_name, 'w')
    revealed = open(output_dir+'/%s_revealed_testcases.sage' % assignment_name, 'w')

    # The functions on top
    print "Writing function names"
    functions = ",\n".join(str(dict(enumerate(all_function_names))).split(",")).replace("'","")
    grading.write('functions = %s\n\n' % functions)
    revealed.write('functions = %s\n\n' % functions)

    # Next the inputs
    print "Writing inputs"
    grading.write('inputs = {\n')
    revealed.write('inputs = {\n')

    all_remember_flips = []

    for (index, value) in enumerate(itertools.izip(all_testcases,all_flips)):
        testcases, flip = value

        remember_flips = [random() < flip for t in testcases]
        all_remember_flips.append(remember_flips)

        grading.write('  %s:{\n' % index)
        revealed.write('  %s:{\n' % index)

        for (index2, testcase) in enumerate(testcases):
            grading.write('    %s: %s,\n' %(index2, testcase))
            if remember_flips[index2]:
                revealed.write('    %s: %s,\n' %(index2, testcase))

        grading.write('  },\n')
        revealed.write('  },\n')
    grading.write('}\n\n')
    revealed.write('}\n\n')


    # Now the expected outputs
    print "Writing outputs"
    grading.write('expected = {\n')
    revealed.write('expected = {\n')

#     for i in range(len(all_func_names)):
    for (index, value) in enumerate(itertools.izip(all_testcases,all_handlers)):
        testcases, handler = value

        remember_flips = all_remember_flips[index]

        grading.write('  %s:{\n' %(index))
        revealed.write('  %s:{\n' %(index))

        if type(handler) == list:

            for (j,h) in enumerate(handler):
                grading.write('    %s: %s,\n' %(j, h))
                if remember_flips[j]:
                    revealed.write('    %s: %s,\n' %(j, h))

        else:
            for (j,testcase) in enumerate(testcases):

                def repl(str,u):
                    formatter = '.format('
                    for i in range(u):
                        str = str.replace('testcase[%s]' %i, '{testcase%s}' %i)
                        formatter += 'testcase%s=testcase[%s]' %(i,i)
                        if i != u-1:
                            formatter += ', '
                        else:
                            formatter += ')'
                    return str, formatter

                handler_repl, formatter = repl(handler, len(testcase))

                check = '"%s"%s' %(handler_repl, formatter)
                check = eval(check) # I don't like this line, is there an alternative? -Murray

                grading.write(('    %s: %s,\n' %(j, check)))
                if remember_flips[j]:
                    revealed.write(('    %s: %s,\n' %(j, check)))

        grading.write('  },\n')
        revealed.write('  },\n')
    grading.write('}\n\n')
    revealed.write('}\n\n')


    # And the allowed running times at the bottom
    print "Writing time-outs"
    grading.write('maxtimes = {\n')
    revealed.write('maxtimes = {\n')
    for i in enumerate(all_timeouts):
        grading.write('  %s:%s,\n' %i)
        revealed.write('  %s:%s,\n' %i)
    grading.write('}')
    revealed.write('}')

    grading.close()
    revealed.close()

    #finally we dump the student copy into the assignment directory

    path = make_sure_path_exists("../../assignments/%s" % assignment_name)
    shutil.copyfile(output_dir+"/%s_solutions.sage" % assignment_name, path+"/%s_solutions.sage" % assignment_name)
    shutil.copyfile(output_dir+"/%s_playground.sagews" % assignment_name, path+"/%s_playground.sagews" % assignment_name)
    shutil.copyfile(output_dir+"/%s_revealed_testcases.sage" % assignment_name, path+"/%s_revealed_testcases.sage" % assignment_name)
