const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn main() !void {}

test "testing reading file" {
    std.testing.log_level = .warn;

    const io = std.testing.io;
    const cwd = std.Io.Dir.cwd();

    const file = try cwd.openFile(
        io,
        "text-file.md",
        .{ .mode = .read_only },
    );
    defer file.close(io);

    var reader_buffer: [1024]u8 = undefined;
    var file_reader = file.reader(io, &reader_buffer);
    const reader = &file_reader.interface;

    var print_buffer: [1024]u8 = undefined;
    @memset(&print_buffer, 0);

    const content_length = try reader.readSliceShort(&print_buffer);
    std.log.debug("content length: {any}\n", .{content_length});

    std.log.debug("file content: {s}\n", .{print_buffer});
}

test "testing creating file" {
    std.testing.log_level = .debug;

    const io = std.testing.io;
    const cwd = std.Io.Dir.cwd();
    const new_text_file = try cwd.createFile(io, "new-text-file.txt", .{ .read = true });
    defer new_text_file.close(io);
    try new_text_file.writePositionalAll(io, "this is file content that I have wrote", 0);

    var reader_buffer: [1024]u8 = undefined;
    var file_reader = new_text_file.reader(io, &reader_buffer);
    const reader = &file_reader.interface;

    var print_buffer: [1024]u8 = undefined;
    @memset(&print_buffer, 0);
    const content_length = try reader.readSliceShort(&print_buffer);
    std.log.debug("content length: {any}\n", .{content_length});
    std.log.debug("content: {s}\n", .{print_buffer});
}
