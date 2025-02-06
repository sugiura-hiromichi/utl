const std = @import("std");

pub fn main() void {
    const assert = std.debug.assert;
    std.debug.print("0w0, {s}\n", .{"🫠"});

    // assignment
    const c: i32 = 5;
    var v: u32 = 666;
    v -= 1;
    assert(c == 5);
    assert(v == 665);

    // @as performs an explicit type coercion
    const inferred_c = @as(i32, 7);
    var inferred_v = @as(u32, 2525);
    inferred_v += 100;
    assert(inferred_c == 7);
    assert(inferred_v == 2625);

    // undefined is value
    const a: i8 = undefined;
    var b: i64 = undefined;
    b = a;

    // arrays
    const ary = [4]u8{ '2', '5', '2', '5' };
    const ary2 = [_]u8{ '5', '9', '5', '9' };
    const len = ary2.len;
    assert(ary.len == len);
}

const expect = std.testing.expect;

test "always succeeds" {
    try expect(true);
    //expect(true);
    try expect(true);
}

test "if statement" {
    const a = true;
    var x: u16 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "if statement as expression" {
    const a = false;
    const x: u16 = if (a) 2 else 5;
    try expect(x == 5);
}

test "while" {
    var i: u8 = 1;
    while (i < 100) {
        i *= 2;
    }
    try expect(i == 128);
}

test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i < 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 45 and i == 10);
}

test "while with continue" {
    var sum: u16 = 1;
    var i: u8 = 0;

    while (i < 10) : (i += 1) {
        if (i == 5) {
            continue;
        }
        sum *= i;
    }
    try expect(sum == 0);
}

test "while with break" {
    var sum: u16 = 1;
    var i: u8 = 1;
    while (i < 10) : (i += 2) {
        if (i > 5) {
            break;
        }
        sum *= i;
    }
    try expect(sum == 3 * 5);
}

test "for" {
    const string = [_]u8{ 'a', 'i' };

    for (string, 0..) |character, i| {
        _ = character;
        _ = i;
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, i| {
        _ = i;
    }

    for (string) |_| {}
}

fn fnIsCamelCase(x: u32) u32 {
    // uncomment line below will cause error that `error: cannot assign to constant`
    //x += 1;
    return x - x;
}

test "function" {
    const x = fnIsCamelCase(0);
    try expect(@TypeOf(x) == u32);
    try expect(x == 0);
}

fn recursionIsAllowed(n: u16) u16 {
    if (n < 2) {
        return 1;
    }
    return recursionIsAllowed(n - 1) + recursionIsAllowed(n - 2);
}

test "function recursion" {
    const x = recursionIsAllowed(7);
    try expect(21 == x);
}

test "defer" {
    var x: i16 = 5;
    {
        defer x -= 6;
        // uncomment line below will cause error
        // try expect(false);
        try expect(x == 5);
    }
    try expect(x == -1);
}

test "multi defer" {
    var x: i32 = 5;
    {
        defer x -= 2;
        try expect(x == 5);
        defer x *= -2;
        try expect(x == 5);
    }
    try expect(x == -12);
}

const FileOpenError = error{ AccessDenied, OutOfMemory, FileNotFound };

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

fn failingFn() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFn() catch |e| {
        try expect(e == error.Oops);
        return;
    };
}

fn failFn() error{Oops}!i32 {
    try failingFn();
    return 12;
}

test "try" {
    const v = failFn() catch |e| {
        try expect(e == error.Oops);
        return;
    };
    try expect(v == 12); // unreachable
}

var problems: u32 = 98;
fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFn();
    errdefer problems += 1;
}

