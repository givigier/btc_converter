FROM rust:1.32.0 as build

RUN USER=root cargo new --bin btc_converter
WORKDIR /btc_converter

COPY ./Cargo.toml ./Cargo.toml
COPY ./Cargo.lock ./Cargo.lock

RUN cargo build --release
RUN rm src/*

COPY ./src ./src

RUN rm ./target/release/deps/btc_converter*
RUN cargo build --release

FROM rust:1.32.0
COPY --from=build /btc_converter/target/release/btc_converter .

CMD ./btc_converter
