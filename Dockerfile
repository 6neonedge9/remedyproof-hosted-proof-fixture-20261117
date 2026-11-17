FROM scratch
COPY --chmod=0555 serve /serve
USER 65534:65534
EXPOSE 8080
ENTRYPOINT ["/serve"]
