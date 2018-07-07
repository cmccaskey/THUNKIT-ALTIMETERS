	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	SPITransferUSI
	.type	SPITransferUSI, @function
SPITransferUSI:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0xf,r24
	ldi r24,lo8(16)
	ldi r25,0
.L2:
	in r18,0xd
	ori r18,lo8(3)
	out 0xd,r18
	sbiw r24,1
	brne .L2
	in r24,0xf
	ret
	.size	SPITransferUSI, .-SPITransferUSI
.global	SPI_RW_8
	.type	SPI_RW_8, @function
SPI_RW_8:
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	cbi 0x18,3
	std Y+1,r22
	rcall SPITransferUSI
	ldd r22,Y+1
	mov r24,r22
	rcall SPITransferUSI
	sbi 0x18,3
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	SPI_RW_8, .-SPI_RW_8
.global	BMP_Burst_Read_16
	.type	BMP_Burst_Read_16, @function
BMP_Burst_Read_16:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	cbi 0x18,3
	rcall SPITransferUSI
	ldi r24,0
	rcall SPITransferUSI
	ldi r24,0
	rcall SPITransferUSI
	mov r28,r24
	ldi r24,0
	rcall SPITransferUSI
	mov r18,r24
	lsl r24
	sbc r19,r19
	sbi 0x18,3
	mov r19,r18
	clr r18
	mov r24,r28
	lsl r28
	sbc r25,r25
	or r24,r18
	or r25,r19
/* epilogue start */
	pop r28
	ret
	.size	BMP_Burst_Read_16, .-BMP_Burst_Read_16
.global	BMP_Set_Calib_Vars
	.type	BMP_Set_Calib_Vars, @function
BMP_Set_Calib_Vars:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-120)
	rcall BMP_Burst_Read_16
	sts dig_T1+1,r25
	sts dig_T1,r24
	ldi r24,lo8(-118)
	rcall BMP_Burst_Read_16
	sts dig_T2+1,r25
	sts dig_T2,r24
	ldi r24,lo8(-116)
	rcall BMP_Burst_Read_16
	sts dig_T3+1,r25
	sts dig_T3,r24
	ldi r24,lo8(-114)
	rcall BMP_Burst_Read_16
	sts dig_P1+1,r25
	sts dig_P1,r24
	ldi r24,lo8(-112)
	rcall BMP_Burst_Read_16
	sts dig_P2+1,r25
	sts dig_P2,r24
	ldi r24,lo8(-110)
	rcall BMP_Burst_Read_16
	sts dig_P3+1,r25
	sts dig_P3,r24
	ldi r24,lo8(-108)
	rcall BMP_Burst_Read_16
	sts dig_P4+1,r25
	sts dig_P4,r24
	ldi r24,lo8(-106)
	rcall BMP_Burst_Read_16
	sts dig_P5+1,r25
	sts dig_P5,r24
	ldi r24,lo8(-104)
	rcall BMP_Burst_Read_16
	sts dig_P6+1,r25
	sts dig_P6,r24
	ldi r24,lo8(-102)
	rcall BMP_Burst_Read_16
	sts dig_P7+1,r25
	sts dig_P7,r24
	ldi r24,lo8(-100)
	rcall BMP_Burst_Read_16
	sts dig_P8+1,r25
	sts dig_P8,r24
	ldi r24,lo8(-98)
	rcall BMP_Burst_Read_16
	sts dig_P9+1,r25
	sts dig_P9,r24
	ret
	.size	BMP_Set_Calib_Vars, .-BMP_Set_Calib_Vars
.global	BMP_Normal_Mode
	.type	BMP_Normal_Mode, @function
BMP_Normal_Mode:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(87)
	ldi r24,lo8(116)
	rcall SPI_RW_8
	ldi r22,lo8(16)
	ldi r24,lo8(117)
	rjmp SPI_RW_8
	.size	BMP_Normal_Mode, .-BMP_Normal_Mode
.global	SPI_Transfer
	.type	SPI_Transfer, @function
SPI_Transfer:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rjmp SPITransferUSI
	.size	SPI_Transfer, .-SPI_Transfer
.global	BMP_Burst_Read_20
	.type	BMP_Burst_Read_20, @function
