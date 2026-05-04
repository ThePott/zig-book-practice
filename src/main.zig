const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn main() !void {}

test "open dir and iterate to print name" {
    std.testing.log_level = .debug;
    const io = std.testing.io;

    const cwd = std.Io.Dir.cwd();
    const src_dir = try cwd.openDir(io, "./src", .{ .iterate = true });
    defer src_dir.close(io);
    var iterator = src_dir.iterate();

    while (try iterator.next(io)) |entry| {
        const file_name = entry.name;
        std.log.debug("file name: {s}\n", .{file_name});
    }
}
