all: build

build: 
	gcc loopFusion.c -o loopFusion 
	gcc baseLoopInterchange2.c -o baseLoopInterchange 
	gcc optLoopInterchange2.c -o optLoopInterchange

