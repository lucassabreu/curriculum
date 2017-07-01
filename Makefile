all: clean pt-br en
clean: clean-pt-br clean-en

DOCKER_RUN=docker run --rm -v "`pwd`:/src" -w "/src" resume-build

pdf: pdf-pt-br pdf-en
html: html-pt-br html-en

pt-br: html-pt-br pdf-pt-br
en: html-en pdf-en

build-docker-image:
	docker build -t resume-build -f Dockerfile .

pdf-pt-br: build-docker-image
	${DOCKER_RUN} ./build pt-br pdf

html-pt-br: build-docker-image
	${DOCKER_RUN} ./build pt-br html

clean-pt-br:
	rm -f "resume.pt-br.html"
	rm -f "resume.pt-br.pdf"

pdf-en: build-docker-image
	${DOCKER_RUN} ./build en pdf

html-en: build-docker-image
	${DOCKER_RUN} ./build en html

clean-en:
	rm -f "resume.en.html"
	rm -f "resume.en.pdf"

