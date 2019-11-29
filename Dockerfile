FROM golang:alpine as build

# cache modules layer
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

# build app layer
COPY . .

ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go build -a -installsuffix cgo -o wio

# executable layer
FROM scratch
COPY --from=build /app/wio wio

# executable layer
ENV PORT 8080
EXPOSE $PORT
ENTRYPOINT ["./wio"]