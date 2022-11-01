#include "Callback.h"
#include "ThisThread.h"
#include "mbed.h"
#include "stm32746g_discovery_lcd.h"
#include <cctype>
#include <cstdint>
#include <string>


DigitalOut moje(LED1);

Thread mojeVlaknoJedna; // originani nazev
Thread mojeVlaknoDva;
Thread mojeVlaknoTri;

void sleepThread(int threadNum)
{
    if(threadNum == 1)
    {
        ThisThread::sleep_for(1000ms);
        return;
    }
    else if (threadNum == 60) 
    {
        ThisThread::sleep_for(500ms);
        return;
    }
    // 120 thread
    ThisThread::sleep_for(200ms);
    return;
}

void displayTextFromThread(int threadNum)
{
    string displayText = "thread";
    displayText += to_string(threadNum);

    while(1)
    {
        BSP_LCD_DisplayStringAt(0, threadNum, (uint8_t *) &displayText, CENTER_MODE);
        sleepThread(threadNum);

        BSP_LCD_SetTextColor(LCD_COLOR_WHITE);
        BSP_LCD_DisplayStringAt(0, threadNum, (uint8_t *) &displayText, CENTER_MODE);
        ThisThread::sleep_for(500ms);
        BSP_LCD_SetTextColor(LCD_COLOR_DARKBLUE);
    }
}

void thread1()
{
    displayTextFromThread(1);
}

void thread2()
{
    displayTextFromThread(60);
}

void thread3()
{
    displayTextFromThread(120);
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
    

    while (1) 
    {
       mojeVlaknoJedna.start(callback(thread1));
       mojeVlaknoDva.start(callback(thread2));
       mojeVlaknoTri.start(callback(thread3));
       
       ThisThread::sleep_for(10000ms);
       mojeVlaknoJedna.join();
       mojeVlaknoDva.join();
       mojeVlaknoTri.join();
    }
    return 0;
}


