/*
 * Copyright (c) 2019 Andrew Vojak (https://avojak.com)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Iridium.Application : Gtk.Application {

    public static Iridium.Services.Settings settings;

    private static Iridium.Services.ServerConnectionHandler connection_handler;

    public Application () {
        Object (
            application_id: "com.github.avojak.iridium",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    static construct {
        settings = new Iridium.Services.Settings ();
        connection_handler = new Iridium.Services.ServerConnectionHandler ();
    }

    protected override void activate () {
        var main_window = new Iridium.MainWindow (this, connection_handler);
        main_window.show_all ();

        // TODO: Connect to signals to save window size and position in settings

        // TODO: Use NetworkMonitor to handle lost internet connection

        // TODO: Should this be done before showing the main window?
        restore_state ();
    }

    private void restore_state () {
        var servers = settings.get_servers_list ();
        var channels = settings.get_channels_list ();
        var connection_details = settings.get_connection_details_list ();
    }

    public static int main (string[] args) {
        var app = new Iridium.Application ();
        return app.run (args);
    }

}
