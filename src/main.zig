const std = @import("std");
const gtk = @import("gtk.zig");

fn activate(app: gtk.GtkApplicationPtr, _: *anyopaque) callconv(.C) void {
    var window = gtk.gtk_application_window_new(app);
    gtk.gtk_widget_show_all(window);
}

pub fn main() !void {
    gtk.debug.print_type_sizes();
    gtk.debug.print_fn_addresses();

    std.debug.print("App startup\n", .{});
    var app_name: gtk.g_str = "jeysym.zig-game";
    var app_flags = gtk.GApplicationFlags.none;
    var app_opt = gtk.gtk_application_new(app_name, app_flags);
    std.debug.print("App was created\n", .{});
    defer gtk.g_object_unref(app_opt);

    if (app_opt) |app| {
        _ = gtk.g_signal_connect(app, "activate", @ptrCast(&activate), null);
        _ = gtk.g_application_run(app, 0, null);
    } else {
        std.debug.print("GTK app could not be created!\n", .{});
    }
}
