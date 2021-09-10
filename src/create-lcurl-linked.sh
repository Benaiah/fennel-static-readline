#!/bin/sh

cd Lua-cURLv3

ar -M <<EOM
CREATE lcurl-linked.a
ADDLIB /lib/libz.a
ADDLIB /usr/lib/libcrypto.a
ADDLIB /usr/lib/libssl.a
ADDLIB /usr/lib/libnghttp2.a
ADDLIB /usr/lib/libcurl.a
ADDLIB lcurl.a
SAVE
END
EOM

ranlib lcurl-linked.a
