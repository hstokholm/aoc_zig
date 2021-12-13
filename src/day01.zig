const std = @import("std");
const print = std.debug.print;

const data = @embedFile("../data/day01.txt");

fn is_int(c: u8) bool {
    return switch (c) {
        '0'...'9' => return true,
        else => return false,
    };
}

fn day01() void {
    var index: usize = 0;
    var start: usize = 0;
    var increases: usize = 0;
    var prev: u16 = std.math.maxInt(u16);
    while (index <= data.len) : (index += 1) {
        if (is_int(data[index]) and (index != data.len)) continue;
        if (index <= start) continue;
        var current = std.fmt.parseUnsigned(u16, data[start..index], 10) catch @panic("Wuut!");
        if (current > prev)
            increases += 1;

        prev = current;
        start = index + 2;
    }
    print("Day 01 - Depth increases {}\n", .{increases});
}

fn day02() void {
    var index: usize = 0;
    var start: usize = 0;
    var increases: usize = 0;
    var prev = [_]u16{0} ** 3;
    
    var found: usize = 0;

    while (index <= data.len) : (index += 1) {
        if (is_int(data[index]) and (index != data.len)) continue;
        if (index <= start) continue;
        var current = std.fmt.parseUnsigned(u16, data[start..index], 10) catch @panic("Wuut!");

        if(found < 3) {
            prev[found] = current;
        } else {
            var old = prev[0] + prev[1] + prev[2];
            prev[found%3] = current;
            if(old<prev[0] + prev[1] + prev[2]) increases += 1;
        }
        found += 1;

        start = index + 2;
    }
    print("Day 02 - Depth increases {}\n", .{increases});

}

pub fn main() !void {
    var timer = try std.time.Timer.start();
    day01();
    var part01 = timer.lap();
    print("Day 01 - part 01 took {:15}ns\n", .{part01});
    timer.reset();
    day02();
    var part02 = timer.lap();
    print("Day 01 - part 02 took {:15}ns\n", .{part02});
}
