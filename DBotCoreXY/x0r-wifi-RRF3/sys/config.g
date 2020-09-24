; Configuration file for Duet WiFi (firmware version 3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.1.4 on Thu Sep 03 2020 13:53:08 GMT-0600 (Central Standard Time)

; General preferences
M111 S0                                            ; Debugging off
G21                                                ; Work in millimetres
G90                                                ; send absolute coordinates...
M83                                                ; ...but relative extruder moves
M669 K1                                            ; select CoreXY mode
M555 P2                                            ; Set firmware compatibility to look like Marlin
M404 N1.75 D0.6                                    ; Set nominal filament diameter to 1.75 and nozzle width to 0.4
M575 P0 B250000                                    ; Set baud rate for USB port for Octoprint
M575 P1 S1 B57600                                  ; enable support for PanelDue (Default B57600)

; Network
M550 P"ZBot"                                       ; set printer name
M551 Preprap                                       ; Set password. Use reprap for no password prompt.
M552 S1                                            ; enable network
M586 P0 S1                                         ; enable HTTP
M586 P1 S1                                         ; enable FTP
M586 P2 S0                                         ; disable Telnet

; Drives
M569 P0 S0                                         	; Drive 0 (x) goes backwards
M569 P1 S0                                         	; Drive 1 (y) goes backwards
M569 P2 S0                                         	; Drive 2 (z) goes backwards
M569 P3 S0                                         	; Drive 3 (e) goes backwards

M584 X0 Y1 Z2 E3                                   ; set drive mapping
M350 X16 Y16 Z16 E16 I1                            ; configure microstepping with interpolation
M92 X200 Y200 Z6400 E800               				; set steps per mm

M906 X2000 Y2000 Z2000 E1400 I20                    ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                            ; Set idle timeout
M98 P"0:/sys/CurrentsNormal.g"            		; set X Y Z E motors to 75%

; Axis Limits
M208 X-10 Y0 Z-0.5 S1       ; set axis minima
M208 X320 Y280 Z305 S0		; set axis maxima
							; X 0 to 300 and Y 0 to 280 usable
; Endstops
M574 X1 S1 P"xstop"			; configure active-high endstop for low end on X via pin xstop
M574 Y2 S1 P"!ystop"		; configure active-low endstop for high end on Y via pin !ystop
M574 Z2 S1 P"zstop"			; configure active-high endstop for high end on Z via pin zstop

; Z-Probe
M950 S0 C"exp.heater3" ; create servo pin 0 for BLTouch
M558 P9 C"^zprobe.in" H3 F60 T12000 A10 R0.2 S0.003 B0                ; set Z probe type to bltouch and the dive height + speeds
G31 P25 X-43 Y32 Z2.2                           ; set Z probe trigger value, offset and trigger height
M557 X2:276 Y32:278 P22:20                         ; define mesh grid
M376 H6                    						; Taper off compensation over 6mm of height

; Heaters
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950     ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bedheat" T0                              ; create bed heater output on bedheat and map it to sensor 0
M307 H0 B0 S1.00                                   ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                            ; map heated bed to heater 0
M143 H0 S135                                       ; set temperature limit for heater 0 to 135C
M308 S1 P"spi.cs1" Y"rtd-max31865"                 ; configure sensor 1 as thermocouple via CS pin spi.cs1
M950 H1 C"e0heat" T1                               ; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 B0 S1.00                                   ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S300                                       ; set temperature limit for heater 1 to 300c

; Fans
M950 F0 C"fan0" Q100                               ; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 B0.5                                ; set fan 0 value. Thermostatic control is turned off
M950 F1 C"fan1" Q1000                              ; create fan 1 on pin fan1 and set its frequency
M106 P1 S1 H1 T45 B0.5                             ; set fan 1 value. Thermostatic control is turned on
M950 F2 C"fan2" Q15000                             ; create fan 2 on pin fan2 and set its frequency
M106 P2 S0.33 H1:0 T45 B0.5                        ; set fan 2 value. Thermostatic control is turned on

; Tools
M563 P0 S"Titan Aero" D0 H1 F0                     ; define tool 0
G10 P0 X0 Y0 Z0                                    ; set tool 0 axis offsets
G10 P0 R0 S0                                       ; set initial tool 0 active and standby temperatures to 0C

; SPEEDS
M203 X12000 Y12000 Z400 E6000          				; set maximum speeds (mm/min)
M201 X3000 Y3000 Z30 E3000             				; set accelerations (mm/s^2)
M204 P666 T2666								   ; set print and travel accel
M566 X777 Y777 Z30 E3000               				; set maximum instantaneous speed changes (mm/min)
M566 P0                                            ; uses jerk between all moves. yes or no.


; PRESSURE ADVANCE
M572 D0 S0.035 			                           ; set extruder 0 pressure advance. Default for PLA direct drive is 0.05 seconds, PETG 0.07

; NON-LINEAR EXTRUSION
;M592 D0 A0.1214 B0.1786                           ; set parameters for extruder drive 0

; RETRACTION
M207 S0.9 R0.0 F6000 T6000 Z0.0                    ; speeds for 64x microstepping
                                                   ; M207: Set retract length
                                                   ; Parameters
                                                   ; 	Snnn positive length to retract, in mm
                                                   ; 	Rnnn positive or negative additional length to un-retract, in mm, default zero
                                                   ; 	Fnnn retraction feedrate, in mm/min
                                                   ; 	Tnnn feedrate for un-retraction if different from retraction, mm/min (RepRapFirmware 1.16 and later only)
                                                   ; 	Znnn additional zlift/hop
                                                   ; Example: M207 S4.0 F2400 Z0.075

; FEEDRATE CONVERSIONS
                                                   ; 20mm/s = F1200
                                                   ; 35mm/s = F2100
                                                   ; 50mm/s = F3000
                                                   ; 70mm/s = F4200
                                                   ; 100mm/s = F6000
                                                   ; 120mm/s = F7200
                                                   ; 133mm/s = F8000

; ############################
; ##	10 - MISCELLANEOUS
; ############################



; POWER LOSS RECOVERY
;
M911 S21 R23 P"M913 X0 Y0 G91 M83 G1 Z3 E-1 F500"  ; Configure automatic saving on power loss



; FILAMENT RUNOUT SENSOR
;
;M591 D0 P2 C4 S1	                                 ; D0=extruder 0, P2=simple low switch, C3=E1 endstop, S1=monitor when printing

; CPU TEMP CALIBRATION
;
M912 P0 S-18.2		                                   ; MCU temperature sensor calibration offset (M112 to view current temp. Should match room temp.)

; DYNAMIC ACCELERATION
;
;M593 F60  		                                      ; Attempt to vary acceleration to cancel ringing at specified frequency in Hz

; LOAD CONFIG-OVERRIDE.G
;
M501			                                            ; Load saved parameters from non-volatile memory

; BLTOUCH PREP
;
G4 S1
M280 P3 S160 I1 	                                  ; Alarm Release and Push-Pin UP just in case it's in alarm and deployed
G4 S1
M402			                                           ; Retract probe just in case it's down

; Miscellaneous
T0                                                 ; select first tool

; Startup Tune
;
G4 S8
M98 P"0:/macros/Musical Tunes/Startup.g"
G4 S1


