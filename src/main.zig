const std = @import("std");
// const gtk = @import("gtk.zig");
const x = @import("xlib.zig");

// fn activate(app: gtk.GtkApplicationPtr, _: *anyopaque) callconv(.C) void {
//     var window = gtk.gtk_application_window_new(app);
//     gtk.gtk_widget_show_all(window);
// }

pub fn main() !void {
    // gtk.debug.print_type_sizes();
    // gtk.debug.print_fn_addresses();

    // std.debug.print("App startup\n", .{});
    // var app_name: gtk.g_str = "jeysym.zig-game";
    // var app_flags = gtk.GApplicationFlags.none;
    // var app_opt = gtk.gtk_application_new(app_name, app_flags);
    // std.debug.print("App was created\n", .{});
    // defer gtk.g_object_unref(app_opt);

    // if (app_opt) |app| {
    //     _ = gtk.g_signal_connect(app, "activate", @ptrCast(&activate), null);
    //     _ = gtk.g_application_run(app, 0, null);
    // } else {
    //     std.debug.print("GTK app could not be created!\n", .{});
    // }

    const display = x.XOpenDisplay(null);
    const root: x.Window = x.DefaultRootWindow(display);
    //const visual = x.XDefaultVisual(display, x.XDefaultScreen(display));
    // const visual = x.glX
    const window = x.XCreateWindow(display, root, 0, 0, 500, 500, 0, x.CopyFromParent, x.InputOutput, x.CopyFromParent, 0, null);
    _ = x.XMapWindow(display, window);
    _ = x.XStoreName(display, window, "JEY APPLICATION");

    var event: x.XEvent = undefined;
    while (true) {
        _ = x.XNextEvent(display, &event);

        if (event.type == x.KeyPress) {
            _ = x.XDestroyWindow(display, window);
            _ = x.XCloseDisplay(display);
            break;
        }
    }
}
