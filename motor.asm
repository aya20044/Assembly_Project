.model small
.data 

;======greeting======;
 greeting db 09h,20h,"Welcome to Motor Caf",8Ah,": Fueling Your Journey with Power",20h,"$" ; 09h for tap-20h for space-8Ah for letter e in French 
 
;=====motors list====;
 vehicles db 20h,"Vehicles",20h,19h,19h,0Dh,0Ah,"$" ; 19h for arrow-0Dh,0Ah for new line
 v1 db 20h,20h,"a. Car",0Dh,0Ah,"$"
 v2 db 20h,20h,"b. Taxi",0Dh,0Ah,"$"
 v3 db 20h,20h,"c. Small Truck",0Dh,0Ah,"$"
 v4 db 20h,20h,"d. Medium-Duty Truck",0Dh,0Ah,"$" 
 v5 db 20h,20h,"e. Heavy-Duty Truck",0Dh,0Ah,"$"
 v6 db 20h,20h,"f. Microbus",0Dh,0Ah,"$"
 v7 db 20h,20h,"g. Bus",0Dh,0Ah,"$"
 v8 db 20h,20h,"h. Three-Wheeler",0Dh,0Ah,"$"
 v9 db 20h,20h,"i. Vespa",0Dh,0Ah,"$"
 v10 db 20h,20h,"j. Motorcycle",0Dh,0Ah,"$"   
 
;=display constants==;
 newLine db 0Dh,0Ah,"$"
 arrow db 20h,20h,10h,"$"
 currency db 20h,"Egyption Pounds","$"
 hash db 23h,20h,"$" 
 
;==choose a vehicle==;
 typeMsg db 20h,"Type the Letter Matching Your Vehicle Type:",20h,"$" 
 vCar db 20h,"Alright! Let's fuel up your Car",0Dh,0Ah,"$"
 vTaxi db 20h,"Alright! Let's fuel up your Taxi",0Dh,0Ah,"$"
 vSmallTruck db 20h,"Alright! Let's fuel up your Small Truck",0Dh,0Ah,"$"
 vMediumTruck db 20h,"Alright! Let's fuel up your Medium-Duty Truck",0Dh,0Ah,"$"
 vHeavyTruck db 20h,"Alright! Let's fuel up your Heavy-Duty Truck",0Dh,0Ah,"$"
 vBus db 20h,"Alright! Let's fuel up your Bus",0Dh,0Ah,"$"
 vMicrobus db 20h,"Alright! Let's fuel up your Microbus",0Dh,0Ah,"$"
 vThreeWheeler db 20h,"Alright! Let's fuel up your Three-Wheeler",0Dh,0Ah,"$"
 vVespa db 20h,"Alright! Let's fuel up your Vespa",0Dh,0Ah,"$"
 vMotorcycle db 20h,"Alright! Let's fuel up your Motorcycle",0Dh,0Ah,"$"
  
;===fueling prompts==;
 showOptions db 20h,"Press any key to show your vehicle's fuel options",20h,"$"
 fuelList db 20h,"Your vehicle works with:",20h,0Dh,0Ah,"$"  
  
;=selection numbers==;
 one db 20h,20h,"1.","$"
 two db 20h,20h,"2.","$" 
 three db 20h,20h,"3.","$" 
 
;=====fuel names=====;
 diesel db 20h,"Diesel    [13 EP per Liter]",0Dh,0Ah,"$"
 petrol80 db 20h,"Petrol 80 [13 EP per Liter]",0Dh,0Ah,"$"
 petrol92 db 20h,"Petrol 92 [15 EP per Liter]",0Dh,0Ah,"$"
 petrol95 db 20h,"Petrol 95 [17 EP per Liter]",0Dh,0Ah,"$" 
 
;===determine fuel===;
 whichFuel db 20h,"Input the number corresponding to the fuel you need:",20h,"$"
 
