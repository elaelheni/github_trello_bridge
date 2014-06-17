# Copyright (C) 2014  CODE3 Coopérative de solidarité
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

async = require 'async'
program = require 'commander'
Trello = require 'node-trello'

TRELLO_API_KEY = process.env.TRELLO_API_KEY
TRELLO_WRITE_ACCESS_TOKEN = process.env.TRELLO_WRITE_ACCESS_TOKEN

program
  .version '0.0.1'
  .option '-u, --trello_username <value>', 'Trello username'
  .parse process.argv

trello = new Trello(TRELLO_API_KEY, TRELLO_WRITE_ACCESS_TOKEN)

trello.get "/1/members/#{program.trello_username}/boards", (err, boards) ->
  async.each boards, (board, callback) ->
    trello.get "/1/boards/#{board.id}/lists", (err, lists) ->
      console.log "#{board.name} (id: #{board.id})"
      for list in lists
        console.log "  - #{list.name} (id: #{list.id})"