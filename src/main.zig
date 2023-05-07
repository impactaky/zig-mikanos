const uefi = @import("std").os.uefi;
const uefi_io = @import("io.zig");

pub fn main() void {
    _ = uefi_io.init(false);
    var buf: [256]u8 = undefined;
    uefi_io.print(buf[0..], "Hello, Mikan World!\r\n", .{});
    const boot_services = uefi.system_table.boot_services.?;
    _ = boot_services.stall(5 * 1000 * 1000);
}
