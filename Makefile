build:
	docker build -t duliu/r-env .

rstudio:
	docker run -d -p 8787:8787 --name my_rstudio -e PASSWORD=pw duliu/r-env && \
	echo "Rstudio available at http://localhost:8787. Username: rstudio, Password: pw"

shell:
	docker exec -it -u rstudio -w /home/rstudio my_rstudio bash || docker run --rm -u rstudio -w /home/rstudio -it duliu/r-env bash

stop:
	docker stop my_rstudio