navel-collector-twitter-stream-track
====================================

This collector receive Twitter streaming API.

Status
------

- master

[![Build Status](https://travis-ci.org/Navel-IT/navel-collector-twitter-stream-track.svg?branch=master)](https://travis-ci.org/Navel-IT/navel-collector-twitter-stream-track?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/Navel-IT/navel-collector-twitter-stream-track/badge.svg?branch=master)](https://coveralls.io/github/Navel-IT/navel-collector-twitter-stream-track?branch=master)

- devel

[![Build Status](https://travis-ci.org/Navel-IT/navel-collector-twitter-stream-track.svg?branch=devel)](https://travis-ci.org/Navel-IT/navel-collector-twitter-stream-track?branch=devel)
[![Coverage Status](https://coveralls.io/repos/github/Navel-IT/navel-collector-twitter-stream-track/badge.svg?branch=devel)](https://coveralls.io/github/Navel-IT/navel-collector-twitter-stream-track?branch=devel)

Installation
------------

```bash
cpanm https://github.com/navel-it/navel-collector-twitter-stream-track.git
```

Configuration
-------------

```json
{
    "backend": "Navel::Collector::Twitter::Stream::Track",
    "backend_input": {
        "token": "NPcudxy0yU5T3tBzho7iCotZ3cnetKwcTIRlX0iwRl0",
        "token_secret": "veNRnAWe6inFuo8o2u8SLLZLjolYDmDP7SzL0YfYI",
        "consumer_key": "cChZNFj6T5R0TigYB9yd1w",
        "consumer_secret": "Fuo8o2u8SLLZLjolYDmDP7Sz",
        "track": "Debian,Angular"
    }
}
```

Copyright
---------

Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

License
-------

navel-collector-twitter-stream-track is licensed under the Apache License, Version 2.0
