# Creating Tests

Testing class files are automatically detected when they are placed inside the **test/tests** directory.

Each testing class is expected to have one or more tests, each of which is a function beginning with the word "test".
Each function is to return the result of a call to an ASSERT function (either TRUE, FALSE, and EQUALS.)

The testing class also needs to have a NAME field; this name will appear on the console when running tests.