BMP_Burst_Read_20:
	push r12
	push r13
	push r14
	push r15
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	cbi 0x18,3
	ori r24,lo8(-128)
	rcall SPITransferUSI
	ldi r24,0
	rcall SPITransferUSI
	mov r12,r24
	lsl r24
	sbc r13,r13
	sbc r14,r14
	sbc r15,r15
	mov r15,r14
	mov r14,r13
	mov r13,r12
	clr r12
	ldi r24,0
	rcall SPITransferUSI
	mov r20,r24
	lsl r24
	sbc r21,r21
	sbc r22,r22
	sbc r23,r23
	movw r26,r14
	movw r24,r12
	or r24,r20
	or r25,r21
	or r26,r22
	or r27,r23
	clr r12
	mov r13,r24
	mov r14,r25
	mov r15,r26
	ldi r24,0
	rcall SPITransferUSI
	mov r20,r24
	lsl r24
	sbc r21,r21
	sbc r22,r22
	sbc r23,r23
	movw r26,r14
	movw r24,r12
	or r24,r20
	or r25,r21
	or r26,r22
	or r27,r23
	sbi 0x18,3
	movw r22,r24
	movw r24,r26
	ldi r19,4
	1:
	asr r25
	ror r24
	ror r23
	ror r22
	dec r19
	brne 1b
/* epilogue start */
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	BMP_Burst_Read_20, .-BMP_Burst_Read_20
.global	BMP_Temperature
	.type	BMP_Temperature, @function
BMP_Temperature:
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
/* prologue: function */
/* frame size = 0 */
/* stack size = 12 */
.L__stack_usage = 12
	ldi r24,lo8(-6)
	rcall BMP_Burst_Read_20
	lds r8,dig_T1
	lds r9,dig_T1+1
	mov r10,__zero_reg__
	mov r11,__zero_reg__
	movw r12,r22
	movw r14,r24
	ldi r18,4
	1:
	asr r15
	ror r14
	ror r13
	ror r12
	dec r18
	brne 1b
	sub r12,r8
	sbc r13,r9
	sbc r14,r10
	sbc r15,r11
	movw r26,r24
	movw r24,r22
	ldi r19,3
	1:
	asr r27
	ror r26
	ror r25
	ror r24
	dec r19
	brne 1b
	lsl r8
	rol r9
	rol r10
	rol r11
	movw r22,r24
	movw r24,r26
	sub r22,r8
	sbc r23,r9
	sbc r24,r10
	sbc r25,r11
	lds r18,dig_T2
	lds r19,dig_T2+1
	mov __tmp_reg__,r19
	lsl r0
	sbc r20,r20
	sbc r21,r21
	rcall __mulsidi3
	movw r4,r18
	movw r6,r20
	ldi r21,11
	1:
	asr r7
	ror r6
	ror r5
	ror r4
	dec r21
	brne 1b
	movw r24,r14
	movw r22,r12
	movw r20,r14
	movw r18,r12
	rcall __mulsidi3
	movw r8,r18
	movw r10,r20
	movw r24,r10
	movw r22,r8
	ldi r30,12
	1:
	asr r25
	ror r24
	ror r23
	ror r22
	dec r30
	brne 1b
	lds r18,dig_T3
	lds r19,dig_T3+1
	mov __tmp_reg__,r19
	lsl r0
	sbc r20,r20
	sbc r21,r21
	rcall __mulsidi3
	movw r8,r18
	movw r10,r20
	movw r26,r10
	movw r24,r8
	ldi r31,14
	1:
	asr r27
	ror r26
	ror r25
	ror r24
	dec r31
	brne 1b
	movw r22,r24
	movw r24,r26
	add r22,r4
	adc r23,r5
	adc r24,r6
	adc r25,r7
	sts t_fine,r22
	sts t_fine+1,r23
	sts t_fine+2,r24
	sts t_fine+3,r25
	ldi r18,lo8(5)
	ldi r19,0
	ldi r20,0
	ldi r21,0
	rcall __mulsidi3
	movw r8,r18
	movw r10,r20
	movw r26,r10
	movw r24,r8
	subi r24,-128
	sbci r25,-1
	sbci r26,-1
	sbci r27,-1
	mov r22,r25
	mov r23,r26
	mov r24,r27
	clr r25
	sbrc r24,7
	dec r25
/* epilogue start */
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	ret
	.size	BMP_Temperature, .-BMP_Temperature
