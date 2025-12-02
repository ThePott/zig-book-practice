const std = @import("std");
var stdout_buffer: [1024]u8 = undefined;
var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
const stdout = &stdout_writer.interface;

pub fn main() !void {
    const str: []const u8 = "A string value";
    try stdout.print("{any}\n", .{@TypeOf(str)});
    // 여기서 슬라이스 안의 각 원소가 어떻게 생겨먹었는지 for loop 으로 확인해야 한다
    // null terminator가 길이로 바뀌었나??
    try stdout.flush();
}
