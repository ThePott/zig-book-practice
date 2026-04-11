const std = @import("std");
const math = std.math;

pub const Vec3 = struct {
    x: f64,
    y: f64,
    z: f64,

    pub fn distance(self: Vec3, other: Vec3) f64 {
        const xd = math.pow(f64, self.x - other.x, 2.0);
        const yd = math.pow(f64, self.y - other.y, 2.0);
        const zd = math.pow(f64, self.z - other.z, 2.0);
        return math.sqrt(xd + yd + zd);
    }

    pub fn twice(self: *Vec3) void {
        self.x = self.x * 2;
        self.y = self.y * 2;
        self.z = self.z * 2;
    }
};
