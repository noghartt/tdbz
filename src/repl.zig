const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();

    var buffer: [1024]u8 = undefined;

    while (true) {
        try stdout.writeAll("> ");

        const input = try stdin.reader().readUntilDelimiter(&buffer, '\n');
        if (std.mem.eql(u8, input, ".exit")) {
            try stdout.writeAll("See ya! :)");
            break;
        }

        try stdout.writer().print("{s}\n", .{input});
    }
}
