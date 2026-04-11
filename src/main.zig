const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn main() void {
    // const cwd = std.Io.Dir.cwd();
    // const file = cwd.openFile(init.io, "doesnt_exist.txt", .{}) catch |err| {
    //     std.debug.print("this is what I got: {any}\n", .{err});
    //     return err;
    // };
    // _ = file;
}

// fn leakMemory(allocator: Allocator) !void {
//     const buffer = try allocator.alloc(u8, 10);
//     _ = buffer;
//     std.debug.print("this is good\n", .{});
// }
// test "leak memory detected?" {
//     const allocator = std.testing.allocator;
//     try leakMemory(allocator);
// }

fn alloc100(allocator: Allocator) !void {
    const buffer = try allocator.alloc(u8, 100);
    defer allocator.free(buffer);
    buffer[0] = 2;
}
test "pass wrong allocator" {
    var buffer: [10]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    try std.testing.expectError(error.OutOfMemory, alloc100(allocator));
    // 정상적으로 오류가 나면 테스트 통과함
    // try alloc100(allocator);
}

// const OrderedError = error{ FirstError, SecondError };
// fn alwaysPanic() OrderedError!void {
//     @panic("what error is this");
// }
// test "when panic what error" {
//     const what_error = try alwaysPanic();
//     std.debug.print("{any}\n", .{what_error});
// }

test "twick array list" {
    var debugAllocator = std.heap.DebugAllocator(.{}).init;
    const allocator = debugAllocator.allocator();
    var array_list = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer array_list.deinit(allocator);

    try array_list.append(allocator, 'h');
    try array_list.append(allocator, 'e');
    try array_list.append(allocator, 'l');
    try array_list.append(allocator, 'l');
    try array_list.append(allocator, 'o');
    try array_list.append(allocator, ' ');
    try array_list.appendSlice(allocator, "world");

    std.debug.print("this is {s}\n", .{array_list.items});
}
