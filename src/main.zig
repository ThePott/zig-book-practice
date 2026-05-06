const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

const duration = std.Io.Duration.fromSeconds(1);
const clock = std.Io.Clock.awake;
fn sleep(io: std.Io) !void {
    try std.Io.sleep(io, duration, clock);
}

var count: usize = 0;
fn print() void {
    std.debug.print("count: {any}\n", .{count});
}

fn printInLoop(io: std.Io, read_write_lock: *std.Io.RwLock) !void {
    while (true) {
        try read_write_lock.lockShared(io);
        print();
        read_write_lock.unlockShared(io);
        // try sleep(io);
    }
}

fn incrementInLoop(io: std.Io, read_write_lock: *std.Io.RwLock) !void {
    for (0..1000000) |_| {
        try read_write_lock.lock(io);
        count += 1;
        read_write_lock.unlock(io);
        // try sleep(io);
    }
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var read_write_lock = std.Io.RwLock.init;
    const thread_1 = try std.Thread.spawn(.{}, printInLoop, .{ io, &read_write_lock });
    const thread_2 = try std.Thread.spawn(.{}, printInLoop, .{ io, &read_write_lock });
    const thread_3 = try std.Thread.spawn(.{}, printInLoop, .{ io, &read_write_lock });
    const thread_4 = try std.Thread.spawn(.{}, incrementInLoop, .{ io, &read_write_lock });
    const thread_5 = try std.Thread.spawn(.{}, incrementInLoop, .{ io, &read_write_lock });
    thread_1.detach();
    thread_2.detach();
    thread_3.detach();
    thread_4.join();
    thread_5.join();
    std.debug.print("count result: {any}\n", .{count});
}
