SRC_PATH_C	= src/c
SRC_PATH_J	= src/java
BUILD_PATH_C	= build/c
BUILD_PATH_J	= build/java
SRCS_C	= $(SRC_PATH_C)/*.c
SRCS_J	= $(SRC_PATH_J)/jnt/scimark2/commandline.java
EXEC_C	= $(BUILD_PATH_C)/scimark2
EXEC_J	= $(BUILD_PATH_J)/jnt/scimark2/commandline.class

CC	= gcc
CFLAGS	= -O3
LDFLAGS	= -static -lm

.PHONY: all
all: c java

.PHONY: clean
clean: clean_c clean_java

.PHONY: c
c: $(EXEC_C)
	$(EXEC_C)
	$(EXEC_C) -large

.PHONY: build_c
build_c: $(EXEC_C)

$(EXEC_C): $(BUILD_PATH_C)
	$(CC) $(CFLAGS) -o $(EXEC_C) $(SRCS_C) $(LDFLAGS)

$(BUILD_PATH_C):
	mkdir -p $(BUILD_PATH_C)

.PHONY: clean_c
clean_c:
	rm -rf $(BUILD_PATH_C)

.PHONY: java
java: $(EXEC_J)
	java -classpath $(BUILD_PATH_J) jnt.scimark2.commandline
	java -classpath $(BUILD_PATH_J) jnt.scimark2.commandline -large

.PHONY: build_java
build_java: $(EXEC_J)

$(EXEC_J): $(BUILD_PATH_J)
	javac -sourcepath $(SRC_PATH_J) -d $(BUILD_PATH_J) $(SRCS_J)

$(BUILD_PATH_J):
	mkdir -p $(BUILD_PATH_J)

.PHONY: clean_java
clean_java:
	rm -rf $(BUILD_PATH_J)

