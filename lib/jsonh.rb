=begin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
=end

require 'json'

module JSONH

  class << self

    def pack( ah ) 
      [ ah.first.keys.size, *ah.first.keys, *ah.map( &:values ).flatten( 1 ) ]
    end

    def unpack hlist
      result = [ ] 

      hlist[ hlist.first + 1, hlist.size ].each_slice( hlist.first ) do |s|
        result << Hash[ hlist[ 1, hlist.first ].zip( s ) ]
      end

      result
    end

    def dump obj
      pack( obj ).to_json
    end


    def load obj
      unpack( JSON.load( obj ) )
    end

  end

end


class Array 

  def pack_jsonh
    JSONH.pack( self )
  end

  def unpack_jsonh
    JSONH.unpack( self )
  end

end

