const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

var count = std.atomic.Value(usize).init(0);

fn print() void {
    const current = count.load(.seq_cst);
    std.debug.print("count: {any}\n", .{current});
}

fn printInLoop() !void {
    while (true) {
        print();
    }
}

fn incrementInLoop() !void {
    for (0..100000) |_| {
        _ = count.fetchAdd(1, .seq_cst);
    }
}

pub fn main() !void {
    const thread_1 = try std.Thread.spawn(.{}, printInLoop, .{});
    const thread_2 = try std.Thread.spawn(.{}, printInLoop, .{});
    const thread_3 = try std.Thread.spawn(.{}, printInLoop, .{});
    const thread_4 = try std.Thread.spawn(.{}, incrementInLoop, .{});
    const thread_5 = try std.Thread.spawn(.{}, incrementInLoop, .{});
    thread_1.detach();
    thread_2.detach();
    thread_3.detach();
    thread_4.join();
    thread_5.join();
    std.debug.print("count result: {any}\n", .{count});
}
