see https://askubuntu.com/questions/982090/rename-command-with-perl-expression

In general rename renames the filenames supplied according to the rule specified as the first argument of the command. The the filenames are supplied by the arguments that follow the first one.

The first argument in the example command (rename 's/\.htm/\.html/' *.htm) has fur parts, where in this case / is a delimiter of these parts:

s/regexp/replacement/[flags]
The s command means substitute: s/<old>/<new>/. Match the regular-expression against the content of the pattern space. If found, replace matched string with replacement.

Regular expression that matches to the strings that should be substituted. In the current case this is just the string .htm.

In most regular expressions the dot . matches to every character. In this case we want to use the dot literally, so we need to escape its special meaning by using the back slash \ (quoting a single character).

Replacement of the sting/regexp matched to 2.

Flag that is not presented in the current example. It could be for example the flag g - apply the replacement to all matches to the regexp, not just the first. Let's assume we have a file named my.htm-file.htm:

The original command rename 's/\.htm/\.html/' *.htm will rename the file in this way: my.html-file.htm. Look at the bottom of the answer how to avoid this problem.

By adding the g flag - rename 's/\.htm/\.html/g' *.htm - the new filename will be: my.html-file.html.

According to the filenames: * can represent any number of characters (including zero, in other words, zero or more characters). The shell will expand that glob, and it passes the matching filenames as separate arguments to rename So *.htm - will match to all filenames in the current path that end with the string .htm. For example if you have 1.htm, 2.htm, 3.htm, 4.htm, and 5.htm then rename 's/\.htm/\.html/' *.htm passes exactly the same arguments to rename as running:

rename 's/\.htm/\.html/' 1.htm 2.htm 3.htm 4.htm 5.htm
The whole command (rename 's/\.htm/\.html/' *.htm) could be read in this way:

rename `<substitute>/<the string ".htm">/<with the string ".html">/` <do it for all files in the current path that end with ".htm">
Let's go back to the example when we have a file named my.htm-file.htm. Probably we want to change the last part of the filename so called extension after the last dot. For this purpose we should modify the rename command in this way:

rename 's/\.htm$/\.html/' *.htm
Where the $ sign matches to the end of the line and literally means "read backward".

^ - Matches the null string at beginning of the pattern space, i.e. what appears after the circumflex must appear at the beginning of the pattern space. (read more)

^ acts as a special character only at the beginning of the regular expression or subexpression (that is, after \( or \|). Portable scripts should avoid ^ at the beginning of a subexpression, though, as POSIX allows implementations that treat ^ as an ordinary character in that context.

$ - It is the same as ^, but refers to end of pattern space. $ also acts as a special character only at the end of the regular expression or subexpression (that is, before \) or \|), and its use at the end of a subexpression is not portable.

References:

Bash Guide for Beginners: Shell expansion
GNU/Linux Command-Line Tools Summary: Wildcards
perlre - Perl regular expressions
GNU: sed, a stream editor
Online regular expression testers

example:
rename 's/^([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2}) ([[:digit:]]{2})\.([[:digit:]]{2})\.([[:digit:]]{2}).jpg$/$1$2$3_$4$5$6.jpg/' *