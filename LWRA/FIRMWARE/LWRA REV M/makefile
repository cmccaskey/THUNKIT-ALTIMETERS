TARGET = MAIN
SOURCE = MAIN.c

DEVICE = attiny841
HFUSE = 0xDF
LFUSE = 0xE2
EFUSE = 0xFD
CC = avr-gcc
OBJCOPY = avr-objcopy
PROGRAMMER = usbtiny
AVRDUDE = avrdude -p $(DEVICE) -c $(PROGRAMMER)
CFLAGS  = -mmcu=$(DEVICE) -Os -Wall

all:
	$(CC) -Os -mmcu=$(DEVICE) $(SOURCE) -o $(TARGET).o
	avr-objcopy -j .text -j .data -O ihex $(TARGET).o $(TARGET).hex

flash:
	$(CC) -Os -mmcu=$(DEVICE) $(SOURCE) -o $(TARGET).o
	avr-objcopy -j .text -j .data -O ihex $(TARGET).o $(TARGET).hex
	$(AVRDUDE) -B1 -e -U flash:w:$(TARGET).hex 

fuses:
	$(AVRDUDE) -U lfuse:w:LFUSE:m -U hfuse:w:HFUSE:m -U efuse:w:EFUSE:m

clean:
	@rm $(TARGET).o $(TARGET).hex

