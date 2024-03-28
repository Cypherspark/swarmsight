FROM golang:1.17-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM alpine:latest  

WORKDIR /root/

COPY --from=builder /app/main .
COPY --from=builder /app/services.yaml .
COPY --from=builder /app/prometheus.tpl .

CMD ["./main"]