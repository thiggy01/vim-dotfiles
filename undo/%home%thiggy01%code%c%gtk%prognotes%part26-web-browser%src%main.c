Vim�UnDo� ��D$�L����^X�rF,J!XÞ��	ٙ�˴   5                                  ^��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             ^��     �              .   #include <gtk/gtk.h>       E// Custom structure that holds pointers to widgets and user variables   typedef struct {   $    // Add pointers to widgets below       //GtkWidget *w_x;   } app_widgets;        int main(int argc, char *argv[])   {       GtkBuilder      *builder;        GtkWidget       *window;   6    // Instantiate structure, allocating memory for it   8    app_widgets     *widgets = g_slice_new(app_widgets);              gtk_init(&argc, &argv);       C    builder = gtk_builder_new_from_file("glade/window_main.glade");       H    window = GTK_WIDGET(gtk_builder_get_object(builder, "window_main"));   #    // Get pointers to widgets here   G    //widgets->w_x  = GTK_WIDGET(gtk_builder_get_object(builder, "x"));          ]     // Widgets pointer are passed to all widget handler functions as the user_data parameter   2    gtk_builder_connect_signals(builder, widgets);           g_object_unref(builder);       0    gtk_widget_show_all(window);                       gtk_main();   &    // Free up widget structure memory   '    g_slice_free(app_widgets, widgets);           return 0;   }       // Dummy handler function   3/*void x(GtkButton *button, app_widgets *app_wdgts)   {   }*/       // called when window is closed   void on_window_main_destroy()   {       gtk_main_quit();   }5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             ^��    �                   �               5��