.global	BMP_Pressure
	.type	BMP_Pressure, @function
BMP_Pressure:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,18
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 18 */
/* stack size = 36 */
.L__stack_usage = 36
	rcall BMP_Temperature
	ldi r24,lo8(-9)
	rcall BMP_Burst_Read_20
	movw r4,r22
	movw r6,r24
	lds r8,t_fine
	lds r9,t_fine+1
	lds r10,t_fine+2
	lds r11,t_fine+3
	asr r11
	ror r10
	ror r9
	ror r8
	ldi r16,-6
	sub r9,r16
	sbc r10,__zero_reg__
	sbc r11,__zero_reg__
	movw r20,r10
	movw r18,r8
	ldi r22,2
	1:
	asr r21
	ror r20
	ror r19
	ror r18
	dec r22
	brne 1b
	movw r24,r20
	movw r22,r18
	rcall __mulsidi3
	movw r12,r18
	movw r14,r20
	lds r16,dig_P6
	lds r17,dig_P6+1
	std Y+18,r17
	std Y+17,r16
	lds r16,dig_P5
	lds r17,dig_P5+1
	lds r2,dig_P4
	lds r3,dig_P4+1
	lds r22,dig_P3
	lds r23,dig_P3+1
	mov __tmp_reg__,r23
	lsl r0
	sbc r24,r24
	sbc r25,r25
	movw r20,r14
	movw r18,r12
	ldi r30,13
	1:
	asr r21
	ror r20
	ror r19
	ror r18
	dec r30
	brne 1b
	rcall __mulsidi3
	std Y+1,r18
	std Y+2,r19
	std Y+3,r20
	std Y+4,r21
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r20,Y+3
	ldd r21,Y+4
	ldi r31,3
	1:
	asr r21
	ror r20
	ror r19
	ror r18
	dec r31
	brne 1b
	std Y+1,r18
	std Y+2,r19
	std Y+3,r20
	std Y+4,r21
	lds r22,dig_P2
	lds r23,dig_P2+1
	mov __tmp_reg__,r23
	lsl r0
	sbc r24,r24
	sbc r25,r25
	movw r20,r10
	movw r18,r8
	rcall __mulsidi3
	std Y+9,r18
	std Y+10,r19
	std Y+11,r20
	std Y+12,r21
	ldd r24,Y+9
	ldd r25,Y+10
	ldd r26,Y+11
	ldd r27,Y+12
	asr r27
	ror r26
	ror r25
	ror r24
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r20,Y+3
	ldd r21,Y+4
	add r24,r18
	adc r25,r19
	adc r26,r20
	adc r27,r21
	ldi r19,18
	1:
	asr r27
	ror r26
	ror r25
	ror r24
	dec r19
	brne 1b
	movw r22,r24
	movw r24,r26
	subi r23,-128
	sbci r24,-1
	sbci r25,-1
	lds r18,dig_P1
	lds r19,dig_P1+1
	ldi r20,0
	ldi r21,0
	rcall __mulsidi3
	movw r24,r18
	movw r26,r20
	movw r18,r24
	movw r20,r26
	ldi r22,15
	1:
	asr r21
	ror r20
	ror r19
	ror r18
	dec r22
	brne 1b
	std Y+9,r18
	std Y+10,r19
	std Y+11,r20
	std Y+12,r21
	or r18,r19
	or r18,r20
	or r18,r21
	brne .+2
	rjmp .L16
	movw r24,r14
	movw r22,r12
	ldi r26,11
	1:
	asr r25
	ror r24
	ror r23
	ror r22
	dec r26
	brne 1b
	ldd r14,Y+17
	ldd r15,Y+18
	movw r18,r14
	lsl r15
	sbc r20,r20
	sbc r21,r21
	rcall __mulsidi3
	std Y+1,r18
	std Y+2,r19
	std Y+3,r20
	std Y+4,r21
	movw r18,r16
	lsl r17
	sbc r20,r20
	sbc r21,r21
	movw r24,r10
	movw r22,r8
	rcall __mulsidi3
	movw r8,r18
	movw r10,r20
	movw r26,r10
	movw r24,r8
	lsl r24
	rol r25
	rol r26
	rol r27
	ldd r12,Y+1
	ldd r13,Y+2
	ldd r14,Y+3
	ldd r15,Y+4
	add r12,r24
	adc r13,r25
	adc r14,r26
	adc r15,r27
	ldi r16,2
	1:
	asr r15
	ror r14
	ror r13
	ror r12
	dec r16
	brne 1b
	clr r24
	clr r25
	movw r26,r24
	sub r24,r4
	sbc r25,r5
	sbc r26,r6
	sbc r27,r7
	movw r20,r2
	lsl r3
	sbc r22,r22
	sbc r23,r23
	movw r22,r20
	clr r21
	clr r20
	add r12,r20
	adc r13,r21
	adc r14,r22
	adc r15,r23
	ldi r19,12
	1:
	asr r15
	ror r14
	ror r13
	ror r12
	dec r19
	brne 1b
	movw r22,r24
	movw r24,r26
	sub r22,r12
	sbc r23,r13
	sbc r24,r14
	sbc r25,r15
	ldi r18,lo8(53)
	ldi r19,lo8(12)
	ldi r20,0
	ldi r21,0
	rcall __umulsidi3
	movw r8,r18
	movw r10,r20
	movw r24,r10
	movw r22,r8
	subi r24,-80
	sbci r25,60
	sbrc r25,7
	rjmp .L14
	lsl r22
	rol r23
	rol r24
	rol r25
	ldd r18,Y+9
	ldd r19,Y+10
	ldd r20,Y+11
	ldd r21,Y+12
	rcall __udivmodsi4
	movw r4,r18
	movw r6,r20
	rjmp .L15