;====tank capacity===;
 tankCapacityCar db 20h,"Tank Capacity for Car is: 60L",0Dh,0Ah,"$"
 tankCapacityTaxi db 20h,"Tank Capacity for Taxi is: 70L",0Dh,0Ah,"$"
 tankCapacitySmallTruck db 20h,"Tank Capacity for Small Truck is: 60L",0Dh,0Ah,"$"
 tankCapacityMediumTruck db 20h,"Tank Capacity for Medium-duty Truck is: 120L",0Dh,0Ah,"$"
 tankCapacityHeavyTruck db 20h,"Tank Capacity for Heavy-duty Truck is: 1000L",0Dh,0Ah,"$"
 tankCapacityMicrobus db 20h,"Tank Capacity for Microbus is: 60L",0Dh,0Ah,"$"
 tankCapacityBus db 20h,"Tank Capacity for Bus is: 300L",0Dh,0Ah,"$"
 tankCapacityThreeWheeler db 20h,"Tank Capacity for Three-Wheeler is: 7L",0Dh,0Ah,"$"
 tankCapacityVespa db 20h,"Tank Capacity for Vespa is: 7L",0Dh,0Ah,"$"
 tankCapacityMotorcycle db 20h,"Tank Capacity for Motorcycle is: 7L",0Dh,0Ah,"$"

 
;===program status===;      
 exist db 20h,"1.Try again",0Dh,0Ah,"$"
 leave db 20h,"2.Exit",20h,"$"
  
;=determine quantity=;  
 fuelAmount db 20h,"Specify the amount of liters to fill: ",20h,"$" 
 
;===string buffer====;
  string dw 6
         dw ?
         dw 6 dup(0000h)
         
;=program variables==;
 vType db ?
 fuelType db ?
 liters dw 0000h
 cost dw 0000h
 ten dw 000Ah
 divisor dw 2710h
 leftSide db 00h 
 digit db 00h
 
;=====fuel prices====;
 priceDiesel dw 000Dh
 pricePtrl80 dw 000Dh
 pricePtrl92 dw 000Fh
 pricePtrl95 dw 0011h
 
;====cost prompt=====;
payment db 20h,"The Total Cost = ","$" 

;====progress bar====;
 fuelProgress db 20h,"Number of Liters Completed: [",20h,"$" 
 pracket db "]","$"
 
;====fuel finish=====;
finish db 20h,"Let's hit the road",20h,"$"
 
 .code
 
  MAIN PROC FAR 
   .STARTUP
   
   ;display the welcome message to the user 
   call printGreeting
   ;draw a smile face
   call emoji 
   ;press any key from keyboard to continue
   call readSilent 
   ;print a new line
   call endl
   call endl 
   ;display motors list
   call printMotors 
   ;press any key from keyboard to continue 
   call readSilent 
   ;enter the user vehicle type
   TRY_AGAIN:
    lea dx,typeMsg
    call printStr
    call readChar         
    mov  vType,al ;store the value from al register to vType variable, saving it from lost     
    call endl            
    call endl 
    
   
   ;compare between all vehicles and user enterd choice then move the program control to the desired label
    cmp vType,'a'
   je CAR_CHOICE   
    cmp vType,'b'
   je TAXI_CHOICE
    cmp vType,'c'
   je SMALLTRUCK_CHOICE
    cmp vType,'d'
   je MEDIUMTRUCH_CHOICE
    cmp vType,'e'
   je HEAVYTRUCK_CHOICE
    cmp vType,'f'
   je MICROBUS_CHOICE
    cmp vType,'g'
   je BUS_CHOICE
    cmp vType,'h'
   je THREEWHEELER_CHOICE
    cmp vType,'i'
   je VESPA_CHOICE
    cmp vType,'j'
   je MOTORCYCLE_CHOICE 
   ;if the user entered unexcepected type move the program control to invalid choice label to manage this case
   jne INVALID_CHOICE
                      
                      
