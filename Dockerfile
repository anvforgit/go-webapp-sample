FROM golang:latest
COPY . .
EXPOSE 8080
CMD [ "./go-test" ]