.L14:
	ldd r18,Y+9
	ldd r19,Y+10
	ldd r20,Y+11
	ldd r21,Y+12
	rcall __udivmodsi4
	movw r4,r18
	movw r6,r20
	lsl r4
	rol r5
	rol r6
	rol r7
.L15:
	movw r20,r6
	movw r18,r4
	ldi r24,3
	1:
	lsr r21
	ror r20
	ror r19
	ror r18
	dec r24
	brne 1b
	lds r24,dig_P9
	lds r25,dig_P9+1
	movw r14,r24
	lsl r25
	sbc r16,r16
	sbc r17,r17
	std Y+1,r14
	std Y+2,r15
	std Y+3,r16
	std Y+4,r17
	movw r24,r20
	movw r22,r18
	rcall __umulsidi3
	movw r8,r18
	movw r10,r20
	movw r20,r10
	movw r18,r8
	ldi r25,13
	1:
	lsr r21
	ror r20
	ror r19
	ror r18
	dec r25
	brne 1b
	ldd r22,Y+1
	ldd r23,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	rcall __mulsidi3
	movw r8,r18
	movw r10,r20
	movw r18,r10
	movw r16,r8
	ldi r20,12
	1:
	asr r19
	ror r18
	ror r17
	ror r16
	dec r20
	brne 1b
	std Y+1,r16
	std Y+2,r17
	std Y+3,r18
	std Y+4,r19
	movw r24,r6
	movw r22,r4
	ldi r21,2
	1:
	lsr r25
	ror r24
	ror r23
	ror r22
	dec r21
	brne 1b
	lds r18,dig_P8
	lds r19,dig_P8+1
	mov __tmp_reg__,r19
	lsl r0
	sbc r20,r20
	sbc r21,r21
	rcall __mulsidi3
	movw r8,r18
	movw r10,r20
	ldi r22,13
	1:
	asr r11
	ror r10
	ror r9
	ror r8
	dec r22
	brne 1b
	ldd r14,Y+1
	ldd r15,Y+2
	ldd r16,Y+3
	ldd r17,Y+4
	add r8,r14
	adc r9,r15
	adc r10,r16
	adc r11,r17
	lds r22,dig_P7
	lds r23,dig_P7+1
	movw r24,r22
	lsl r23
	sbc r26,r26
	sbc r27,r27
	add r24,r8
	adc r25,r9
	adc r26,r10
	adc r27,r11
	ldi r23,4
	1:
	asr r27
	ror r26
	ror r25
	ror r24
	dec r23
	brne 1b
	movw r22,r24
	movw r24,r26
	add r22,r4
	adc r23,r5
	adc r24,r6
	adc r25,r7
	rjmp .L13
.L16:
	ldi r22,0
	ldi r23,0
	movw r24,r22
