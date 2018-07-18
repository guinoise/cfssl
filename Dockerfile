FROM cfssl/cfssl

ENV CFSSL_CA_HOST=example.localnet \
    CFSSL_CA_ALGO=ecdsa \
    CFSSL_CA_KEY_SIZE=256 \
    CFSSL_CA_COUNTRY="CA" \
    CFSSL_CA_STATE="Quebec" \
    CFSSL_CA_CITY="Montreal" \
    CFSSL_CA_ORGANIZATION="Internet Widgets, LLC" \
    CFSSL_CA_ORGANIZATIONAL_UNIT="Certificate Authority" \
    CFSSL_CA_POLICY_FILE=/etc/cfssl/data/ca_policy.json \
    CFSSL_ADDRESS=127.0.0.1

RUN go get bitbucket.org/liamstask/goose/cmd/goose

COPY scripts /scripts

VOLUME /etc/cfssl/data
WORKDIR /etc/cfssl/data

ENTRYPOINT []
CMD [ "/scripts/start-cfssl" ]

#USER nobody
