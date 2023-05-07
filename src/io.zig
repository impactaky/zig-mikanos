const uefi = @import("std").os.uefi;
const fmt = @import("std").fmt;

var con_out: *uefi.protocols.SimpleTextOutputProtocol = undefined;

pub fn reset(verify: bool) uefi.Status {
    return con_out.reset(verify);
}

pub fn init(verify: bool) uefi.Status {
    con_out = uefi.system_table.con_out.?;
    return reset(verify);
}

fn puts(msg: []const u8) void {
    for (msg) |c| {
        const c_ = [2]u16{ c, 0 }; // work around https://github.com/ziglang/zig/issues/4372
        _ = con_out.outputString(@ptrCast(*const [1:0]u16, &c_));
    }
}

// TODO avoid pass buf and initialize
pub fn print(buf: []u8, comptime format: []const u8, args: anytype) void {
    puts(fmt.bufPrint(buf, format, args) catch unreachable);
}
