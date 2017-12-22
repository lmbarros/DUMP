#
# DUMP: Dump of Unsorted Morsels for Programmers
# By Leandro Motta Barros
#

plates: tangle
	cd generated_sources && for f in *.cpp; do \
		executable=`basename $$f .cpp`; \
		g++ -Wall -o $$executable $$f; \
	done

tangle:
	rm -rf generated_sources && halp README.md

clean:
	rm -rf generated_sources
