#CXX=clang++
CXX=g++
CXXFLAGS = -g -O0 -fPIC -ffast-math -dynamiclib $(INCLUDES)

INCLUDES = -I/Library/Java/JavaVirtualMachines/jdk1.7.0_17.jdk/Contents/Home/include \
           -I/Library/Java/JavaVirtualMachines/jdk1.7.0_17.jdk/Contents/Home/include/darwin

OBJS_SEARCH = src/c/org/apache/lucene/search/common.o \
              src/c/org/apache/lucene/search/facets.o \
              src/c/org/apache/lucene/search/NativeSearch.o \
              src/c/org/apache/lucene/search/BooleanQueryOnlyShould.o \
              src/c/org/apache/lucene/search/DrillSideways.o \
              src/c/org/apache/lucene/search/ExactPhraseQuery.o \
              src/c/org/apache/lucene/search/BooleanQueryShouldMustNot.o \
              src/c/org/apache/lucene/search/BooleanQueryShouldMust.o \
              src/c/org/apache/lucene/search/BooleanQueryShouldMustMustNot.o

OBJS_DIRECTORY = src/c/org/apache/lucene/store/NativeMMapDirectory.o

TARGET_SEARCH = libNativeSearch.jnilib
TARGET_DIRECTORY = libNativeMMapDirectory.jnilib

.PHONY: all
.DEFAULT: all
all: $(TARGET_SEARCH) $(TARGET_DIRECTORY)

$(TARGET_SEARCH): $(OBJS_SEARCH)
	$(CXX) -dynamiclib -o $(TARGET_SEARCH) $(OBJS_SEARCH)

$(TARGET_DIRECTORY): $(OBJS_DIRECTORY)
	$(CXX) -dynamiclib -o $(TARGET_DIRECTORY) $(OBJS_DIRECTORY)

clean:
	rm -f $(OBJS_SEARCH) $(OBJS_DIRECTORY) $(TARGET_SEARCH) $(TARGET_DIRECTORY)
