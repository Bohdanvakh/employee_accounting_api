# README

Branch and commits naming convention
Format: <type>(<scope>)/<ticket_number>: <subject>

<scope> is optional.
<ticket_number> - is mandatory in case you are working on a specific ticket. Can be omitted if ticket is not created still.

Example
feat: add user model
^--^  ^-------------------^
|     |
|     +-> Summary in present tense.
|
+-------> Type: chore, docs, feat, fix, refactor, style, or test.
More Examples:

feat: (new feature for the user, not a new feature for build script)
fix: (bug fix for the user, not a fix to a build script)
docs: (changes to the documentation)
style: (formatting, missing semi colons, etc; no production code change)
refactor: (refactoring production code, eg. renaming a variable)
test: (adding missing tests, refactoring tests; no production code change)
chore: (updating grunt tasks etc; no production code change)
