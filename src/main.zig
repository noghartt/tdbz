const std = @import("std");

const repl = @import("repl.zig");

const TdbzErrors = error{CommandUnavailable};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const args = try get_process_args(allocator);

    const command = args.items[0];

    if (std.mem.eql(u8, command, "repl")) {
        try repl.repl_start();
        return;
    }

    return TdbzErrors.CommandUnavailable;
}

fn get_process_args(allocator: std.mem.Allocator) !std.ArrayList([]const u8) {
    var args_list = std.ArrayList([]const u8).init(allocator);
    errdefer args_list.deinit();

    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    _ = args.skip();

    while (args.next()) |arg| {
        try args_list.append(arg);
    }

    return args_list;
}
