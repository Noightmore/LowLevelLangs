#ifndef SYPANINAVARKU_GUI_HANDLER_H
#define SYPANINAVARKU_GUI_HANDLER_H

#include <gtk/gtk.h>

void exit_app();

void add_slad(GtkWidget *slady_box,gpointer data);

void evaluate(GtkWidget *widget, int* count);

void evaluate_to_txt(GtkWidget *widget, int* count);


#endif //SYPANINAVARKU_GUI_HANDLER_H
