const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;

pub fn main() !void {
    const array_1 = [_]u8{ 1, 2, 3, 4 };
    const array_2 = [_]u8{ 1, 2, 3, 4 };
    const vector_1: @Vector(4, u8) = array_1;
    const vector_2: @Vector(2, u8) = array_2[0..2].*;
    std.debug.print("vector 1: {any}\n", .{vector_1});
    std.debug.print("vector 2: {any}\n", .{vector_2});
}
