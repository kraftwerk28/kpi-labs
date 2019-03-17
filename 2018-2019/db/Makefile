DBNAME := northwind
LABS := $(wildcard lab*/АмбросВВ_лаб*.sql)
NAMES := $(patsubst %/, %, $(dir $(LABS)))

.PHONY: lab1 lab2

lab%:# lab%/АмбросВВ_лаб%.sql
	@psql -d $(DBNAME)