;--------labels section--------
                   
 CAR_CHOICE:
  call car
  call fueling
  lea dx,one
  call printStr
  call printPetrol80
  lea dx,two
  call printStr
  call printPetrol92
  lea dx,three
  call printStr
  call printPetrol95
  call readSilent
  call endl
  call selectFuel 
  call endl
  lea dx,tankCapacityCar
  call printStr
  call readSilent
  call endl
   cmp fuelType,'1'
  je calcPtrl80
   cmp fuelType,'2'
  je calcPtrl92
   cmp fuelType,'3'
  je calcPtrl95
  ;-------
                
 TAXI_CHOICE:
  call taxi 
  call fueling
  call printArrow
  call printDiesel
  call endl 
  call readSilent 
  lea dx,tankCapacityTaxi
  call printStr
  call readSilent
  call endl
  call calcDiesel
  ;------- 
          
 SMALLTRUCK_CHOICE:
  call smallTruck 
  call fueling
  call printArrow
  call printDiesel
  call endl 
  call readSilent
  lea dx,tankCapacitySmallTruck 
  call printStr
  call readSilent
  call endl
  call calcDiesel
  ;------- 
         
 MEDIUMTRUCH_CHOICE:
  call mediumTruck 
  call fueling
  call printArrow
  call printDiesel
  call readSilent 
  call endl
  lea dx,tankCapacityMediumTruck
  call printStr
  call readSilent
  call endl
  call calcDiesel
  ;-------
      
 HEAVYTRUCK_CHOICE:
  call heavyTruck
  call fueling
  call printArrow
  call printDiesel
  call readSilent
  call endl 
  lea dx,tankCapacityHeavyTruck
  call printStr
  call readSilent
  call endl
  call calcDiesel
  ;-------
     
 MICROBUS_CHOICE:
  call microbus
  call fueling
  lea dx,one
  call printStr
  call printPetrol95
  lea dx,two
  call printStr
  call printDiesel
  call readSilent
  call endl 
  call selectFuel 
  call endl 
  lea dx,tankCapacityMicrobus
  call printStr 
  call readSilent 
  call endl
   cmp fuelType,'1'
  je calcPtrl95
   cmp fuelType,'2'
  je calcDiesel
  ;-------
             
 BUS_CHOICE:
  call bus  
  call fueling
  lea dx,one
  call printStr
  call printPetrol95
  lea dx,two
  call printStr
  call printDiesel
  call readSilent
  call endl
  call selectFuel 
  call readSilent
  call endl
  lea dx,tankCapacityBus 
  call printStr 
  call readSilent
  call endl
   cmp fuelType,'1'
  je calcPtrl95
   cmp fuelType,'2'
  je calcDiesel
  ;-------
                   
 THREEWHEELER_CHOICE:
  call threeWheeler
  call fueling
  call printArrow
  call printPetrol80
  call readSilent
  call endl 
  lea dx,tankCapacityThreeWheeler  
  call printStr 
  call readSilent
  call endl
  call calcPtrl80
  ;-------
          
 VESPA_CHOICE:
  call vespa 
  call fueling
  call printArrow
  call printPetrol80
  call readSilent
  call endl
  lea dx,tankCapacityVespa
  call printStr 
  call readSilent
  call endl
  call calcPtrl80
  ;-------
           
 MOTORCYCLE_CHOICE:
  call motorcycle
  call fueling
  call printArrow
  call printPetrol92
  call readSilent 
  call endl
  lea dx, tankCapacityMotorcycle
  call printStr 
  call readSilent
  call endl
  call calcPtrl92
  ;-------
      
 INVALID_CHOICE:
  lea dx,exist
  call printStr
  call endl
  lea dx,leave
  call printStr
  call readChar
  cmp al,'1'
  call endl
  je TRY_AGAIN
  jne EXIT_LABEL
  ;------- 
  
 CURRENCY_LABEL:
  lea dx,currency
  call printStr
  call endl
  call endl
  ;-------
   
 PROGRESS_BAR:
  lea dx,fuelProgress
  call printStr 
  call fuelAction
  lea dx,pracket
  call printStr
  call endl
  call endl
  lea dx,finish
  call printStr
  call emoji
  ;-------   
       
 EXIT_LABEL:   
  .EXIT 
     
  MAIN ENDP
 
;-----procedures section-------

;==print string==;
 printStr proc near   
  mov ah,09h
  int 21h 
  ret
 printStr endp
 
;=read character=;
 readChar proc near
  mov ah,01h
  int 21h ; char stored in al register
  ret
 readChar endp

;=read silent====;
 readSilent proc near
  mov ah,00h
  int 16h ; read a character with no echo
  ret
 readSilent endp
 
;===new line===;
 endl proc near
  lea dx,newLine
  call printStr
  ret
 endl endp 
 
;=====emoji======;
 emoji proc near
  mov dx,0000h ; insure that dx clean register has only zeros
  mov dl,01h   ; hexa value for emoji
  mov ah,02h   ; to print the emoji using 02h not 09h as in the printStr function
  int 21h 
  mov dx,0000h
  mov dl,20h   ; 20h for printing a space 
  mov ah,02h
  int 21h
  ret
 emoji endp
 
;=print greeting=;
 printGreeting proc near
  lea dx,greeting
  call printStr
  ret
 printGreeting endp
 
