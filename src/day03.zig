const std = @import("std");
const print = std.debug.print;

const data = @embedFile("../data/day02.txt");

const Direction = enum {
    up,
    forward,
    down,
    number,
};

fn day01() void {
    var iterator = std.mem.tokenize(u8, data, "\r\n ");
    var depth: i32 = 0;
    var distance: i32 = 0;
    var command: Direction = Direction.number;
    while (iterator.next()) |token| {
        switch (command) {
            Direction.up => {
                depth -= std.fmt.parseUnsigned(u16, token, 10) catch @panic("asdf");
                command = Direction.number;
            },
            Direction.down => {
                depth += std.fmt.parseUnsigned(u16, token, 10) catch @panic("asdf");
                command = Direction.number;
            },
            Direction.forward => {
                distance += std.fmt.parseUnsigned(u16, token, 10) catch @panic("asdf");
                command = Direction.number;
            },
            Direction.number => {
                command = std.meta.stringToEnum(Direction, token).?;
            },
        }
    }
    print("Day 02 - depth : {}, distance : {}, multiplied :{}\n", .{ depth, distance, depth * distance });
}

fn day02() void {
    var iterator = std.mem.tokenize(u8, data, "\r\n ");
    var depth: i32 = 0;
    var distance: i32 = 0;
    var aim: i32 = 0;
    var command: Direction = Direction.number;
    while (iterator.next()) |token| {
        switch (command) {
            Direction.up => {
                aim -= std.fmt.parseUnsigned(u16, token, 10) catch @panic("asdf");
                command = Direction.number;
            },
            Direction.down => {
                aim += std.fmt.parseUnsigned(u16, token, 10) catch @panic("asdf");
                command = Direction.number;
            },
            Direction.forward => {
                const f = std.fmt.parseUnsigned(u16, token, 10) catch @panic("asdf");
                distance += f;
                depth += f * aim;
                command = Direction.number;
            },
            Direction.number => {
                command = std.meta.stringToEnum(Direction, token).?;
            },
        }
    }
    print("Day 02 - depth : {}, distance : {}, multiplied :{}\n", .{ depth, distance, depth * distance });
}

pub fn main() !void {
    var timer = try std.time.Timer.start();
    day01();
    var part01 = timer.lap();
    print("Day 02 - part 01 took {:15}ns\n", .{part01});
    timer.reset();
    day02();
    var part02 = timer.lap();
    print("Day 02 - part 02 took {:15}ns\n", .{part02});
    timer.reset();
}
