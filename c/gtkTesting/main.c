#include <stdio.h>
#include <gtk/gtk.h>

GtkWidget *window;
GtkLabel *myLabel;

int main()
{
        // spawn a new window and display hello world in it to the user
        // put text widget in the window and display the text
        // then close the window and exit the program
        // use gtk to do this

        // import MainWindow from gui/MainWindow.glade



        GtkBuilder *builder;
        gtk_init(NULL, NULL);

        builder = gtk_builder_new();
        gtk_builder_add_from_file(builder, "../gui/MainWindow.glade", NULL);

        window = GTK_WIDGET(gtk_builder_get_object(builder, "MainWindow"));
        myLabel = GTK_LABEL(gtk_builder_get_object(builder, "myLabel"));

        gtk_builder_connect_signals(builder, NULL);
        g_object_unref(builder);

        gtk_widget_show_all(window);

        gtk_main();

//        gtk_init(NULL, NULL);
//        GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
//        gtk_window_set_title(GTK_WINDOW(window), "Hello World");
//        gtk_window_set_default_size(GTK_WINDOW(window), 200, 200);
//        // add a text widget to the window
//        GtkWidget *text = gtk_label_new("Hello World");
//        gtk_container_add(GTK_CONTAINER(window), text);
//        gtk_widget_show(window);
//        gtk_widget_show(text);
//        g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);
//        gtk_main();


        return 0;
}

void button_clicked()
{
        printf("Button clicked");
        gtk_label_set_text(myLabel, "I likie senpaiii");
}

void exit_app()
{
        gtk_main_quit();
}