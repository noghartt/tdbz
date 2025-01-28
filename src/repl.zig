const std = @import("std");

const ReplError = error{UnrecognizedCommand};

pub fn repl_start() !void {
    const stdin = std.io.getStdIn();
    const stdout = std.io.getStdOut();

    var buffer: [1024]u8 = undefined;

    while (true) {
        try stdout.writeAll("> ");

        const input = try stdin.reader().readUntilDelimiter(&buffer, '\n');
        if (input[0] == '.') {
            const command = input.ptr[1..input.len];
            return execute_meta_command(command);
        }

        try stdout.writer().print("{s}\n", .{input});
    }
}

fn execute_meta_command(command: []u8) !void {
    if (std.mem.eql(u8, command, "exit")) {
        std.debug.print("See ya! :)\n", .{});
        return;
    }

    return ReplError.UnrecognizedCommand;
}