;=display motors=;
 printMotors proc near
  lea dx,vehicles
  call printStr
  call endl
  lea dx,v1
  call printStr
  lea dx,v2
  call printStr
  lea dx,v3
  call printStr
  lea dx,v4
  call printStr
  lea dx,v5
  call printStr
  lea dx,v6
  call printStr
  lea dx,v7
  call printStr
  lea dx,v8
  call printStr
  lea dx,v9
  call printStr
  lea dx,v10
  call printStr
  call endl
  ret  
 printMotors endp
 
;=======car======;
 car proc near
  lea dx, vCar
  call printStr
  call endl
  ret
 car endp 

;======taxi======;
 taxi proc near
  lea dx, vTaxi 
  call printStr
  call endl
  ret
 taxi endp 
 
;===small truck==;
 smallTruck proc near
  lea dx, vSmallTruck 
  call printStr
  call endl
  ret
 smallTruck endp
 
;==medium truck==;
 mediumTruck proc near
  lea dx,vMediumTruck
  call printStr
  call endl
  ret
 mediumTruck endp
 
;===heavy truck==;
 heavyTruck proc near
  lea dx,vHeavyTruck 
  call printStr
  call endl
  ret
 heavyTruck endp
 
;====microbus====;
 microbus proc near
  lea dx,vMicrobus
  call printStr
  call endl
  ret
 microbus endp

;=======bus======;
 bus proc near
  lea dx,vBus 
  call printStr
  call endl
  ret
 bus endp 
 
;==three wheeler=;
 threeWheeler proc near
  lea dx,vThreeWheeler 
  call printStr
  call endl
  ret
 threeWheeler endp 
 
;=====vespa======;
 vespa proc near
  lea dx,vVespa
  call printStr
  call endl
  ret
 vespa endp
 
;====mototcycle==;
 motorcycle proc near
  lea dx,vMotorcycle 
  call printStr
  call endl
  ret
 motorcycle endp
 
;=fueling begins=; 
 fueling proc near  
  lea dx,showOptions
  call printStr
  call readSilent
  call endl 
  call endl
  lea dx,fuelList
  call printStr
  call endl
  ret
 fueling endp
 
;==print diesel==;
 printDiesel proc near
  lea dx,diesel
  call printStr
  ret
 printDiesel endp 
 
;=print petrol80=;
 printPetrol80 proc near
  lea dx,petrol80
  call printStr
  ret
 printPetrol80 endp 
 
;==printPetrol92=;
 printPetrol92 proc near
  lea dx,petrol92
  call printStr
  ret
 printPetrol92 endp  
 
;==printPetrol95=;
 printPetrol95 proc near
  lea dx,petrol95
  call printStr
  ret
 printPetrol95 endp

;=====arrow======;
 ; vehicle with only one fuel type,prints fuel with arrow instead of ordered list 
 printArrow proc near
  lea dx,arrow
  call printStr
  ret
 printArrow endp
 
;===select fuel==;
 selectFuel proc near
  lea dx,whichFuel
  call printStr
  call readChar
  mov fuelType,al
  call endl
  ret
 selectFuel endp 
 
;---calculate cost section---- 

