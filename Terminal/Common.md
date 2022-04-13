### Common

- When expanding an Xcode XIP archive, use the command line (xip --expand) rather than Archive Utility. It’s at least 25% faster–sometimes even twice as fast, depending on the circumstances. They both call into the Bom API
- You can use Mac OS to create a fake file to test file upload limits instead of hunting through your system for files that match that size with command `mkfile 10m testfile.pdf`