test "errdefer" {
    failFnCounter() catch |e| {
        try expect(e == error.Oops);
        try expect(problems == 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();
    _ = x catch {};
}

// error sets can be merged
// const a = error{ NotDir, PathNotFound };
// const b = error{ OutOfMemory, PathNotFound };
// const c = a || b;

test "switch statement" {
    var x: i8 = 10;
    switch (x) {
        -1...1 => {
            x = -x;
        },
        10, 100 => {
            x = @divExact(x, 10);
        },
        else => {},
    }
    try expect(x == 1);
}

test "switch expression" {
    var x: i8 = 10;
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    try expect(x == 1);
}

// test "out of bounds" {
//     const a = [3]u8{ 1, 2, 3 };
//     var idx: u8 = 5;
//     const b = a[idx];
//
//     _ = b;
//     idx = idx;
// }
//
// test "out of bounds, no safety" {
//     @setRuntimeSafety(false);
//     const a = [3]u8{ 1, 2, 3 };
//     var idx: u8 = 5;
//     const b = a[idx];
//
//     _ = b;
//     idx = idx;
// }

test "unreachable" {
    const x: i8 = 1;
    const y: u8 = if (x == 1) 3 else unreachable;
    _ = y;
}

fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}

test "unreachable switch" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}

fn increment(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

// test "naughty  pointer" {
//     var x: u16 = 5;
//     x -= 5;
//     const y: *u8 = @ptrFromInt(x);
//     _ = y;
// }

// test "const pointers" {
//     const x: u8 = 0;
//     var y = &x;
//     y.* += 1;
//     y = y;
// }

test "pointer sized integers" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}

fn doubleAll(buf: [*]u8, byte_count: usize) void {
    var i: usize = 0;
    while (i < byte_count) : (i += 1) {
        buf[i] *= 2;
    }
}

test "many-item pointers" {
    var buf: [100]u8 = [_]u8{1} ** 100;
    const buf_prt: *[100]u8 = &buf;

    const buf_many_ptr: [*]u8 = buf_prt;
    doubleAll(buf_many_ptr, buf.len);
    for (buf) |byte| {
        try expect(byte == 2);
    }

    const first_elem_ptr: *u8 = &buf_many_ptr[0];
    const first_elem_ptr2: *u8 = @ptrCast(buf_many_ptr);
    try expect(first_elem_ptr == first_elem_ptr2);
}

fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |v| {
        sum += v;
    }
    return sum;
}

test "slices" {
    const ary = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = ary[0..3];
    try expect(total(slice) == 6);
}

test "slices 2" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];
    try expect(@TypeOf(slice) == *const [3]u8);
}

test "slices 3" {
    var ary = [_]u8{ 1, 2, 3, 4, 5, 6 };
    const slice = ary[0..];
    try expect(@TypeOf(slice) == *[6]u8);
    try expect(@sizeOf(@TypeOf(slice)) == @sizeOf(usize));
}

// test "main" {
//     // very cool type
//     const direction: u1 = 0;
//     try expect(direction == 0);
// }

const Direction = enum { north, south, east, west };
test "enum ordinal value" {
    try expect(@intFromEnum(Direction.north) == 0);
    try expect(@intFromEnum(Direction.south) == 1);
    try expect(@intFromEnum(Direction.east) == 2);
    try expect(@intFromEnum(Direction.west) == 3);
}

const Value = enum(u32) { hundred = 100, thousand = 1000, million = 1000000, next };

test "set enum ordinal value" {
    try expect(@intFromEnum(Value.hundred) == 100);
    try expect(@intFromEnum(Value.thousand) == 1000);
    try expect(@intFromEnum(Value.million) == 1000000);
    try expect(@intFromEnum(Value.next) == 1000001);
}

const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};
test "enum method" {
    try expect(Suit.spades.isClubs() == Suit.isClubs(.hearts));
}

const Mode = enum {
    var count: u32 = 0;
    on,
    off,
};

test "hmm" {
    Mode.count += 1;
    try expect(Mode.count == 1);
}

const Vec3 = struct { x: f32, y: f32, z: f32 };
test "struct usage" {
    const my_vec = Vec3{ .x = 0, .y = 100, .z = 666 };
    _ = my_vec;
}

// test "missing struct field" {
//     const my_vec = Vec3{ .x = 25, .z = 25 };
//     _ = my_vec;
// }

const Vec2 = struct { x: f32 = 0, y: f32 = 0 };
test "struct defaults" {
    const my_vec = Vec2{ .x = 3 };
    _ = my_vec;
}

