const std = @import("std");
const print = std.debug.print;

const data = @embedFile("../data/day03.txt");

fn day01() void {
    var iterator = std.mem.tokenize(u8, data, "\r\n ");

    var counts = [_]i32{0} ** 12;

    while (iterator.next()) |token| {
        if (token.len >= 12) {
            var idx: usize = 0;
            while (idx < 12) : (idx += 1) {
                if (token[idx] == '1') {
                    counts[idx] += 1;
                } else {
                    counts[idx] -= 1;
                }
            }
        }
    }
    var idx: usize = 0;
    var gamma: i23 = 0;
    var epsilon : i23 = 0;
    while (idx < 12) : (idx += 1) {
        gamma <<= 1;
        epsilon <<= 1;
        if(counts[idx] > 0) {
            gamma |= 1;
        } else {
            epsilon |= 1;
        }
        print("{d} ", .{counts[idx]});
    }
        print("\n{d} ", .{gamma});
        print("\n{d}\n ", .{epsilon});
        print("{d}\n", .{gamma*epsilon});
}

pub fn main() !void {
    var timer = try std.time.Timer.start();
    day01();
    var part01 = timer.lap();
    print("Day 02 - part 01 took {:15}ns\n", .{part01});
    timer.reset();
}