.L13:
/* epilogue start */
	adiw r28,18
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	ret
	.size	BMP_Pressure, .-BMP_Pressure
.global	__floatunsisf
.global	__floatsisf
.global	__divsf3
.global	__addsf3
.global	__mulsf3
.global	__fixsfsi
.global	BMP_Air_Density
	.type	BMP_Air_Density, @function
BMP_Air_Density:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
/* prologue: function */
/* frame size = 0 */
/* stack size = 8 */
.L__stack_usage = 8
	rcall BMP_Temperature
	movw r8,r22
	movw r10,r24
	rcall BMP_Pressure
	rcall __floatunsisf
	movw r12,r22
	movw r14,r24
	movw r24,r10
	movw r22,r8
	rcall __floatsisf
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(-56)
	ldi r21,lo8(66)
	rcall __divsf3
	ldi r18,lo8(51)
	ldi r19,lo8(-109)
	ldi r20,lo8(-120)
	ldi r21,lo8(67)
	rcall __addsf3
	ldi r18,lo8(102)
	ldi r19,lo8(-122)
	ldi r20,lo8(-113)
	ldi r21,lo8(67)
	rcall __mulsf3
	movw r18,r22
	movw r20,r24
	movw r24,r14
	movw r22,r12
	rcall __divsf3
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(-56)
	ldi r21,lo8(66)
	rcall __mulsf3
	rcall __fixsfsi
/* epilogue start */
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
	.size	BMP_Air_Density, .-BMP_Air_Density
.global	poweri
	.type	poweri, @function
poweri:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r24
	movw r28,r22
	sbiw r28,0
	breq .L21
	lsr r23
	ror r22
	movw r24,r16
	rcall poweri
	movw r18,r24
	sbrc r28,0
	rjmp .L20
	movw r24,r18
	rjmp .L22
.L20:
	movw r24,r16
	movw r22,r18
	rcall __mulhi3
.L22:
	movw r22,r18
	rcall __mulhi3
	rjmp .L19
.L21:
	ldi r24,lo8(1)
	ldi r25,0
.L19:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	poweri, .-poweri
.global	BMP_Altitude
	.type	BMP_Altitude, @function
BMP_Altitude:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall BMP_Pressure
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	ldi r24,0
	ldi r25,0
	ret
	.size	BMP_Altitude, .-BMP_Altitude
.global	blinkAltitude
	.type	blinkAltitude, @function
blinkAltitude:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	ldi r16,0
	ldi r17,0
	ldi r28,0
	ldi r29,0
.L26:
	movw r24,r16
	rcall eeprom_read_word
	cp r28,r24
	cpc r29,r25
	brsh .L25
	movw r28,r24
.L25:
	subi r16,-2
	sbci r17,-1
	cpi r16,62
	cpc r17,__zero_reg__
	brne .L26
	sbiw r28,0
	breq .L24
	ldi r30,lo8(5)
	ldi r31,0
	ldi r16,lo8(10)
	ldi r17,0
.L31:
	movw r24,r28
	movw r22,r16
	rcall __divmodhi4
	sbiw r24,0
	breq .L33
	mov r18,r24
	rjmp .L28
.L33:
	ldi r18,lo8(10)
.L28:
	movw r24,r28
	movw r22,r16
	rcall __divmodhi4
	movw r28,r22
	ldi r24,0
	ldi r25,0
	mov __tmp_reg__,r18
	lsl r0
	sbc r19,r19
.L29:
	cp r24,r18
	cpc r25,r19
	brge .L36
	sbi 0x18,2
	ldi r20,lo8(319999)
	ldi r21,hi8(319999)
	ldi r22,hlo8(319999)
1:	subi r20,1
	sbci r21,0
	sbci r22,0
	brne 1b
	rjmp .
	nop
	cbi 0x18,2
	ldi r20,lo8(319999)
	ldi r21,hi8(319999)
	ldi r22,hlo8(319999)
1:	subi r20,1
	sbci r21,0
	sbci r22,0
	brne 1b
	rjmp .
	nop
	adiw r24,1
	rjmp .L29
.L36:
	ldi r24,lo8(2399999)
	ldi r25,hi8(2399999)
	ldi r18,hlo8(2399999)
1:	subi r24,1
	sbci r25,0
	sbci r18,0
	brne 1b
	rjmp .
	nop
	sbiw r30,1
	brne .L31
