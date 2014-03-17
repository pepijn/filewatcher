# Filewatcher

[![Build Status](https://secure.travis-ci.org/pepijn/filewatcher.png?branch=master)](https://travis-ci.org/pepijn/filewatcher)

Intended usage is by activation from incron: http://inotify.aiken.cz/?section=incron&page=doc&lang=en

`filewatcher /path/to/file/that/has/changed`

Filewatcher stores symbolic links to the changed files in a buffer at `FW_BUFFER_PATH`. When the amount of files in the buffer reaches `FW_BUFFER_SIZE`, an email will be sent with the `pony` gem (simulated with the `letter_opener` gem) with a list of changes. When the email is not opened by `launchy`, it can be seen in `$FW_BUFFER_PATH/email`.

## Defaults

```
FW_BUFFER_PATH = ~/.filewatcher
FW_BUFFER_SIZE = 100
```

