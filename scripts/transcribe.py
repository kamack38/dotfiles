#!/usr/bin/python
# usage: transcribe.py <input file> [output file]
import whisper
import sys

if (len(sys.argv) < 2) :
    print("usage: transcribe.py <input file> [output file]")
    sys.exit(1)

model = whisper.load_model("base")

audio = sys.argv[1]
transcribe = model.transcribe(audio)

if (len(sys.argv) >= 3) :
    f = open(sys.argv[2], "a")
    f.write(transcribe["text"])
    f.close()
else :
    print(transcribe["text"])
