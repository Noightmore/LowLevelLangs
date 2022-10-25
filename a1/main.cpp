#include "ThisThread.h"
#include "mbed.h"
#include "stm32746g_discovery_lcd.h"
#include <cctype>
#include <string>


DigitalOut morseLed(LED1);

void longBeep()
{
    morseLed = 1;
    ThisThread::sleep_for(600ms);
    morseLed = 0;
    ThisThread::sleep_for(100ms);
}

void shortBeep()
{
    morseLed = 1;
    ThisThread::sleep_for(200ms);
    morseLed = 0;
    ThisThread::sleep_for(100ms);
}

void waitStop()
{
    ThisThread::sleep_for(1000ms);
}

int text2morse(string morse)
{
    int charIn = 0;
    
    for (int i = 0; i < morse.length(); i++) 
    {
        if (morse[i] == '.') 
        {
            charIn = 1;
        } 
        else if (morse[i] == '-')
        {
            charIn= 2;
        } 
        else
        {
            charIn = 3;
        }
        
        switch(charIn) 
        {
            case 1:
                shortBeep();
                break;
            case 2:
                longBeep();
                break;
            default:
                waitStop();
                break;
        }
    }
    return 0;
}

int main()
{
    BSP_LCD_Init();
    BSP_LCD_LayerDefaultInit(LTDC_ACTIVE_LAYER, LCD_FB_START_ADDRESS);
    BSP_LCD_SelectLayer(LTDC_ACTIVE_LAYER);
    BSP_LCD_Clear(LCD_COLOR_BLACK);
    BSP_LCD_Clear(LCD_COLOR_BLACK);
    BSP_LCD_SetFont(&LCD_DEFAULT_FONT);
    BSP_LCD_SetBackColor(LCD_COLOR_WHITE);
    BSP_LCD_SetTextColor(LCD_COLOR_DARKBLUE);
    
    BSP_LCD_DisplayStringAt(0, 1, (uint8_t *)"morse 1 demo", CENTER_MODE);

    string myString ="-.. . ...- .. -. / -.- .- -. . -.- / .... .- - . .--- / -- .- -- .--. .-..";

    while (1) 
    {
       text2morse(myString);
    }
    return 0;
}