;=====diesel=====;
 calcDiesel proc near
  lea dx,fuelAmount
  call printStr
 ; read the input
  call readLiters
  
 ; convert the string into integer
  mov si,offset string 
  mov bx,[si+1] ; load the length of the string into bx
  mov bh,00h    ; prevent the bh holding unnecessary value that corrupt the program
  add si,2h     ; access the first element of the string
   
  CONVERT1: 
   cmp bx,0000h
   je CALC1
   mov ax,liters
   mul ten 
   mov liters,ax
   mov cx,[si]
   mov ch,00h
   sub cl,30h
   add liters,cx
   inc si 
   dec bx 
   jmp CONVERT1 ; now the integer number stored in liters variable
   
  ; perform calculation(#liters*diesel price)
  CALC1:
   mov ax,priceDiesel
   mul liters ; the result stored in ax
   mov cost,ax 
   call endl
   call endl      
   lea dx,payment
   call printStr
        
  ; print the cost on the screen
   call costOnScreen
   ret
 calcDiesel endp
 
;===petrol 80====;
 calcPtrl80 proc near
  lea dx,fuelAmount
  call printStr
 ; read the input
  call readLiters
 ; convert the string into integer
  mov si,offset string 
  mov bx,[si+1] ; load the length of the string into bx
  mov bh,00h    ; prevent the bh holding unnecessary value that corrupt the program
  add si,2h     ; access the first element of the string
   
  CONVERT2: 
   cmp bx,0000h
   je CALC2
   mov ax,liters
   mul ten 
   mov liters,ax
   mov cx,[si]
   mov ch,00h
   sub cl,30h
   add liters,cx
   inc si 
   dec bx 
   jmp CONVERT2 ; now the integer number stored in liters variable
   
  ; perform calculation(#liters*diesel price)
  CALC2:
   mov ax,pricePtrl80
   mul liters ; the result stored in ax
   mov cost,ax 
   call endl
   call endl      
   lea dx,payment
   call printStr
        
  ; print the cost on the screen
   call costOnScreen
  ret
 calcPtrl80 endp
 
;====petrol 92===;
 calcPtrl92 proc near
  lea dx,fuelAmount
  call printStr
 ; read the input
  call readLiters
 ; convert the string into integer
  mov si,offset string 
  mov bx,[si+1] ; load the length of the string into bx
  mov bh,00h    ; prevent the bh holding unnecessary value that corrupt the program
  add si,2h     ; access the first element of the string
   
  CONVERT3: 
   cmp bx,0000h
   je CALC3
   mov ax,liters
   mul ten 
   mov liters,ax
   mov cx,[si]
   mov ch,00h
   sub cl,30h
   add liters,cx
   inc si 
   dec bx 
   jmp CONVERT3 ; now the integer number stored in liters variable
   
  ; perform calculation(#liters*diesel price)
  CALC3:
   mov ax,pricePtrl92
   mul liters ; the result stored in ax
   mov cost,ax 
   call endl
   call endl      
   lea dx,payment
   call printStr
        
  ; print the cost on the screen
  call costOnScreen
  ret
  calcPtrl92 endp
 
;====petrol 95===; 
 calcPtrl95 proc near
  lea dx,fuelAmount
  call printStr
 ; take #liters
  call readLiters ; the input entered from the keyboard as string
  
 ; convert the string into integer to be able perform calculations
  mov si,offset string 
  mov bx,[si+1] ; load the length of the string into bx
  mov bh,00h    ; prevent the bh holding unnecessary value that corrupt the program
  add si,2h     ; access the first element of the string
   
  CONVERT4: 
   cmp bx,0000h
   je CALC4
   mov ax,liters
   mul ten 
   mov liters,ax
   mov cx,[si]
   mov ch,00h
   sub cl,30h
   add liters,cx
   inc si 
   dec bx 
   jmp CONVERT4 ; now the integer number stored in liters variable
   
  ; perform calculation(#liters*diesel price)
  CALC4:
   mov ax,pricePtrl95
   mul liters ; the result stored in ax
   mov cost,ax 
   call endl
   call endl      
   lea dx,payment
   call printStr
        
  ; print the cost on the screen
   call costOnScreen
  calcPtrl95 endp
   
;=read string buffer=;
 readLiters proc near
  lea dx,string
  mov ah,0Ah
  int 21h  
  ret
 readLiters endp 
  
;===cost on screen===;
 costOnScreen  proc near    
  mov bx,0000h
  mov bl,05h
  PRINTCOST:
   cmp bl,00h
   je CURRENCY_LABEL
   mov dx,0000h ; must be clean for division 
   mov ax,cost
   div divisor  ; qoutient in ax,remainder in dx
   mov cost,dx  ; save the remainder
   add leftSide,al
   cmp leftSide,00h
   je SKIP
   add al,30h
   mov digit,al
   mov dl,digit ; to print the digit 
   mov ah,02h
   int 21h
  SKIP:
   dec bl
   mov dx,0000h ; must be clean for division
   mov ax,divisor
   div ten 
   mov divisor,ax
   jmp PRINTCOST 
  ret   
 costOnScreen  endp
 
;===fueling process==;
 fuelAction proc near
  delay:    
   mov cx, 0050h 
  delayLoop:
   nop          
   loop delayLoop 
  dec liters
  lea dx,hash
  call printStr
  call sound
  cmp liters,0000h 
  jne delay
  ret 
 fuelAction endp
 
;=====beep sound=====;
 sound proc near
  mov ah,02h
  mov dl,07h
  int 21h
  ret
 sound endp
 
END MAIN