const Stuff = struct {
    x: i32 = 0,
    y: i32 = 10,
    fn swap(self: *Stuff) void {
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};

test "automatic dereference" {
    var thing = Stuff{};
    thing.swap();
    try expect(thing.x == 10);
    try expect(thing.y == 0);
}

// const Result = union { int: i64, float: f64, bool: bool };
// test "simple union" {
//     var rslt = Result{ .int = 1234 };
//     rslt.float = 12.34;
// }

const Tag = enum { a, b, c };
const Tagged = union(Tag) { a: u8, b: f32, c: bool };

test "integer widening" {
    const a: u8 = 250;
    const b: u16 = a;
    const c: u32 = b;
    try expect(c == a);
}

test "@intCast" {
    const x: u64 = 200;
    const y = @as(u8, @intCast(x));
    try expect(@TypeOf(y) == u8);
}

test "well defined overflow" {
    var a: u8 = 255;
    a +%= 1;
    try expect(a == 0);
}

test "float windening" {
    const a: f16 = 0;
    const b: f32 = a;
    const c: f128 = b;
    try expect(c == @as(f128, a));
}

test "int-float conversion" {
    const a: i32 = 0;
    const b = @as(f32, @floatFromInt(a));
    const c = @as(i32, @intFromFloat(b));
    try expect(c == a);
}

test "labelled blocks" {
    const count = blk: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while (i < 10) : (i += 1) {
            sum += i;
        }
        break :blk sum;
    };

    try expect(count == 45);
    try expect(@TypeOf(count) == u32);
}

test "nested continue" {
    var count: usize = 0;
    outer: for (0..7) |_| {
        for (0..5) |_| {
            count += 1;
            if (count == 3) {
                break :outer;
            }
            continue :outer;
        }
    }
    try expect(count == 3);
}

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}

test "while loop expression" {
    try expect(!rangeHasNumber(6, 66, 666));
}

test "optional" {
    var found_idx: ?usize = null;
    const data = [_]i32{ 1, 2, 3, 4, 5, 6, 7 };
    for (data, 0..) |datum, i| {
        if (datum == 8) {
            found_idx = i;
        }
    }
    try expect(found_idx == null);
}

test "orelse" {
    const a: ?f32 = null;
    const fallback: f32 = 0;
    const b = a orelse fallback;
    try expect(b == 0);
    try expect(@TypeOf(b) == f32);
}

test "orelse unreachable" {
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;
    try expect(b == c);
    try expect(@TypeOf(c) == f32);
}

test "if optional payload capture" {
    const a: ?i32 = 5;
    if (a != null) {
        const value = a.?;
        _ = value;
    }

    var b: ?i32 = 7;
    if (b) |*value| {
        value.* += 1;
    }
    try expect(b.? == 8);
}

var numbers_left: u32 = 4;
fn eventuallyNullSequence() ?u32 {
    if (numbers_left == 0) {
        return null;
    }
    numbers_left -= 1;
    return numbers_left;
}

