const std = @import("std");

pub const gchar = u8;
pub const g_str = [*:0]const gchar;

pub const GApplicationFlags = enum(c_int) {
    none = 0,
};

pub const GConnectFlags = enum(c_int) {
    none = 0,
};

pub const GtkApplicationPtr = ?*anyopaque;
pub const GtkWidgetPtr = ?*anyopaque;
pub const GObjectPtr = ?*anyopaque;
pub const GClosurePtr = ?*anyopaque;

pub const GCallback = ?*const fn (void) void;
pub const GClosureNotify = ?*const fn (GObjectPtr, GClosurePtr) void;

pub extern fn gtk_application_new(id: g_str, flags: GApplicationFlags) GtkApplicationPtr;
pub extern fn g_signal_connect_data(instance: GObjectPtr, signal: g_str, handler: GCallback, data: GObjectPtr, destroy_data: GClosureNotify, flags: GConnectFlags) c_ulong;
pub extern fn g_application_run(app: GtkApplicationPtr, argc: c_int, argv: ?[*]g_str) c_int;
pub extern fn g_object_unref(object: GObjectPtr) void;
pub extern fn gtk_application_window_new(app: GtkApplicationPtr) GtkWidgetPtr;
pub extern fn gtk_widget_show_all(widget: GtkWidgetPtr) void;

pub fn g_signal_connect(instance: GObjectPtr, detailed_signal: g_str, c_handler: GCallback, data: GObjectPtr) c_ulong {
    return g_signal_connect_data(instance, detailed_signal, c_handler, data, null, GConnectFlags.none);
}

pub const debug = struct {
    fn print_type_size(comptime T: type) void {
        std.debug.print("{s} | size={}\n", .{ @typeName(T), @sizeOf(T) });
    }

    pub fn print_type_sizes() void {
        std.debug.print("==== GTK TYPES SIZES =======\n", .{});
        print_type_size(GApplicationFlags);
        print_type_size(GConnectFlags);
        print_type_size(GObjectPtr);
        std.debug.print("============================\n\n", .{});
    }

    pub fn print_fn_addresses() void {
        std.debug.print("= GTK FUNCTION ADDRESSES ===\n", .{});
        std.debug.print("gtk_application_new        = {}\n", .{&gtk_application_new});
        std.debug.print("g_signal_connect_data      = {}\n", .{&g_signal_connect_data});
        std.debug.print("g_application_run          = {}\n", .{&g_application_run});
        std.debug.print("g_object_unref             = {}\n", .{&g_object_unref});
        std.debug.print("gtk_application_window_new = {}\n", .{&gtk_application_window_new});
        std.debug.print("gtk_widget_show_all        = {}\n", .{&gtk_widget_show_all});
        std.debug.print("============================\n\n", .{});
    }
};
