#!/usr/bin/python3

import sys
import getopt
import string
import random
import sys

### variables
min_length_limit = 1
max_length_limit = 1000000
default_min_length = 50
default_max_length = 60
default_character_set = string.ascii_letters + string.digits
#####

def string_generator(min_length, max_length, characters):
    if min_length == max_length:
        length = min_length
    else:
        length = random.randrange(min_length, max_length)
    return ''.join(random.choice(characters) for _ in range(length))

def usage(log_string=''):
    sys.stderr.write("\n")
    sys.stderr.write('ERROR: ###### ***** ERROR ***** #####' + "\n")
    sys.stderr.write('ERROR: Message: ' + log_string + "\n")
    sys.stderr.write('ERROR: Usage:' + "\n")
    sys.stderr.write('ERROR:   --min <minimum length of string> - Range: 1 to ' + str(max_length_limit) + ' - Default: ' + str(default_min_length) + "\n")
    sys.stderr.write('ERROR:   --max <maximum length of string> - Range: 1 to ' + str(max_length_limit) + ' - Default: ' + str(default_max_length) + "\n")
    sys.stderr.write('ERROR:   --characters <character to use in the generating the string> Default: ' + default_character_set + "\n")
    sys.stderr.write('ERROR: ###### ***** ERROR ***** #####' + "\n")
    sys.exit(1)

def main(argv):
    character_set = ''
    try:
        opts, args = getopt.getopt( argv, '', [ 'min=', 'max=', 'characters=' ] )
    except getopt.GetoptError:
        usage()
    for opt, arg in opts:

        if opt in ("--min"):
            if not isinstance(int(arg), (int, long)):
                usage('--min <arg> is not and integer')
            elif int(arg) < min_length_limit:
                usage('--min <arg> is less than ' + str(min_length_limit))
            elif int(arg) > max_length_limit:
                usage('--min <arg> is greater than ' + str(max_length_limit))
            else:
                min_length = int(arg)

        if opt in ("--max"):
            if not isinstance(int(arg), (int, long)):
                usage('--max <arg> is not and integer')
            elif int(arg) < min_length_limit:
                usage('--max <arg> is less than ' + str(min_length_limit))
            elif int(arg) > max_length_limit:
                usage('--max <arg> is greater than ' + str(max_length_limit))
            else:
                max_length = int(arg)

        if opt in ("--characters"):
                characters = str(arg)

    if not 'min_length' in vars():
        min_length = int(default_min_length)

    if not 'max_length' in vars():
        max_length = int(default_max_length)

    if not 'characters' in vars():
        characters = default_character_set

    if min_length > max_length:
        usage('min_length: ' + str(min_length) + ' is set greater than max_length: ' + str(max_length))

    print string_generator( min_length, max_length, characters )

if __name__ == "__main__":
   main(sys.argv[1:])
