#include <stdio.h>
#include <gtk/gtk.h>

#include "include/gui_handler.h"

int main() {

        GtkWidget *window;
        GtkWidget *main_box;
        GtkWidget *result_label;

        GtkWidget *kvas_nadob_textbox;
        GtkWidget *puvodni_hustota_mladiny_textbox;
        GtkWidget *stupnovitost_mladiny_textbox;
        GtkWidget *efektivita_varny_textbox;

        GtkWidget *slady_box;
        GtkWidget *increase_slady_count_button;

        GtkWidget *evaluate_button;
        GtkWidget *evaluate_to_text_file_button;

        GtkBuilder *builder;
        gtk_init(NULL, NULL);

        builder = gtk_builder_new();
        gtk_builder_add_from_file(builder, "../src/gui/main_window.glade", NULL);

        // load all the widgets from the glade file
        window =
                GTK_WIDGET(gtk_builder_get_object(builder, "main_window"));
        main_box =
                GTK_WIDGET(gtk_builder_get_object(builder, "main_box"));
        result_label =
                GTK_WIDGET(gtk_builder_get_object(builder, "result_label"));
        kvas_nadob_textbox =
                GTK_WIDGET(gtk_builder_get_object(builder, "kvas_nadob_textbox"));
        puvodni_hustota_mladiny_textbox =
                GTK_WIDGET(gtk_builder_get_object(builder, "puvodni_hustota_mladiny_textbox"));
        stupnovitost_mladiny_textbox =
                GTK_WIDGET(gtk_builder_get_object(builder, "stupnovitost_mladiny_textbox"));
        efektivita_varny_textbox =
                GTK_WIDGET(gtk_builder_get_object(builder, "efektivita_varny_textbox"));
        slady_box =
                GTK_WIDGET(gtk_builder_get_object(builder, "slady_box"));
        increase_slady_count_button =
                GTK_WIDGET(gtk_builder_get_object(builder, "increase_slady_count_button"));
        evaluate_button =
                GTK_WIDGET(gtk_builder_get_object(builder, "evaluate_button"));
        evaluate_to_text_file_button =
                GTK_WIDGET(gtk_builder_get_object(builder, "evaluate_to_text_file_button"));

        gtk_builder_connect_signals(builder, NULL);
        g_object_unref(builder);

        gtk_widget_show_all(window);

        gtk_main();


        return 0;
}