test "while null capture" {
    var sum: u32 = 0;
    while (eventuallyNullSequence()) |value| {
        sum += value;
    }
    try expect(sum == 6);
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "comptime blocks" {
    var x = comptime fibonacci(7);
    try expect(x == 13);
    x = comptime blk: {
        break :blk fibonacci(8);
    };
    try expect(21 == x);
}

test "comptime_int" {
    const a = 12;
    const b = a + 10;

    const c: u4 = a;
    const d: f32 = b;
    try expect(c == 12);
    try expect(d == 22);
}

test "branching on types" {
    const a = 5;
    const b: if (a < 10) f32 else i32 = 5;
    try expect(b == 5);
    try expect(@TypeOf(b) == f32);
}

fn matrix(comptime T: type, comptime width: comptime_int, comptime height: comptime_int) type {
    return [height][width]T;
}

test "returning a type" {
    try expect(matrix(f32, 6, 66) == [66][6]f32);
}

fn addSmallInts(comptime T: type, a: T, b: T) T {
    return switch (@typeInfo(T)) {
        .ComptimeInt => a + b,
        .Int => |info| if (info.bits <= 16) a + b else @compileError("ints too large"),
        else => @compileError("only ints accepted"),
    };
}

test "typeinfo switch" {
    const x = addSmallInts(u16, 20, 30);
    try expect(@TypeOf(x) == u16);
    try expect(x == 50);
}

fn getBiggerInt(comptime T: type) type {
    return @Type(.{ .Int = .{ .bits = @typeInfo(T).Int.bits + 1, .signedness = @typeInfo(T).Int.signedness } });
}

test "@Type" {
    try expect(getBiggerInt(u8) == u9);
    try expect(getBiggerInt(i31) == i32);
}

fn vec(comptime count: comptime_int, comptime T: type) type {
    return struct {
        data: [count]T,
        const Self = @This();

        fn abs(self: Self) Self {
            var tmp = Self{ .data = undefined };
            for (self.data, 0..) |datum, i| {
                tmp.data[i] = if (datum < 0) -datum else datum;
            }
            return tmp;
        }
        fn init(data: [count]T) Self {
            return Self{ .data = data };
        }
    };
}

const mem = @import("std").mem;

test "generic vector" {
    const x = vec(7, f32).init([_]f32{ 2, 5, -2, -5, 2, -5, 2 });
    const y = x.abs();
    try expect(mem.eql(f32, &y.data, &[_]f32{ 2, 5, 2, 5, 2, 5, 2 }));
}

fn plusOne(x: anytype) @TypeOf(x) {
    return x + 1;
}

test "inferred function parameter" {
    try expect(plusOne(@as(u32, 5)) == 6);
}

test "++" {
    const x: [4]u8 = undefined;
    const y = x[0..];

    const a: [6]u8 = undefined;
    const b = a[0..];

    const new = y ++ b;
    try expect(new.len == 10);
}

test "**" {
    const pattern = [_]u8{ 0xcc, 0xaa };
    const memory = pattern ** 3;
    try expect(mem.eql(u8, &memory, &[_]u8{
        0xcc,
        0xaa,
        0xcc,
        0xaa,
        0xcc,
        0xaa,
    }));
}

test "optional-if" {
    const maybe_num: ?usize = 10;
    if (maybe_num) |n| {
        try expect(@TypeOf(n) == usize);
        try expect(n == 10);
    } else {
        unreachable;
    }
}

test "error union if" {
    const ent_num: error{UnknownEntity}!u32 = 6;
    if (ent_num) |entity| {
        try expect(@TypeOf(entity) == u32);
        try expect(entity == 6);
    } else |err| {
        _ = err catch {};
        unreachable;
    }
}

test "while optional" {
    const sequence = [_]?u8{ 0xff, 0xcc, 0x00, null };

    var i: usize = 0;
    while (sequence[i]) |num| : (i += 1) {
        try expect(@TypeOf(num) == u8);
    }

    try expect(i == 3);
    try expect(sequence[i] == null);
}

var numbers_left2: u32 = undefined;

fn eventuallyErrorSequence() !u32 {
    return if (numbers_left2 == 0) error.ReachedZero else blk: {
        numbers_left2 -= 1;
        break :blk numbers_left2;
    };
}

test "while error union capture" {
    var sum: u32 = 0;
    numbers_left2 = 3;
    while (eventuallyErrorSequence()) |val| {
        sum += val;
    } else |err| {
        try expect(err == error.ReachedZero);
    }
}

test "for capture" {
    const x = [_]i8{ 1, 5, 120, -5 };
    for (x) |v| try expect(@TypeOf(v) == i8);
}

const Info = union(enum) { a: u32, b: []const u8, c, d: u32 };

test "switch capture" {
    const b = Info{ .a = 10 };
    const x = switch (b) {
        .b => |str| blk: {
            try expect(@TypeOf(str) == []const u8);
            break :blk 1;
        },
        .c => 2,
        .a, .d => |num| blk: {
            try expect(@TypeOf(num) == u32);
            break :blk num * 2;
        },
    };
    try expect(x == 20);
}

test "for with pointer capture" {
    var data = [_]u8{ 1, 2, 3 };
    for (&data) |*byte| {
        byte.* += 1;
    }
    try expect(mem.eql(u8, &data, &[_]u8{ 2, 3, 4 }));
}

const Window = opaque {};
const Button = opaque {};

// extern fn show_window(*Window) callconv(.C) void;
//
// test "opaque" {
//     const main_window: *Window = undefined;
//     show_window(main_window);
//
//     // invalid type
//     // const ok_button: *Button = undefined;
//     // show_window(ok_button);
// }
