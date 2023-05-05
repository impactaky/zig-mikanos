const uefi = @import("std").os.uefi;

fn UTF16(comptime str: []const u8) [str.len:0]u16 {
    var utf16: [str.len:0]u16 = undefined;
    for (str) |rune, i| {
        utf16[i] = rune;
    }
    return utf16;
}

pub fn main() void {
    const con_out = uefi.system_table.con_out.?;
    _ = con_out.reset(false);
    _ = con_out.outputString(&UTF16("Hello, Mikan World!\r\n"));
    const boot_services = uefi.system_table.boot_services.?;
    _ = boot_services.stall(5 * 1000 * 1000);
}
