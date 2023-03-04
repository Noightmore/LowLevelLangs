#include "../include/gui_handler.h"

void exit_app()
{
        gtk_main_quit();
}

void add_slad(GtkWidget *widget, gpointer data)
{
        // adds new GtkContainer box to slady_box
        // then adds 2 gtk_entry widgets to the new box
        // then adds 2 gtk_label widgets to the new box
        GtkWidget *slady_box = (GtkWidget*) data;

        GtkWidget *child;
        // increase count of items in slady_box


        child = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
        //gtk_container_add(GTK_CONTAINER(slady_box), child);
        gtk_box_pack_start(GTK_BOX(slady_box), child, FALSE, FALSE, 0);

        gtk_widget_show(child);

}

void evaluate(GtkWidget *widget, int* count)
{
        printf("evaluate() called");
}

void evaluate_to_txt(GtkWidget *widget, int* count)
{
        printf("evaluate_to_txt() called");
}


