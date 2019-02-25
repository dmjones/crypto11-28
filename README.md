# Example code for https://github.com/ThalesIgnite/crypto11/issues/28

Instructions to build:

```
docker build . -t crypto11-test
docker volume create tokens
docker run --mount src=tokens,dst=/tokens crypto11-test
```

This will generate a key and output the label, e.g.

```
$ docker run --mount src=tokens,dst=/tokens crypto11-test
2019/02/25 14:13:03 Generating key...
2019/02/25 14:13:03 Generated key: 446552704e335a5870636a69747a70364c695f3569633243496c7035494279475858454768305145344c593d0000000000000000000000000000000000000000
```

Then run it again, passing the label as an argument. You will get a slot ID warning, but that's just due to my lazy
script writing.

```
$ docker run --mount src=tokens,dst=/tokens crypto11-test 446552704e335a5870636a69747a70364c695f3569633243496c7035494279475858454768305145344c593d0000000000000000000000000000000000000000
CKR_SLOT_ID_INVALID: Slot 0 does not exist.
2019/02/25 14:13:54 Found key
```