const std = @import("std");
var stdout_buffer: [1024]u8 = undefined;
var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
const stdout = &stdout_writer.interface;

// next topic
// https://pedropark99.github.io/zig-book/Chapters/03-structs.html#for-loops

pub fn main() !void {
    defer std.debug.print("this always get printed\n", .{});

    const x: u8 = 4;

    if (x < 10) {
        return;
    }

    std.debug.print("this only get printed if not early returned\n", .{});
}
