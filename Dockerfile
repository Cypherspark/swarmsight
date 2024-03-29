FROM golang:1.21.6-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM alpine:latest  

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/services.yaml .
COPY --from=builder /app/prometheus.tpl .

CMD ["./main"]