filewatcher
===========

Intended usage is by activation from incron: http://inotify.aiken.cz/?section=incron&page=doc&lang=en

`filewatcher /path/to/file/that/has/changed`

Filewatcher stores symbolic links to the changed files in a buffer at `FW_BUFFER_PATH`. When the amount of files in the buffer reaches `FW_BUFFER_SIZE`, an email will be sent with the `pony` gem (simulated with the `letter_opener` gem) with a list of changes.

### Defaults

```
FW_BUFFER_PATH = ~/.filewatcher
FW_BUFFER_SIZE = 100
```

