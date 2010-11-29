#!/usr/bin/env ruby
#    Rubyripper - A secure ripper for Linux/BSD/OSX
#    Copyright (C) 2007 - 2010  Bouke Woudstra (boukewoudstra@gmail.com)
#
#    This file is part of Rubyripper. Rubyripper is free software: you can 
#    redistribute it and/or modify it under the terms of the GNU General
#    Public License as published by the Free Software Foundation, either 
#    version 3 of the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>

# set the directory of the local installation
$localdir = File.expand_path(File.dirname(File.dirname(__FILE__)))

# Put the local lib directory on top of the ruby default lib search path
$:.insert(0, File.join($localdir, '../lib'))

# Help function for translations
def _(txt)
	return txt
end

# Provide the update function to simulate a user interface
class FakeGui
attr_reader :update
	def initialize
	end
	
	def update(key, value)
		puts value
	end
end

# load two libs that are needed a lot and make one generic instance
require 'rubyripper/settings.rb'
require 'rubyripper/dependency.rb'

$deps = Dependency.new(verbose=false,runtime=false)
$settings = Settings.new($deps,
	File.join($localdir, 'data/settings/settings001')).getSettings()

# define a boolean type to test against
module Boolean; end

# add our new module to the TrueClass
class TrueClass; include Boolean; end

# add our new module to the FalseClass
class FalseClass; include Boolean; end

require 'test/unit'

# Load and run all test scripts
require './TC_dependency.rb'
require './TC_settings.rb'
#require './TC_quickScanDisc.rb'
require './TC_freedbString.rb'
require './TC_scanDiscCdinfo.rb'
require './TC_scanDiscCdparanoia.rb'
require './TC_scanDiscCdrdao.rb'
require './TC_freedbResultParser.rb'
require './TC_getFreedbRecord.rb'
require './TC_saveFreedbRecord.rb'