.L24:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	blinkAltitude, .-blinkAltitude
.global	__fixunssfsi
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x17
	ori r24,lo8(108)
	out 0x17,r24
	in r24,0xd
	ori r24,lo8(29)
	out 0xd,r24
	sbi 0x18,2
	sbi 0x18,3
	ldi r18,lo8(799999)
	ldi r24,hi8(799999)
	ldi r25,hlo8(799999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r22,0
	ldi r24,lo8(-48)
	rcall SPI_RW_8
.L38:
	cpi r24,lo8(88)
	breq .L54
	sbi 0x18,2
	rjmp .L38
.L54:
	cbi 0x18,2
	ldi r18,lo8(159999)
	ldi r24,hi8(159999)
	ldi r25,hlo8(159999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rcall BMP_Normal_Mode
	ldi r18,lo8(159999)
	ldi r24,hi8(159999)
	ldi r25,hlo8(159999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rcall BMP_Set_Calib_Vars
	ldi r18,lo8(7999999)
	ldi r24,hi8(7999999)
	ldi r25,hlo8(7999999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rcall BMP_Pressure
	sts BMP_Pressure_Cal+1,r23
	sts BMP_Pressure_Cal,r22
	rcall BMP_Altitude
	movw r12,r22
	movw r14,r24
	ldi r16,0
	ldi r17,0
	ldi r29,0
	ldi r28,0
.L45:
	rcall BMP_Altitude
	rcall __floatsisf
	ldi r18,0
	ldi r19,0
	ldi r20,0
	ldi r21,lo8(63)
	rcall __mulsf3
	movw r4,r22
	movw r6,r24
	movw r24,r14
	movw r22,r12
	rcall __floatunsisf
	ldi r18,0
	ldi r19,0
	ldi r20,0
	ldi r21,lo8(63)
	rcall __mulsf3
	movw r18,r22
	movw r20,r24
	movw r24,r6
	movw r22,r4
	rcall __addsf3
	rcall __fixunssfsi
	movw r4,r22
	movw r6,r24
	cpse r29,__zero_reg__
	rjmp .L40
	movw r26,r14
	movw r24,r12
	adiw r24,2
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	cp r24,r4
	cpc r25,r5
	cpc r26,r6
	cpc r27,r7
	brsh .L41
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L42:
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	movw r24,r10
	rcall eeprom_write_word
	ldi r18,2
	add r10,r18
	adc r11,__zero_reg__
	ldi r24,62
	cp r10,r24
	cpc r11,__zero_reg__
	brne .L42
	movw r22,r12
	ldi r24,0
	ldi r25,0
	rcall eeprom_write_word
	rjmp .L40
.L41:
	cpse r28,__zero_reg__
	rjmp .L46
	sbi 0x18,2
	ldi r28,lo8(1)
	rjmp .L44
.L40:
	cpi r16,62
	cpc r17,__zero_reg__
	brge .L43
	movw r22,r4
	movw r24,r16
	rcall eeprom_write_word
	subi r16,-2
	sbci r17,-1
.L43:
	tst r28
	breq .L49
	ldi r29,lo8(1)
.L46:
	cbi 0x18,2
	tst r29
	breq .L50
.L49:
	cbi 0x18,2
	ldi r29,lo8(1)
.L50:
	ldi r28,0
.L44:
	ldi r25,lo8(159999)
	ldi r18,hi8(159999)
	ldi r24,hlo8(159999)
1:	subi r25,1
	sbci r18,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	movw r14,r6
	movw r12,r4
	rjmp .L45
	.size	main, .-main
	.comm	BMP_Air_Density_Cal,4,1
	.comm	BMP_Pressure_Cal,2,1
	.comm	t_fine,4,1
	.comm	dig_P9,2,1
	.comm	dig_P8,2,1
	.comm	dig_P7,2,1
	.comm	dig_P6,2,1
	.comm	dig_P5,2,1
	.comm	dig_P4,2,1
	.comm	dig_P3,2,1
	.comm	dig_P2,2,1
	.comm	dig_T3,2,1
	.comm	dig_T2,2,1
	.comm	dig_P1,2,1
	.comm	dig_T1,2,1
	.ident	"GCC: (GNU) 4.9.2"
.global __do_clear_bss
