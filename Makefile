all: build

build: 
	gcc loopFusion.c -o loopFusion 
	gcc baseLoopInterchange2.c -o baseLoopInterchange 
	gcc optLoopInterchange2.c -o optLoopInterchange
	gcc baseFusionLoop.c -o baseFusionLoop 
	gcc optFusionLoop.c -o optFusionLoop
