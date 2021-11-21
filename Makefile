APP=exec_scrape

.PHONY: build
build: gen $(APP)

.PHONY: run
run: build
	sudo ./$(APP)

.PHONY: gen
gen: gen_execve_bpfel.go

.PHONY: clean
clean:
	-rm $(APP)
	-rm gen*

$(APP): main.go gen_execve_bpfel.go
	CGO_ENABLED=0 go build -o $(APP)

gen_execve_bpfel.go:
	go generate

go.sum:
	go mod download github.com/cilium/ebpf
	go get github.com/cilium/ebpf/internal/unix