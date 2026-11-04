ARG BUILD_FROM
FROM $BUILD_FROM

ARG ARCANE_AGENT_VERSION=2.17.3
ARG BUILD_ARCH

COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /
RUN apk add --no-cache curl \
	&& case "${BUILD_ARCH}" in \
		aarch64) ARCANE_ARCH=arm64 ;; \
		amd64) ARCANE_ARCH=amd64 ;; \
		*) echo "Unsupported build architecture: ${BUILD_ARCH}" >&2; exit 1 ;; \
	esac \
	&& curl -fsSL "https://github.com/getarcaneapp/arcane/releases/download/v${ARCANE_AGENT_VERSION}/arcane-agent_linux_${ARCANE_ARCH}" -o /arcane-agent \
	&& chmod +x /arcane-agent

CMD [ "/run.sh" ]
