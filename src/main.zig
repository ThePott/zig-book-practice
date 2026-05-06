const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

var count: usize = 0;

fn increase(io: std.Io, mutex: *std.Io.Mutex) !void {
    var index: usize = 0;
    while (index < 100000) : (index += 1) {
        try mutex.lock(io);
        count += 1;
        mutex.unlock(io);
    }
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var mutex = std.Io.Mutex.init;
    const thread_1 = try std.Thread.spawn(.{}, increase, .{ io, &mutex });
    const thread_2 = try std.Thread.spawn(.{}, increase, .{ io, &mutex });
    thread_1.join();
    thread_2.join();
    std.debug.print("count: {any}\n", .{count});
}
