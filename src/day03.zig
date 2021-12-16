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
    var epsilon: i23 = 0;
    while (idx < 12) : (idx += 1) {
        gamma <<= 1;
        epsilon <<= 1;
        if (counts[idx] > 0) {
            gamma |= 1;
        } else {
            epsilon |= 1;
        }
    }
    print("Day 03 - Gamma : {d}, Epsilon : {d}, Mul : {d}\n", .{ gamma, epsilon, gamma * epsilon });
}

fn day02() void {
    var iterator = std.mem.tokenize(u8, data, "\r\n ");
    var oxygen = std.StaticBitSet(1000).initFull();

    var oxygen_line_idx: usize = 1001;

    var idx: usize = 0;
    while (idx < 12 and oxygen_line_idx > 1000) : (idx += 1) {
        iterator.reset();

        // find the most common bit
        var count: i32 = 0;
        var line_idx: usize = 0;
        while (iterator.next()) |token| {
            if (token.len >= 12) {
                if (oxygen.isSet(line_idx)) {
                    if (token[idx] == '1') {
                        count += 1;
                    } else {
                        count -= 1;
                    }
                }
                line_idx += 1;
            }
        }

        iterator.reset();
        line_idx = 0;
        while (iterator.next()) |token| {
            if (token.len >= 12) {
                if (oxygen.isSet(line_idx)) {
                    switch (token[idx]) {
                        '0' => {
                            if (count >= 0) oxygen.unset(line_idx);
                        },
                        '1' => {
                            if (count < 0) oxygen.unset(line_idx);
                        },
                        else => @panic(""),
                    }
                }
                line_idx += 1;
            }
        }
        if (oxygen.count() == 1) {
            if (oxygen.findFirstSet()) |val| {
                oxygen_line_idx = val;
            }
        }
    }

    var co2 = std.StaticBitSet(1000).initFull();

    var co2_line_idx: usize = 1001;

    idx = 0;
    while (idx < 12 and co2_line_idx > 1000) : (idx += 1) {
        iterator.reset();

        // find the most common bit
        var count: i32 = 0;
        var line_idx: usize = 0;
        while (iterator.next()) |token| {
            if (token.len >= 12) {
                if (co2.isSet(line_idx)) {
                    if (token[idx] == '1') {
                        count += 1;
                    } else {
                        count -= 1;
                    }
                }
                line_idx += 1;
            }
        }

        iterator.reset();
        line_idx = 0;
        while (iterator.next()) |token| {
            if (token.len >= 12) {
                if (co2.isSet(line_idx)) {
                    switch (token[idx]) {
                        '0' => {
                            if (count < 0) co2.unset(line_idx);
                        },
                        '1' => {
                            if (count >= 0) co2.unset(line_idx);
                        },
                        else => @panic(""),
                    }
                }
                line_idx += 1;
            }
        }
        if (co2.count() == 1) {
            if (co2.findFirstSet()) |val| {
                co2_line_idx = val;
            }
        }
    }
    iterator.reset();
    var line_idx: usize = 0;

    var oxygen_value: u32 = 0;
    var co2_value: u32 = 0;

    while (iterator.next()) |token| {
        if (line_idx == oxygen_line_idx) {
            oxygen_value = std.fmt.parseUnsigned(u32, token, 2) catch @panic("Wuut!");
        }

        if (line_idx == co2_line_idx) {
            co2_value = std.fmt.parseUnsigned(u32, token, 2) catch @panic("Wuut!");
        }
        line_idx += 1;
    }

    print("Day 03 - oxygen line {d}\n", .{oxygen_line_idx});
    print("Day 03 - co2 line {d}\n", .{co2_line_idx});
    print("Day 03 - oxygen {d}\n", .{oxygen_value});
    print("Day 03 - co2 {d}\n", .{co2_value});
    print("Day 03 - life support {d}\n", .{oxygen_value * co2_value});
}

pub fn main() !void {
    var timer = try std.time.Timer.start();
    day01();
    var part01 = timer.lap();
    print("Day 03 - part 01 took {:15}ns\n", .{part01});
    timer.reset();
    day02();
    var part02 = timer.lap();
    print("Day 03 - part 02 took {:15}ns\n", .{part02});
}
